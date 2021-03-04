page 50021 FAJnlLineArchiveSummaryNVX
{
    Caption = 'FA Journal Line Archive Summary', comment = 'DEA="Anlagen Buch.-Blattzeilenarchiv Zusammenfassung"';
    PageType = ListPart;
    SourceTable = FAJnlLineArchiveNVX;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("FA No. NVX"; "FA No.")
                {
                    ApplicationArea = All;
                    Caption = 'Fixed Asset', comment = 'DEA="Anlage"';
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
                    //     DimValuesPage.Run;
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
                field("Allocation %";"Allocation %")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage', comment = 'DEA="%-Anteil"';
                }
                field("Amount";"Amount")
                {
                    ApplicationArea = All;
                }
                field("Start Date";"Start Date")
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