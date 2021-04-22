table 50023 "FAJnlLineNVX"
{
    DataClassification = ToBeClassified;
    
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
    }

    keys
    {
        key(PK;"Journal Template Name","Journal Batch Name","Line No.")
        {
            Clustered = true;
        }
    }
}