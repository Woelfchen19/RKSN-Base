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
        field(15;"Deactivate balance line - Inventory Value Zero";Boolean)
        {
            Caption = 'Deactivate balance line - Inventory Value Zero', comment = 'DEA="Entlastungszeile ohne Wertefluss deaktiviert"';
            DataClassification = CustomerContent;
        }
        field(20;"Deactivate Inventory Gen. Bus. Posting Group";Boolean)
        {
            Caption = 'Deactivate Inventory Gen. Bus. Posting Group', comment = 'DEA=""Steuerschlüssel Lager Einr.deaktivieren""';
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