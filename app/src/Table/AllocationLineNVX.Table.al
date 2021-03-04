table 50013 AllocationLineNVX
{
    DataClassification = CustomerContent;
    Caption = 'Allocation Line', comment = 'DEA="Verteilungszeile"';
    
    fields
    {
        field(1;"Allocation ID";Guid)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation ID', comment = 'DEA="Verteilungs-ID"';
        }
        field(2;"Line No.";Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(10; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
            CaptionClass = '1,2,1';
        }
        field(11; "Shortcut Dimension 1 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name WHERE("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
        field(15; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
            CaptionClass = '1,2,2';
            Editable = false;
        }
        field(16; "Shortcut Dimension 2 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 2 Name', comment = 'DEA="Shortcutdimensionsname 2"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name WHERE("Global Dimension No." = const(2), Code = field("Shortcut Dimension 2 Code")));
            CaptionClass = '1337,2';
        }
        field(20;"Allocation Quantity";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Quantity', comment = 'DEA="Anzahl Verteilungen"';
        }
        field(21;"Allocation %";Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
        }
    }

    keys
    {
        key(PK;"Allocation ID","Line No.")
        {
            Clustered = true;
        }
    }
}