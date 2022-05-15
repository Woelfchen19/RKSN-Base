table 50007 "DimVATAllocNVX"
{
    DataClassification = CustomerContent;
    LookupPageId = PreviewDimDistrNVX;
    DrillDownPageId = PreviewDimDistrNVX;

    fields
    {
        field(1; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            CaptionClass = '1,2,1';
        }
        field(2; "Shortcut Dimension 1 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
        field(5; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
            CaptionClass = '1,2,2';
        }
        field(6; "Shortcut Dimension 2 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 2 Name', comment = 'DEA="Shortcutdimensionsname 2"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(2), Code = field("Shortcut Dimension 2 Code")));
            CaptionClass = '1337,2';
        }
        field(10; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
        }
        field(11; "Shortcut Dimension 3 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 3 Name', comment = 'DEA="Shortcutdimensionsname 3"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(3), Code = field("Shortcut Dimension 3 Code")));
            CaptionClass = '1337,3';
        }
        field(15; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            CaptionClass = '1,2,4';
        }
        field(16; "Shortcut Dimension 4 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 4 Name', comment = 'DEA="Shortcutdimensionsname 4"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(4), Code = field("Shortcut Dimension 4 Code")));
            CaptionClass = '1337,4';
        }
        field(20; "VAT Posting Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            TableRelation = VATPostingTypeNVX.Code;
            trigger OnValidate();
            begin
                Validate("Shortcut Dimension 3 Code");
            end;

        }
        field(25; "Allocation %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
        }
        field(30; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
        }
    }

    keys
    {
        key(PK; "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Start Date", "Shortcut Dimension 3 Code")
        {
            Clustered = true;
        }
    }
}