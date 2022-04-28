pageextension 50051 "CustLedgerEntryNVX" extends "Customer Ledger Entries"
{
    PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate,Sort', comment = 'DEA="Neu,Prozess,Bericht,Zeile,Posten,Navigieren,Sortieren"';

    layout
    {
        modify("Global Dimension 2 Code")
        {
            Visible = DimVisible2;
        }

        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; Rec.ShortcutDimension3CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension4CodeNVX; Rec.ShortcutDimension4CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension6CodeNVX; Rec.ShortcutDimension6CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension7CodeNVX; Rec.ShortcutDimension7CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension8CodeNVX; Rec.ShortcutDimension8CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension9CodeNVX; Rec.ShortcutDimension9CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                ApplicationArea = All;
            }
            field(ShortcutDimension10CodeNVX; Rec.ShortcutDimension10CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        addlast(Creation)
        {
            group(SetCurrentkeyNVX)
            {
                Caption = 'Sort by', comment = 'DEA="Sortieren nach"';
                Image = SortDescending;

                action(SortbyPostingDateDocumentDateNVX)
                {
                    ApplicationArea = All;
                    Caption = '"Posting Date|Document No. ', comment = 'DEA="Buchungsdatum|Belegnr"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(1);
                    end;
                }
                action(SortbyPostingDateDocumentNoNVX)
                {
                    ApplicationArea = All;
                    Caption = '"Document No."|"Posting Date"', comment = 'DEA="Belegnr|Buchungsdatum"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(2);
                    end;
                }

                action(SortbyGlobalDimension2CodePostingDateDocumentDateNVX)
                {
                    ApplicationArea = All;
                    Caption = '"Global Dimension 2 Code", "Posting Date", "Document No."', comment = 'DEA="PC|Buchungsdatum|Belegnr"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(3);
                    end;
                }
            }
        }
    }

    var
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

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        GetShortcutDimensionsNVX("Dimension Set ID", ShortcutDimCodes);
        AssignShortCutDimensions();
    end;

    local procedure SetDimensionsVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;
        DimVisible9 := false;
        DimVisible10 := false;

        DimensionManagement.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);

        DimVisible1 := false;
        DimVisible3 := false;
        DimVisible7 := false;
        DimVisible8 := false;
        DimVisible10 := false;

        Clear(DimensionManagement);
    end;

    local procedure AssignShortCutDimensions()
    begin
        ShortcutDimension3CodeNVX := ShortcutDimCodes[3];
        ShortcutDimension4CodeNVX := ShortcutDimCodes[4];
        ShortcutDimension5CodeNVX := ShortcutDimCodes[5];
        ShortcutDimension6CodeNVX := ShortcutDimCodes[6];
        ShortcutDimension7CodeNVX := ShortcutDimCodes[7];
        ShortcutDimension8CodeNVX := ShortcutDimCodes[8];
        ShortcutDimension9CodeNVX := ShortcutDimCodes[9];
        ShortcutDimension10CodeNVX := ShortcutDimCodes[10];
    end;

    local procedure SortByNVX(Index: Integer)
    begin
        case index of
            1:
                begin
                    SetCurrentKey("Posting Date", "Document No.");
                    SetAscending("Posting Date", false);
                end;
            2:
                begin
                    SetCurrentKey("Document No.", "Posting Date");
                    SetAscending("Document No.", false);
                end;
            3:
                begin
                    SetCurrentKey("Global Dimension 2 Code", "Posting Date", "Document No.");
                    SetAscending("Global Dimension 2 Code", false);
                    ;
                end;
        // 4:SetCurrentKey()
        // 5:
        // 6:
        end;
    end;

    var
        ShortcutDimCodes: ARRAY[10] OF Code[20];
}
