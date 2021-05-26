table 50044 BankAccountLedgerEntryNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Entry No."; Integer)
        {
            DataClassification = CustomerContent;   
        }
        field(10; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
        }
    }
    
    keys
    {
        key(Key1;"Entry No.")
        {
            Clustered = true;
        }
    }
}