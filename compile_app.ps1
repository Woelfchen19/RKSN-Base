# some git commands write in STDERR and not STDOUT so i redirect STDERR
$env:GIT_REDIRECT_STDERR = '2>&1'

function Increase-Version {
    Param(
        [Parameter(Mandatory)]
        [string]$Version,

        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$Major,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$Minor,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$Build,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$Revision,

        [Parameter(Mandatory,ParameterSetName = 'ByString')]
        [ValidateSet('major','minor','build','revision','none')]
        [string]$Which
    )

    $NewVersion = $Version.Split('.')

    if ($Which) {
        switch($Which.ToLower()) {
            "major" { 
                $NewVersion[0] = [string] ([int] $NewVersion[0] + 1) 
                $NewVersion[1] = '0'
                $NewVersion[2] = '0'
                $NewVersion[3] = '0'
            }
            "minor" { 
                $NewVersion[1] = [string] ([int] $NewVersion[1] + 1)
                $NewVersion[2] = '0'
                $NewVersion[3] = '0'
            }
            "build" { 
                $NewVersion[2] = [string] ([int] $NewVersion[2] + 1) 
                $NewVersion[3] = '0'
            }
            "revision" { $NewVersion[3] = [string] ([int] $NewVersion[3] + 1) }
        }

    } else {
        if ($Major.IsPresent) { 
            $NewVersion[0] = [string] ([int] $NewVersion[0] + 1) 
            $NewVersion[1] = '0'
            $NewVersion[2] = '0'
            $NewVersion[3] = '0'
        }
        if ($Minor.IsPresent) { 
            $NewVersion[1] = [string] ([int] $NewVersion[1] + 1) 
            $NewVersion[2] = '0'
            $NewVersion[3] = '0'
        }
        if ($Build.IsPresent) { 
            $NewVersion[2] = [string] ([int] $NewVersion[2] + 1) 
            $NewVersion[3] = '0'
        }
        if ($Revision.IsPresent) { $NewVersion[3] = [string] ([int] $NewVersion[3] + 1) }

    }

    ($NewVersion[0] + '.' + $NewVersion[1] + '.' + $NewVersion[2] + '.' +$NewVersion[3])
}

function Compile-App(){
    Param(
        [Parameter(Mandatory)]
        [string]$appfolder,
        [Parameter(Mandatory)]
        [string]$compilerexe,

        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$VersionMajor,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$VersionMinor,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$VersionBuild,
        [Parameter(Mandatory,ParameterSetName = 'BySwitch')]
        [switch]$VersionRevision,

        [Parameter(Mandatory,ParameterSetName = 'ByString')]
        [ValidateSet('major','minor','build','revision','none')]
        [string]$VersionWhich
    )

    $appjsonpath = Join-Path -Path $appfolder -ChildPath 'app.json'
    $alpackagesfolder = Join-Path -Path $appfolder -ChildPath '.alpackages'

    Write-Host 'Read app.json'
    $app = Get-Content -Raw -Path $appjsonpath | ConvertFrom-Json
    
    # Increase Version and save value in variable
    $oldAppVersion = $app.version
    $app.version = Increase-Version -Version $app.version -Which $VersionWhich

    if ($oldAppVersion -ne $app.version) {
        # Create new branch
        $localbuildbranch = Create-NewLocalBranchName -tagname $app.version.replace('.','_')
        Create-NewLocalBranch -localbuildbranch $localbuildbranch

        Out-File -FilePath $appjsonpath -InputObject @(ConvertTo-Json $app)
    }

    # Compile App - Create .app File
    Write-Host 'Compile App - Create .app File'
    Start-Process -FilePath $compilerexe -ArgumentList('/project:"' + $appfolder + '"'),('/packagecachepath:"' + $alpackagesfolder +'"') -wait -WindowStyle Hidden

    $appfilepath = (Join-path -Path $appfolder -ChildPath ($app.Publisher + '_' + $app.Name + '_' + $app.Version + '.app'))

    # Copy App-file to Staging Directory
    Copy-Item $appfilepath -Destination $env:articatstagingdirectory

    if ($oldAppVersion -ne $app.version) {
        # Commit and Push Changes to the resulting branch
        Push-LocalBranch -localbuildbranch $localbuildbranch -appjsonpath $appjsonpath -tagname $app.version -branchname $env:branchname -appfilepath $appfilepath -deletelocalbuildbranch
    }

    # Set Build Name
    echo "##vso[build.updatebuildnumber]$($app.Name + ' ' + $app.version)"
}

function Create-NewLocalBranchName() {
    Param(
        [Parameter(Mandatory)]
        [string]$tagname
    )    
    $localbuildbranch = 'local_' + $tagname
    $localbuildbranch
}

function Create-NewLocalBranch() {
    Param(
        [Parameter(Mandatory)]
        [string]$localbuildbranch
    )
    # Create new local branch
    if ((git branch).Contains('  ' + $localbuildbranch)) {
        git checkout $localbuildbranch
    } else {
        git checkout -b $localbuildbranch
    }

    # cannot give return values because git command results also returned
}

function Push-LocalBranch() {
    Param(
        [Parameter(Mandatory)]
        [string]$localbuildbranch,
        [Parameter(Mandatory)]
        [string]$appjsonpath,
        [Parameter(Mandatory)]
        [string]$appfilepath,
        [Parameter(Mandatory)]
        [string]$tagname,
        [Parameter(Mandatory)]
        [string]$branchname,
        [switch]$deletelocalbuildbranch
    )
    # Upload changes to repository
    git add $appjsonpath
    git commit -m ("Build Version " + $tagname + " [skip ci]")
    git tag -a $tagname -m ("Build Version " + $tagname + " [skip ci]")

    git push -u 'origin' ($localbuildbranch + ':' + $branchname)
    git push --tags

    if ($deletelocalbuildbranch.IsPresent) {
        git checkout -
        git branch -d $localbuildbranch
    }
}

function Get-AppFileFromServer() {
    ## test ##
    Invoke-WebRequest -Uri "http://srvv135ur19.navax.local:9249/EWW_110_AL_BEKL/dev/packages?publisher=Microsoft&appName=System&versionText=11.0.0.0" -Method Get `
                       -UseDefaultCredentials -OutFile C:\temp\test.app
}

function Update-VSCodeALExtension() {
    Start-Process -FilePath code -ArgumentList('--install-extension ms-dynamics-smb.al'),('--force') -wait -WindowStyle Hidden
}

function Get-VSCodeALExtensionCompilerExe() {
    (Get-ChildItem (Get-ChildItem (Join-path -Path $env:USERPROFILE -ChildPath '.vscode\extensions\') -Filter 'ms-dynamics-smb.al*').FullName -Filter 'alc.exe' -Recurse).FullName
}

function Save-WithBitsTransfer {
    param(
        [Parameter(Mandatory=$true)]
        [string]
        $FileUri,

        [Parameter(Mandatory=$true)]
        [string]
        $Destination,

        [Parameter(Mandatory=$true)]
        [string]
        $AppName
    )

    Write-Host "`nDownloading latest $AppName..." -ForegroundColor Yellow

    Remove-Item -Force $Destination -ErrorAction SilentlyContinue

    $bitsDl = Start-BitsTransfer $FileUri -Destination $Destination -Asynchronous

    while (($bitsDL.JobState -eq 'Transferring') -or ($bitsDL.JobState -eq 'Connecting')) {
        Write-Progress -Activity "Downloading: $AppName" -Status "$([math]::round($bitsDl.BytesTransferred / 1mb))mb / $([math]::round($bitsDl.BytesTotal / 1mb))mb" -PercentComplete ($($bitsDl.BytesTransferred) / $($bitsDl.BytesTotal) * 100 )
    }

    switch ($bitsDl.JobState) {

        'Transferred' {
            Complete-BitsTransfer -BitsJob $bitsDl
            break
        }

        'Error' {
            throw 'Error downloading installation media.'
        }
    }
}

function DownloadAndInstall-VSCode() {
    ## test ##
    $installerPath = [System.IO.Path]::Combine($tmpdir, 'vscode-install.exe')
    $appname = 'Visual Studio Code'
    $fileuri = 'https://vscode-update.azurewebsites.net/latest/win32-x64/stable'

    if ($PSVersionTable.PSVersion.Major -le 5) {
        Save-WithBitsTransfer -FileUri $fileuri -Destination $installerPath -AppName $appname
    }
    # We don't want to use RPM packages -- see the installation step below
    elseif ($codePlatformInfo.Extension -ne 'rpm') {
        if ($PSCmdlet.ShouldProcess($fileuri, "Invoke-WebRequest -OutFile $installerPath")) {
            Invoke-WebRequest -Uri $fileuri -OutFile $installerPath
        }
    }

    $exeArgs = '/verysilent /tasks=addcontextmenufiles,addcontextmenufolders,addtopath'

    if (-not $PSCmdlet.ShouldProcess("$installerPath $exeArgs", 'Start-Process -Wait')) {
        break
    }

    Start-Process -Wait $installerPath -ArgumentList $exeArgs
}


$compilerarchive = $env:COMPILERARCHIVE

if (Get-Item $compilerarchive -ErrorAction Ignore) {
    $compilerfolder = ".\Compiler\"
    $compilerexe = ".\Compiler\bin\alc.exe"

    Write-Host 'Extract Compiler.zip'
    Expand-Archive -Path $compilerarchive -DestinationPath $compilerfolder
} else {

    Write-Host 'Download and Update VS Code and Extension'
    try {
        Start-Process -FilePath 'code' -ArgumentList('--help') -WindowStyle Hidden
    } catch {
        # wenn code --help nicht ausgeführt werden kann lade VSCode herunter 
        Write-Host 'Download and Install VS Code'
        DownloadAndInstall-VSCode
    }
    
    Write-Host 'Update VS Code Extension'
    Update-VSCodeALExtension

    $compilerexe = Get-VSCodeALExtensionCompilerExe
}


$appjsonfiles = Get-ChildItem -Filter 'app.json' -Recurse

foreach ($f in $appjsonfiles) {
    Compile-App -compilerexe $compilerexe -appfolder $f.Directory.FullName -VersionWhich $env:BuildVersion
}

if (Get-Item $compilerarchive -ErrorAction Ignore) {
    # delete compiler
    Remove-Item $compilerfolder -Recurse
}