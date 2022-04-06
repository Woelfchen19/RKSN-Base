table 50017 GenBsnPstGrpNVX
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code', comment = 'DEA="Code"';
        }
        field(10; "Filter Customer"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Master Data Customer', comment = 'DEA="Filter Stammdaten Debitor"';
        }
        field(11; "Filter Sales Quote"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Sales Quote', comment = 'DEA="Filter Angebot"';
        }
        field(12; "Filter Sales Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Sales Order', comment = 'DEA="Filter Auftrag"';
        }
        field(13; "Filter Sales Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Sales Invoice', comment = 'DEA="Filter Erfassung VK-Rechnung"';
        }
        field(14; "Filter Sales Cr. Memo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Sales Credit Memo', comment = 'DEA="Filter Erfassung VK-Gutschriftsrechnung"';
        }
        field(20; "Filter Vendor"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Master Data Vendor', comment = 'DEA="Filter Stammdaten Kreditor"';
        }
        field(21; "Filter Purchase Quote"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Purchase Quote', comment = 'DEA="Filter Anfrage"';
        }
        field(22; "Filter Purchase Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Purchase Order', comment = 'DEA="Filter Bestellung"';
        }
        field(23; "Filter Purchase Invoice"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Purchase Invoice', comment = 'DEA="Filter Erfassung EK-Rechnung"';
        }
        field(24; "Filter Purchase Cr. Memo"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Purchase Credit Memo', comment = 'DEA="Filter Erfassung EK-Gutschriftsrechnung"';
        }
        field(30; "Filter G/L Account"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter G/L Account', comment = 'DEA="Kontenplan"';
        }
        field(31; "Filter Item Journal"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Filter Item Journal', comment = 'DEA="Artikelbuchblatt"';
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}