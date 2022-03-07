page 50031 PostingListPurchaseNVX
{
    Caption = 'Backup dimensional distribution Purchase', comment = 'DEA="Sicherung dim.Verteilungen Modul Einkauf"';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = PostingsNVX;
    CardPageId = PostingCardNVX;
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
        SetRange("Source Journal Line", "Source Journal Line"::PurchaseLine);
    end;
}