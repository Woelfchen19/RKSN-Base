page 50019 FAJnlLineArchiveOriginNVX
{
    Caption = 'FA Journal Line Archive Origin', comment = 'DEA="Anlagen Buch.-Blattzeilenarchiv Ursprung"';
    PageType = ListPart;
    SourceTable = FAJnlLineArchiveNVX;
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
                field("FA No."; "FA No.")
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
                field("Amount"; "Amount")
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
        BusinessCase := true; //Yes, this has (almost) no logic... but the customer knows best... or so they say....
        Rec.SetRange("Posting Type", Rec."Posting Type"::OG);
        CurrPage.Editable(false);
    end;
}