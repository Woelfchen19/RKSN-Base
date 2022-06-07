table 50049 "SalesReceivablesSetupNVX"
{
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
        }
        field(2; "Customer Posting Group"; Code[20])
        {
            Caption = 'Customer Posting Group', comment = 'DEA="Debitorenbuchungsgruppe"';
            TableRelation = "Customer Posting Group";
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}