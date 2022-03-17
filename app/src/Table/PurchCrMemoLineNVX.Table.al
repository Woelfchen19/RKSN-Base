table 50032 PurchCrMemoLineNVX
{
    fields
    {
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(20; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
        }
        field(25; "VAT Posting Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
        }
    }

    keys
    {
        key(PK; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}