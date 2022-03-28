table 50025 LastEntryNoNVX
{
    DataClassification = CustomerContent;
    //TODO Überarbeiten?
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Entry No.")
        {
            Clustered = true;
        }
    }
}