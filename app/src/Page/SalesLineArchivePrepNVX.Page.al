page 50026 "SalesLineArchivePrepNVX"
{
    Caption = 'Sales Line Archive Preparation', comment = 'DEA="Verkaufszeilenarchiv Vorbereitung"';
    PageType = ListPart;
    SourceTable = SalesLineArchiveNVX;
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
                field(Type; "Type")
                {
                    Caption = 'Account Type', comment = 'DEA="Kontoart"';
                    ApplicationArea = All;
                }
                field("No."; "No.")
                {
                    Caption = 'Account No.', comment = 'DEA="Kontonr."';
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
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Bal. Account Type"; BalAccountTypeLbl)
                {
                    ApplicationArea = All;
                    Caption = 'Bal. Account Type', comment = 'DEA="Gegenkontoart"';
                }
                field("Bal. Account No."; "Sell-to Customer No.")
                {
                    Caption = 'Bal. Account No.', comment = 'DEA="Gegenkontonr."';
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
        BalAccountTypeLbl: Label 'Customer', comment = 'DEA="Debitor"';

    trigger OnOpenPage();
    begin
        BusinessCase := false; //Yes, this has (almost) no logic... but the customer knows best... or so they say....
        Rec.SetRange("Posting Type", Rec."Posting Type"::Distributed);
        CurrPage.Editable(false);
    end;
}