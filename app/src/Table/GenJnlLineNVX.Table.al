table 50019 GenJnlLineNVX
{
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
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
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
        field(32; IsRetrospectPosting; Boolean)
        {
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(JournalTemplateName: Code[10]; JournalBatchName: Code[10]; LineNo: Integer)
    begin
        if LineNo = 0 then
            exit;
        if ("Journal Template Name" = JournalTemplateName) and
            ("Journal Batch Name" = JournalBatchName) and
            ("Line No." = LineNo)
        then
            exit;

        if Get(JournalTemplateName, JournalBatchName, LineNo) then
            exit;

        Init();
        "Journal Template Name" := JournalTemplateName;
        "Journal Batch Name" := JournalBatchName;
        "Line No." := LineNo;
        Insert();
    end;
}