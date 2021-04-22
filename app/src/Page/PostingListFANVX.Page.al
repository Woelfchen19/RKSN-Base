page 50013 "PostingListFANVX"
{
    Caption = 'Backup dimensional distribution Fixed Asset', comment = 'DEA="Sicherung dim.Verteilungen Modul AnBu"';
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
                field(Open; Open)
                {
                    ApplicationArea = All;
                }
                
            }
        }
    }
    trigger OnOpenPage();
    begin
        SetCurrentKey("Date", "Time");
        SetRange("Source Journal Line", "Source Journal Line"::FAJnlLine);
    end;
}