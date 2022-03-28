table 50027 PostingsNVX
{
    Caption = 'Backup dimensional distribution', comment = 'DEA="Sicherung dim.Verteilungen Modul AnBu"';

    fields
    {
        field(1; "Posting GUID"; Guid)
        {
            Caption = 'Posting GUID', comment = 'DEA="Buchungs-GUID"';
            DataClassification = CustomerContent;
        }
        field(5; "Source Journal Line"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = GenJnlLine,FAJnlLine,PurchaseLine,SalesLine;
            OptionCaption = 'Gen. Journal Line,FA Journal Line,Purchase Line,Sales Line';
        }
        field(10; "Date"; Date)
        {
            Caption = 'Date', comment = 'DEA="Datum"';
            DataClassification = CustomerContent;
        }
        field(15; "User ID"; Code[50])
        {
            Caption = 'User ID', comment = 'DEA="Benutzer-ID"';
            DataClassification = CustomerContent;
        }
        field(20; "Time"; Time)
        {
            Caption = 'Time', comment = 'DEA="Uhrzeit"';
            DataClassification = CustomerContent;
        }
        field(25; Open; Boolean)
        {
            Caption = 'Open', comment = 'DEA="Offen"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Posting GUID")
        {
            Clustered = true;
        }
        key(SortKey; "Date", "Time")
        {
            Clustered = false;
        }
    }
}