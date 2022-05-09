table 50043 "VATPostingTypeNVX"
{
    Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
    LookupPageId = VATPostingTypeNVX;
    DrillDownPageId = VATPostingTypeNVX;
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
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }
}