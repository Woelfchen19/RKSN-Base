table 50004 VATPostingTypeNVX
{
    DataClassification = CustomerContent;
    Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
    LookupPageId = 50000;
    DrillDownPageId = 50000;
    fields
    {
        field(1;Code;Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Code', comment = 'DEA="Code"';
        }
        field(2;Description;Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
    }
    

    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }
}