page 50024 "PostingListGLNVX"
{
    Caption = 'Backup dimensional distribution General Ledger', comment = 'DEA="Sicherung dim.Verteilungen Modul FiBu"';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = PostingsNVX;
    CardPageId = 50014;
    Editable = false;
    InsertAllowed = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting GUID"; "Posting GUID")
                {
                    ApplicationArea = All;
                }
                // field("Posting Date"; "Posting Date")
                // {
                //     ApplicationArea = All;
                // }
                // field("Document No."; "Document No.")
                // {
                //     ApplicationArea = All;
                // }
                field("Date"; "Date")
                {
                    ApplicationArea = All;
                }
                field("Time"; "Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }

            }
        }
    }
    trigger OnOpenPage();
    begin
        SetCurrentKey("Date", "Time");
        SetRange("Source Journal Line", "Source Journal Line"::GenJnlLine);
    end;
}