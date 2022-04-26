table 50001 AllocationHeaderNVX
{
    DataClassification = CustomerContent;
    Caption = 'Allocation Header', comment = 'DEA="Verteilungskopf"';
    DataCaptionFields = "Allocation Code", "Start Date";
    LookupPageId = AllocationListNVX;
    DrillDownPageId = AllocationListNVX;

    fields
    {
        field(1; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
            trigger OnValidate();
            var
                AllocationCode: Record AllocationCodeNVX;
            begin
                if Description = '' then begin
                    AllocationCode.Get("Allocation Code");
                    Description := AllocationCode.Description;
                end;
            end;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
        }
        field(10; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
    }

    keys
    {
        key(PK; "Allocation Code", "Start Date")
        {
            Clustered = true;
        }
    }

    trigger OnDelete();
    var
        AllocationLine: Record AllocationLineNVX;
    begin
        AllocationLine.SetRange("Allocation Code", "Allocation Code");
        AllocationLine.DeleteAll();
    end;

    trigger OnRename();
    var
        AllocationLine: Record AllocationLineNVX;
        TempAllocationLine: Record AllocationLineNVX temporary;
    begin
        AllocationLine.SetRange("Allocation Code", xRec."Allocation Code");
        AllocationLine.SetRange("Start Date", xRec."Start Date");
        if AllocationLine.IsEmpty() then
            exit;

        CreateTempAllocationLine(TempAllocationLine, AllocationLine);
        AllocationLine.DeleteAll();
        RecreateAllocationLine(TempAllocationLine, AllocationLine);
    end;

    local procedure CreateTempAllocationLine(var TempAllocationLine: Record AllocationLineNVX temporary; var AllocationLine: Record AllocationLineNVX)
    begin
        AllocationLine.FindSet();
        repeat
            TempAllocationLine.Init();
            TempAllocationLine := AllocationLine;
            TempAllocationLine.Insert();
        until AllocationLine.Next() = 0;
    end;

    local procedure RecreateAllocationLine(var TempAllocationLine: Record AllocationLineNVX temporary; var AllocationLine: Record AllocationLineNVX)
    begin
        TempAllocationLine.FindSet();
        repeat
            AllocationLine.Init();
            AllocationLine := TempAllocationLine;
            AllocationLine."Allocation Code" := Rec."Allocation Code";
            AllocationLine."Start Date" := Rec."Start Date";
            AllocationLine.Insert();
        until TempAllocationLine.Next() = 0;
    end;
}