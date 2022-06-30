pageextension 50020 "SalesCrMemoNVX" extends "Sales Credit Memo"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(GenBsnPstGrpNVX; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesCrMemo);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                end;
            }
            field(ShortCutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                Visible = DimVisible5;
                Editable = DimEditable5;
            }
            field("Transaction No. NVX"; SalesHeaderNVX."Transaction No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Transaction No.', comment = 'DEA="Verkauf Transaktionsnummer"';
                Editable = false;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 6 CodeNVX"; ShortcutDims[6])
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));

                trigger OnValidate()
                var
                    DimensionValue: Record "Dimension Value";
                    Item: Record Item;
                    ConfirmUpdateQst: Label 'Do you want to update Sales %1 and %2 in Sales Line with the values defined in %3?', comment = 'DEA="Möchten Sie Verkauf-%1 und %2 mit den Daten aus %3 aktualisieren?"';
                begin
                    DimMgt.ValidateShortcutDimValues(6, ShortcutDims[6], Rec."Dimension Set ID");
                    Rec.Modify();
                    if ShortcutDims[6] = '' then
                        exit;
                    if Item.Get(SalesLine."No.") then;
                    if not Item."Inventory Value Zero" then begin
                        GLSetup.GetRecordOnce();
                        DimensionValue.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDims[6]);

                        Rec.Modify();

                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet() then begin
                            if not Confirm(ConfirmUpdateQst, false, GLSetup."Shortcut Dimension 1 Code", GLSetup."Shortcut Dimension 2 Code", GLSetup."Shortcut Dimension 6 Code") then
                                exit;

                            SalesLineNVX.Reset();
                            repeat
                                SalesLine.Validate("Shortcut Dimension 2 Code", DimensionValue.ShortcutDimension2CodeNVX);
                                SalesLineNVX.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                SalesLineNVX."Shortcut Dimension 1 Code" := DimensionValue.ShortcutDimension1CodeNVX;

                                SalesLine.Modify();
                                SalesLineNVX.Modify();

                            until SalesLine.Next() = 0;

                        end;
                    end;
                end;
            }
        }

        modify("Prices Including VAT")
        {
            trigger OnAfterValidate();
            var
                LSalesLine: Record "Sales Line";
                SalesLineNVX: Record SalesLineNVX;
            begin
                SalesLineNVX.SetRange("Document Type", Rec."Document Type");
                SalesLineNVX.SetRange("Document No.", Rec."No.");
                if SalesLineNVX.FindSet() then
                    repeat
                        LSalesLine.Get(SalesLineNVX."Document Type", SalesLineNVX."Document No.", SalesLineNVX."Line No.");
                        LSalesLine.UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
                    until SalesLineNVX.Next() = 0;
            end;
        }
    }

    actions
    {
        // modify(ApplyEntries)
        // {
        //     Visible = false;
        // }
        // addafter(ApplyEntries)
        // {
        //     action(ApplyEntriesNVX)
        //     {
        //         ApplicationArea = Basic, Suite;
        //         Caption = 'Apply Entries', comment = 'DEA="Posten ausgleichen"';
        //         ;
        //         Ellipsis = true;
        //         Enabled = "No." <> '';
        //         Image = ApplyEntries;
        //         Promoted = true;
        //         PromotedCategory = Category7;
        //         ShortCutKey = 'Shift+F11';
        //         ToolTip = 'Select one or more ledger entries that you want to apply this record to so that the related posted documents are closed as paid or refunded.';

        //         trigger OnAction()
        //         var
        //             CustLedgerEntry: Record "Cust. Ledger Entry";
        // SalesHeaderApply: Codeunit SalesHeaderApplyNVX;
        // i: Integer;
        // begin
        //SalesHeaderApply.Run(Rec);
        //ToDo
        //SalesHeaderApply.GetApplyCustLedgerEntries(CustLedgerEntry);
        // AppMgt.ChangeShortcutDimension5CodeSalesHeader(Rec, CustLedgerEntry);
        // Rec.ShortcutDimension5CodeNVX := CustLedgerEntry.ShortcutDimension5CodeNVX;
        // Rec.ValidateShortcutDimCode(5, Rec.ShortcutDimension5CodeNVX);

        //Message(CustLedgerEntry.GetFilters);
        // if CustLedgerEntry.FindFirst() then
        //Rec.ValidateShortcutDimCode(5, CustLedgerEntry.ShortcutDimension5CodeNVX);
        //     if Rec.ShortcutDimension5CodeNVX <> CustLedgerEntry.ShortcutDimension5CodeNVX then begin
        //         Rec.Validate(ShortcutDimension5CodeNVX, CustLedgerEntry.ShortcutDimension5CodeNVX);
        // Rec.Modify();
        // end;
        // AppMgt.OnValidateShortcutDimension(Rec);
        // Rec.Modify();
        // end;
        // }

        addlast(Processing)
        {
            action(PreviewDimDistributionNVX)
            {
                ApplicationArea = All;
                Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    DistrPurchLine: Record DistrPurchLineNVX;
                    PreviewPurchDimDistrPage: Page PreviewPurchDimDistrNVX;
                begin
                    OnPreviewDimDistributionNVX(Rec."Document Type", rec."No.");
                    DistrPurchLine.SetRange("Document Type", Rec."Document Type");
                    DistrPurchLine.SetRange("Document No.", Rec."No.");
                    PreviewPurchDimDistrPage.SetRecord(DistrPurchLine);
                    PreviewPurchDimDistrPage.SetTableView(DistrPurchLine);
                    PreviewPurchDimDistrPage.Run();
                end;
            }
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLine: Record "Sales Line";
        SalesLineNVX: Record SalesLineNVX;
        AppMgt: Codeunit AppMgtNVX;
        DimMgt: Codeunit DimensionManagement;
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
        PageEditable: Boolean;
        ShortcutDims: array[10] of Code[20];
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;

    trigger OnOpenPage()
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"Sales Credit Memo", DimVisible, DimEditable);
        AppMgt.GetFieldsPropertyVisibleEditableBySetup(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10);
    end;

    trigger OnAfterGetRecord();
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
        PageEditable := CurrPage.Editable;

        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := "Document Type";
            SalesHeaderNVX."No." := "No.";
            SalesHeaderNVX.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(DocumentType: Enum RKSSalesDocumentTypeNVX; DocumentNo: Code[20])
    begin
    end;
}