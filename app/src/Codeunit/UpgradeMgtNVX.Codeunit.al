codeunit 50024 UpgradeMgtNVX
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    begin
        InsertSetupPropertyForField();
    end;

    trigger OnUpgradePerCompany()
    begin
        InitializeDimensionCustomer();
    end;

    local procedure InitializeDimensionCustomer()
    var
        Customer: Record Customer;
        AppMgt: Codeunit AppMgtNVX;
    begin
        if Customer.FindSet() then
            repeat
                AppMgt.InsertPKShortCutdimension(Customer);
                AppMgt.InsertPKDefaultDim(Customer);
            until customer.Next() = 0;
    end;

    local procedure InsertSetupPropertyForField()
    var
        Dimension: Record Dimension;
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: Integer;
        index: Integer;
    begin
        if not SetupPropertyForFields.IsEmpty() then
            exit;

        Initialize();
        Dimension.ChangeCompany('CRONUS AG');

        foreach PageID in Pagelist do begin
            if Dimension.FindSet() then
                repeat
                    SetupPropertyForFields.Init();
                    SetupPropertyForFields."Object ID" := PageID;
                    SetupPropertyForFields.Dimension := Dimension.Code;
                    SetupPropertyForFields.Insert();
                until Dimension.Next() = 0;
            for index := 1 to ArrayLen(GLSetupShortcutDimCode) do begin
                SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetupShortcutDimCode[index]);
                SetupPropertyForFields.IsVisible := true;
                SetupPropertyForFields.Modify();
            end;
        end;
    end;

    local procedure Initialize()
    begin
        GetGLSetup();
        PageList.AddRange(
            20, 25, 29, 38, 39, 40, 41, 42, 43, 44, 46, 47, 62, 95, 96,
            131, 132, 133, 135, 142, 143, 144, 232, 251, 253, 254, 255, 256, 380, 536, 537,
            573, 574, 5628, 5629, 5802, 9300, 9301, 9302, 9305
        );
    end;

    local procedure GetGLSetup()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.ChangeCompany('CRONUS AG');
        GLSetup.Get();
        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
        GLSetupShortcutDimCode[9] := GLSetup.ShortcutDimension9CodeNVX;
        GLSetupShortcutDimCode[10] := GLSetup.ShortcutDimension10CodeNVX;
    end;

    var
        PageList: List of [integer];
        GLSetupShortcutDimCode: array[10] of Code[20];
}