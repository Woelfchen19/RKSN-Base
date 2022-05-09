table 50020 "GenJournalBatchNVX"
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
        field(20; ShortcutDimension5CodeNVX; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
        }
    }

    keys
    {
        key(PK; "Journal Template Name", Name)
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(JournalTemplateName: Code[10]; Name2: Code[10])
    begin
        if ("Journal Template Name" = JournalTemplateName) and
            (Name = Name2)
        then
            exit;

        if Get(JournalTemplateName, Name2) then
            exit;

        Init();
        "Journal Template Name" := JournalTemplateName;
        Name := Name2;
        Insert();
    end;
}