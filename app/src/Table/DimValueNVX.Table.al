table 50006 "DimValueNVX"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Dimension Code"; Code[20])
        {
            Caption = 'Dimension Code', comment = 'DEA="Dimensionscode"';
            DataClassification = CustomerContent;
        }
        field(2; "Code"; Code[20])
        {
            Caption = 'Code', comment = 'DEA="Code"';
            DataClassification = CustomerContent;
        }
        field(10; "VAT Posting Type"; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
            TableRelation = VATPostingTypeNVX.Code;
        }
        field(11; "VAT Posting Type Desc"; Text[50])
        {
            CalcFormula = lookup(VATPostingTypeNVX.Description where(Code = field("VAT Posting Type")));
            Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; Assosiated; Code[10])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            DataClassification = CustomerContent;
        }
        field(20; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(21; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(26; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
    }

    keys
    {
        key(PK; "Dimension Code", Code)
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(DimensionCode: Code[20]; DimensionValueCode: Code[20])
    begin
        if ("Dimension Code" = DimensionCode) and
            (Code = DimensionValueCode)
        then
            exit;

        if Get(DimensionCode, DimensionValueCode) then
            exit;

        Init();
        "Dimension Code" := DimensionCode;
        "Code" := DimensionValueCode;
        Insert();
    end;
}