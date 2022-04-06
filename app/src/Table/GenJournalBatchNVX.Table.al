table 50020 GenJournalBatchNVX
{
    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name', comment = 'DEA="Buch.-Blattvorlagenname"';
            TableRelation = "Gen. Journal Template";
            DataClassification = CustomerContent;
        }
        field(2; Name; Code[10])
        {
            Caption = 'Name', comment = 'DEA="Name"';
            DataClassification = CustomerContent;
        }
        field(10; "No Dim Distribution"; Boolean)
        {
            Caption = 'No dimensional distribution', comment = 'DEA="dim.Verteilungsprozess wiederk. deaktiviert"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Journal Template Name", Name)
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(JournalTemplateName: Code[10]; Name: Code[10])
    begin
        if ("Journal Template Name" = JournalTemplateName) and
            (Name = Name)
        then
            exit;

        if Get(JournalTemplateName, Name) then
            exit;

        Init();
        "Journal Template Name" := JournalTemplateName;
        Name := Name;
        Insert();
    end;
}