table 50020 "GenJnlLineNVX"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Allocation Code"; Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(15; "VAT Posting Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
        }
        field(30; DoNotSplit; Boolean)
        {
            DataClassification = CustomerContent;
        }
        field(31; FixedGBPG; Code[20])
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK;"Journal Template Name","Journal Batch Name","Line No.")
        {
            Clustered = true;
        }
    }
}