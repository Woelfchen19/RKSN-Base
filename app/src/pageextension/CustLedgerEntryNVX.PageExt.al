pageextension 50051 "CustLedgerEntryNVX" extends "Customer Ledger Entries"
{
    PromotedActionCategories = 'New,Process,Report,Line,Entry,Navigate,Sort', comment = 'DEA="Neu,Prozess,Bericht,Zeile,Posten,Navigieren,Sortieren"';

    layout
    {
        modify("Global Dimension 2 Code")
        {
            Editable = false;
            Visible = DimVisible2;
        }

        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; Rec.ShortcutDimension3CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                Visible = DimVisible3;
            }
            field(ShortcutDimension4CodeNVX; Rec.ShortcutDimension4CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                Visible = DimVisible4;
            }
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimVisible5;
            }
            field(ShortcutDimension6CodeNVX; Rec.ShortcutDimension6CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                Visible = DimVisible6;
            }
            field(ShortcutDimension7CodeNVX; Rec.ShortcutDimension7CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
                Visible = DimVisible7;
            }
            field(ShortcutDimension8CodeNVX; Rec.ShortcutDimension8CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
                Visible = DimVisible8;
            }
            field(ShortcutDimension9CodeNVX; Rec.ShortcutDimension9CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                Visible = DimVisible9;
            }
            field(ShortcutDimension10CodeNVX; Rec.ShortcutDimension10CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
                Visible = DimVisible10;
            }
            field(AssociatedNVX; Rec.AssociatedNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Associated field.';
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
                action(SortbyBusinessFieldPostingDateDocumentNoNVX)
                {
                    ApplicationArea = All;
                    Caption = 'Business Field|Posting Date|Document No.', comment = 'DEA="Geschäftsfeld|Buchungsdatum|Belegnr"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(4);
                    end;
                }
                action(SortbyBusinessFieldPostingDatePCDocumentNoNVX)
                {
                    ApplicationArea = All;
                    Caption = 'Business Field|Posting Date|PC|Document No.', comment = 'DEA="Geschäftsfeld|Buchungsdatum|PC|Belegnr"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(5);
                    end;
                }
                action(SortbyBusinessFieldCollectedAccountPCPostingDateDocumentNoNVX)
                {
                    ApplicationArea = All;
                    Caption = 'Business Field|CollectedAccount|PC|Posting Date|Document No.', comment = 'DEA="Geschäftsfeld|Sammelkto|PC|Buchungsdatum|Belegnr"';
                    Image = PostingEntries;
                    Promoted = true;
                    PromotedCategory = Category7;

                    trigger OnAction();
                    begin
                        SortByNVX(6);
                    end;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"Customer Ledger Entries", DimVisible, DimEditable);
        AppMgt.GetFieldsPropertyVisibleEditableBySetup(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10);
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        DimEditable: array[10] of Boolean;
        DimEditable1: Boolean;
        DimEditable2: Boolean;
        DimEditable3: Boolean;
        DimEditable4: Boolean;
        DimEditable5: Boolean;
        DimEditable6: Boolean;
        DimEditable7: Boolean;
        DimEditable8: Boolean;
        DimEditable9: Boolean;
        DimEditable10: Boolean;
        DimVisible: array[10] of Boolean;
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
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
}
