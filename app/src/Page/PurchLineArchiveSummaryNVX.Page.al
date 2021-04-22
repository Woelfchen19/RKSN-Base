page 50028 "PurchLineArchiveSummaryNVX"
{
    Caption = 'Purchase Line Archive Summary', comment = 'DEA="Einkaufszeilenarchiv Zusammenfassung"';
    PageType = ListPart;
    SourceTable = PurchLineArchiveNVX;
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
                // field("Shortcut Dimension 2 Name NVX"; "Shortcut Dimension 2 Name")
                // {
                //     ApplicationArea = All;
                // }
                field("Shortcut Dimension 1 Code NVX"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    Caption = 'KSt', comment = 'DEA="KSt"';
                }

                field("Shortcut Dimension 3 Code NVX"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Sparte', comment = 'DEA="Sparte"';
                    // trigger OnDrillDown();
                    // var
                    //     GLSetup: Record "General Ledger Setup";
                    //     DimValueRec: Record "Dimension Value";
                    //     DimValuesPage: Page "Dimension Values";
                    // begin
                    //     GLSetup.Get();
                    //     DimValueRec.SetRange("Dimension Code",GLSetup."Shortcut Dimension 3 Code");
                    //     DimValuesPage.SetRecord(DimValueRec);
                    //     DimValuesPage.SetTableView(DimValueRec);
                    //     DimValuesPage.Run();
                    // end;
                }
                // field("Shortcut Dimension 3 Name NVX"; "Shortcut Dimension 3 Name")
                // {
                //     ApplicationArea = All;
                // }
                field("Shortcut Dimension 4 Code NVX"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    Caption = 'Project', comment = 'DEA="Projekt"';
                }
                // field("Shortcut Dimension 4 Name NVX"; "Shortcut Dimension 4 Name")
                // {
                //     ApplicationArea = All;
                // }       
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
                field("Allocation %";"Allocation %")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage', comment = 'DEA="%-Anteil"';
                }
                field("Amount Including VAT"; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount Including VAT', comment = 'DEA="Betrag BRUTTO"';
                }
                field("VAT Amount (LCY)";"Amount Including VAT" - "VAT Base Amount")
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
        Rec.SetRange("Posting Type",Rec."Posting Type"::Distributed);
        // Rec.SetFilter("Account No.",'<>%1','');
        CurrPage.Editable(false);
    end;
}