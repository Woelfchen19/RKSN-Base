page 50025 "PreviewPurchDimDistrNVX"
{
    Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
    PageType = List;
    SourceTable = DistrPurchLineNVX;
    InsertAllowed = false;
    DeleteAllowed = false;
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

                field("Shortcut Dimension 3 Code NVX"; ShortcutDimCode[3])
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
                field("Shortcut Dimension 4 Code NVX"; ShortcutDimCode[4])
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
                field(Amount; "Amount Including VAT")
                {
                    ApplicationArea = All;
                    Caption = 'Amount incl. VAT', comment = 'DEA="Betrag BRUTTO"';
                }
                field("VAT Amount"; "Amount Including VAT" - "VAT Base Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Amount', comment = 'DEA="Betrag Ust."';
                }
                field("VAT Base Amount (LCY)";"VAT Base Amount")
                {
                    ApplicationArea = All;
                    Caption = 'VAT Base Amount', comment = 'DEA="Betrag NETTO"';
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

    trigger OnAfterGetRecord()
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID",ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin

        SetDimensionsVisibility();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: array[8] of Code[20];
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;

        local procedure SetDimensionsVisibility()
        begin
            DimVisible1 := false;
            DimVisible2 := false;
            DimVisible3 := false;
            DimVisible4 := false;
            DimVisible5 := false;
            DimVisible6 := false;
            DimVisible7 := false;
            DimVisible8 := false;

            UseShortcutDims(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8);

        end;

        local procedure UseShortcutDims(VAR DimVisible1 : Boolean;VAR DimVisible2 : Boolean;VAR DimVisible3 : Boolean;VAR DimVisible4 : Boolean;VAR DimVisible5 : Boolean;VAR DimVisible6 : Boolean;VAR DimVisible7 : Boolean;VAR DimVisible8 : Boolean);
        begin
            GLSetup.Get();
            DimVisible1 := GLSetup."Shortcut Dimension 1 Code" <> '';
            DimVisible2 := GLSetup."Shortcut Dimension 2 Code" <> '';
            DimVisible3 := GLSetup."Shortcut Dimension 3 Code" <> '';
            DimVisible4 := GLSetup."Shortcut Dimension 4 Code" <> '';
            DimVisible5 := GLSetup."Shortcut Dimension 5 Code" <> '';
            DimVisible6 := GLSetup."Shortcut Dimension 6 Code" <> '';
            DimVisible7 := GLSetup."Shortcut Dimension 7 Code" <> '';
            DimVisible8 := GLSetup."Shortcut Dimension 8 Code" <> '';
        end;
}