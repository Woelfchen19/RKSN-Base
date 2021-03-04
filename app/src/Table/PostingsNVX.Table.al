table 50021 PostingsNVX
{
    DataClassification = CustomerContent;
    Caption = 'Postings', comment = 'DEA="Buchungen"';

    fields
    {
        field(1; "Posting GUID"; Guid)
        {
            Caption = 'Posting GUID', comment = 'DEA="Buchungs-GUID"';
            DataClassification = CustomerContent;
        }
        // field(2; "Document No."; Code[20])
        // {
        //     Caption = 'Document No.', comment = 'DEA="Belegnr."';
        //     DataClassification = CustomerContent;
        // }
        // field(5; "Posting Date"; Date)
        // {
        //     ClosingDates = true;           
        // }
        field(5; "Source Journal Line"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = GenJnlLine, FAJnlLine;
            OptionCaption = 'Gen. Journal Line,FA Journal Line';
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
        field(20; Time; Time)
        {
            Caption = 'Time', comment = 'DEA="Uhrzeit"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Posting GUID")
        {
            Clustered = true;
        }
    }
}