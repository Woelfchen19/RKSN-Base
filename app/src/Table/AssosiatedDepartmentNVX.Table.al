table 50047 "AssosiatedDepartmentNVX"
{
    DataClassification = CustomerContent;
    Caption = 'Assosiated Department', comment = 'DEA="Zugehörig KST"';

    fields
    {
        field(1; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
    }

    keys
    {
        key(PK; "Shortcut Dimension 5 Code", "Shortcut Dimension 1 Code")
        {
            Clustered = true;
        }
    }

}