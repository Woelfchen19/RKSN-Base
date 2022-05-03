table 50000 AllocationCodeNVX
{
    DataClassification = CustomerContent;
    Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
    LookupPageId = AllocationCodesNVX;
    DrillDownPageId = AllocationCodesNVX;
    fields
    {
        field(1; "Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code', comment = 'DEA="Code"';
        }
        field(2; Description; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            //This field prevents multiple dimensions per allocation
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            CaptionClass = '1,2,2';
        }
        field(10; "Resp. Center"; Code[10])
        {
            Caption = 'Responsibility Center', comment = 'DEA="Zuständigkeitseinheitencode"';
            FieldClass = FlowField;
            CalcFormula = min(AllocCodeRespCenterNVX."Resp. Center" where("Allocation Code" = field(Code)));
            Editable = false;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        InsertDimValue(Rec.Code);
    end;

    trigger OnDelete();
    var
        AllocationHeader: Record AllocationHeaderNVX;
        AllocCodeRespCenter: Record AllocCodeRespCenterNVX;
    begin
        BlockDimValue(Rec.Code);

        AllocCodeRespCenter.Reset();
        AllocCodeRespCenter.SetRange("Allocation Code", Code);
        AllocCodeRespCenter.DeleteAll(true);

        AllocationHeader.Reset();
        AllocationHeader.SetRange("Allocation Code", Code);
        AllocationHeader.DeleteAll(true);
    end;

    local procedure InsertDimValue(AllocationCode: Code[10])
    var
        GLSetup: Record "General Ledger Setup";
        Dimvalue: Record "Dimension Value";
    begin
        GLSetup.Get();
        if not Dimvalue.Get(Glsetup.ShortcutDimension10CodeNVX, Rec.Code) then begin
            Dimvalue.init();
            Dimvalue.Validate("Dimension Code", Glsetup.ShortcutDimension10CodeNVX);
            Dimvalue.Validate(Code, AllocationCode);
            Dimvalue.insert(true);
        end;
    end;

    local procedure BlockDimValue(AllocationCode: Code[10])
    var
        GLSetup: Record "General Ledger Setup";
        Dimvalue: Record "Dimension Value";
    begin
        GLSetup.Get();
        if Dimvalue.Get(Glsetup.ShortcutDimension10CodeNVX, AllocationCode) then begin
            Dimvalue.Blocked := true;
            Dimvalue.Modify(true);
        end;
    end;
}