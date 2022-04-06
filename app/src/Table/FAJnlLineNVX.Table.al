table 50013 FAJnlLineNVX
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
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
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