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

    trigger OnDelete();
    var
        AllocCodeRespCenter: Record AllocCodeRespCenterNVX;
        AllocationHeader: Record AllocationHeaderNVX;
    begin
        AllocCodeRespCenter.Reset();
        AllocCodeRespCenter.SetRange("Allocation Code", Code);
        AllocCodeRespCenter.DeleteAll(true);

        AllocationHeader.Reset();
        AllocationHeader.SetRange("Allocation Code", Code);
        AllocationHeader.DeleteAll(true);
    end;
}