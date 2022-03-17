table 50014 GLAccountNVX
{
    fields
    {
        field(1; "G/L Account No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Disc. Dim. Detection"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Discount Dimension Detection', comment = 'DEA="Skonto-Dim.Findung"';
        }
        field(15; "No dim distribution"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No dimensional distribution', comment = 'DEA="Dim.Aufbereitung nicht erlaubt"';
        }
        field(20; "Gen. Bsn. Posting Group Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bsn. Posting Group Type', comment = 'DEA="Art Steuerschlüssel"';
            OptionMembers = Standard,Exchange;
            OptionCaption = 'Standard,Exchange', comment = 'DEA="Standard,Wechsel Steuerschlüssel"';
        }
    }

    keys
    {
        key(PK; "G/L Account No.")
        {
            Clustered = true;
        }
    }
}