page 50016 "GenJnlLineArchivePrepNVX"
{
    Caption = 'Gen. Journal Line Archive Preparation', comment = 'DEA="Fibu Buch.-Blattzeilenarchiv Vorbereitung"';
    PageType = ListPart;
    SourceTable = GenJnlLineArchiveNVX;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; "Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; "Document Type")
                {
                    ApplicationArea = All;
                }
                field("Document No."; "Document No.")
                {
                    ApplicationArea = All;
                }
                field("External Document No."; "External Document No.")
                {
                    ApplicationArea = All;
                }
                field("Account Type"; "Account Type")
                {
                    ApplicationArea = All;
                }
                field("Account No."; "Account No.")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code NVX"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code NVX"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code NVX"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                }
                field("Allocation Code"; "Allocation Code")
                {
                    ApplicationArea = All;
                }
                field("Amount (LCY)";"Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; "Bal. Account Type")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account No."; "Bal. Account No.")
                {
                    ApplicationArea = All;
                }
                field(BusinessCase; BusinessCase)
                {
                    ApplicationArea = All;
                    Caption = 'Business Case', comment = 'DEA="Geschäftsfall"';
                }
            }
            
        }
    }
    var
        BusinessCase: Boolean;

    trigger OnOpenPage();
    begin
        BusinessCase := false; //Yes, this has (almost) no logic... but the customer knows best... or so they say....
        Rec.SetRange("Posting Type",Rec."Posting Type"::Distributed);
        CurrPage.Editable(false);
    end;
}