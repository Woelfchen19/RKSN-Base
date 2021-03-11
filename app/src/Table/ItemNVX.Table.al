table 50026 ItemNVX
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Item No."; Code[20])
        {
            Caption = 'Item No.', comment = 'DEA="Artikelnr."';
            DataClassification = CustomerContent;
        }
        field(10; Activation; Boolean)
        {
            Caption = 'Activation', comment = 'DEA="Aktivierung"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Item No.")
        {
            Clustered = true;
        }
    }
}