page 50035 SalesLineArchiveSummaryNVX
{
    Caption = 'Sales Line Archive Summary', comment = 'DEA="Verkaufszeilenarchiv Zusammenfassung"';
    PageType = ListPart;
    SourceTable = SalesLineArchiveNVX;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Account No. NVX"; "No.")
                {
                    ApplicationArea = All;
                    Caption = 'G/L Account / Fixed Asset', comment = 'DEA="Sachkto./Anlage"';
                }
                field("Shortcut Dimension 2 Code NVX"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    Caption = 'PC', comment = 'DEA="PC"';
                }
                field("Shortcut Dimension 1 Code NVX"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'KSt', comment = 'DEA="KSt"';
                }

                field("Shortcut Dimension 3 Code NVX"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sparte', comment = 'DEA="Sparte"';
                }
                field("Shortcut Dimension 4 Code NVX"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Project', comment = 'DEA="Projekt"';
                }
                field("Shortcut Dimension 1 Name NVX"; "Shortcut Dimension 1 Name")
                {
                    ApplicationArea = All;
                    Caption = 'Cost Center Name', comment = 'DEA="Kostenstelle Name"';
                }
                field("Allocation Code NVX"; "Allocation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                }
                field("VAT Posting Type NVX"; "VAT Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group NVX"; "Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Steuerschlüssel (Gesch.Bu.Grp.)"';
                }
                field("Gen. Bus. Posting Group Name NVX"; "Gen. Bus. Posting Group Desc")
                {
                    ApplicationArea = All;
                    Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Name Steuerschlüssel"';
                }
                field("Allocation %"; "Allocation %")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage', comment = 'DEA="%-Anteil"';
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Including VAT', comment = 'DEA="Betrag BRUTTO"';
                }
                field("VAT Amount (LCY)"; "Amount Including VAT" - "VAT Base Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount (LCY)', comment = 'DEA="Betrag Ust."';
                }
                field("VAT Base Amount"; "VAT Base Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Base Amount (LCY)', comment = 'DEA="Betrag NETTO"';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; "VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage();
    begin
        Rec.SetRange("Posting Type", Rec."Posting Type"::Distributed);
        CurrPage.Editable(false);
    end;
}