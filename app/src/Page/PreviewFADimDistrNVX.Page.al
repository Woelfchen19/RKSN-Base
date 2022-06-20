page 50018 "PreviewFADimDistrNVX"
{
    Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
    PageType = List;
    SourceTable = DistrFAJnlLineNVX;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Caption = 'Posting Date', comment = 'DEA="Buchungsdatum"';
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                    Caption = 'Document No.', comment = 'DEA="Belegnr."';
                }
                field("FA No. NVX"; "FA No.")
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

                field("Shortcut Dimension 3 Code NVX"; ShortcutDimCode[3])
                {
                    ApplicationArea = All;
                    Caption = 'Sparte', comment = 'DEA="Sparte"';
                }
                field("Shortcut Dimension 4 Code NVX"; ShortcutDimCode[4])
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
                field("Allocation %"; "Allocation %")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage', comment = 'DEA="%-Anteil"';
                }
                field(Amount; Amount)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
    end;

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimMgt: Codeunit DimensionManagement;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        DimVisible9: Boolean;
        DimVisible10: Boolean;
        ShortcutDimCode: array[10] of Code[20];

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
        DimVisible8 := false;
        DimVisible9 := false;
        DimVisible10 := false;

        UseShortcutDims(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);
    end;

    local procedure UseShortcutDims(
        var DimensionVisible1: Boolean; var DimensionVisible2: Boolean; var DimensionVisible3: Boolean; var DimensionVisible4: Boolean; var DimensionVisible5: Boolean;
            var DimensionVisible6: Boolean; var DimensionVisible7: Boolean; var DimensionVisible8: Boolean; var DimensionVisible9: Boolean; var DimensionVisible10: Boolean);
    begin
        GLSetup.GetRecordOnce();

        DimensionVisible1 := GLSetup."Shortcut Dimension 1 Code" <> '';
        DimensionVisible2 := GLSetup."Shortcut Dimension 2 Code" <> '';
        DimensionVisible3 := GLSetup."Shortcut Dimension 3 Code" <> '';
        DimensionVisible4 := GLSetup."Shortcut Dimension 4 Code" <> '';
        DimensionVisible5 := GLSetup."Shortcut Dimension 5 Code" <> '';
        DimensionVisible6 := GLSetup."Shortcut Dimension 6 Code" <> '';
        DimensionVisible7 := GLSetup."Shortcut Dimension 7 Code" <> '';
        DimensionVisible8 := GLSetup."Shortcut Dimension 8 Code" <> '';
        DimensionVisible9 := GLSetup.ShortcutDimension9CodeNVX <> '';
        DimensionVisible10 := GLSetup.ShortcutDimension10CodeNVX <> '';
    end;
}