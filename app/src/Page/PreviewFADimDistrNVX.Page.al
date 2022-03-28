page 50018 PreviewFADimDistrNVX
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
        ShortcutDimCode: array[8] of Code[20];

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

    local procedure UseShortcutDims(var DimVisible1: Boolean; var DimVisible2: Boolean; var DimVisible3: Boolean; var DimVisible4: Boolean; var DimVisible5: Boolean; var DimVisible6: Boolean; var DimVisible7: Boolean; var DimVisible8: Boolean);
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