table 50036 SalesLineNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"Document No.";Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4;"Line No.";Integer)
        {
            DataClassification = CustomerContent;            
        }
        field(10;"Allocation Code";Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"Document Type","Document No.","Line No.")
        {
            Clustered = true;
        }
    }
}