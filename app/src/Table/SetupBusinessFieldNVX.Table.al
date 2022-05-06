table 50041 "SetupBusinessFieldNVX"
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; CustomerNo; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Customer No.', comment = 'DEA="Debitornr."';
        }
        field(2; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
        }
        field(3; "Shortcut Dimension 9 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
        }
        field(4; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code', comment = 'DEA="Mahnmethodencode"';
            TableRelation = "Reminder Terms";
        }
    }

    keys
    {
        key(Key1; "CustomerNo", "Shortcut Dimension 5 Code")
        {
            Clustered = true;
        }
    }
}