pageextension 50022 SInvoiceNVX extends "Sales Invoice"
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
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesInvoice);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                end;
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
                Editable = PageEditable;
                trigger OnValidate()
                var
                    DimValueNVX: Record DimValueNVX;
                    Item: Record Item;
                    ConfirmUpdateQst: Label 'Do you want to update Sales %1 and %2 in Sales Line with the values defined in %3?', comment = 'DEA="Möchten Sie Verkauf-%1 und %2 mit den Daten aus %3 aktualisieren?"';
                begin
                    DimMgt.ValidateShortcutDimValues(6, ShortcutDims[6], Rec."Dimension Set ID");
                    Rec.Modify();
                    if ShortcutDims[6] = '' then
                        exit;
                    if Item.Get(SalesLine."No.") then;
                    if (not Item."Inventory Value Zero") then begin
                        GLSetup.GetRecordOnce();
                        DimValueNVX.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDims[6]);
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
                                SalesLine.Validate("Shortcut Dimension 2 Code", DimValueNVX."Shortcut Dimension 2 Code");
                                SalesLineNVX.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                SalesLineNVX."Shortcut Dimension 1 Code" := DimValueNVX."Shortcut Dimension 1 Code";
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
        addlast(Processing)
        {
            action(PreviewDimDistributionNVX)
            {
                ApplicationArea = All;
                Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
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
        SalesLine: Record "Sales Line";
        SalesLineNVX: Record SalesLineNVX;
        DimMgt: Codeunit DimensionManagement;
        PageEditable: Boolean;
        ShortcutDims: array[8] of Code[20];

    trigger OnAfterGetRecord();
    begin
        PageEditable := CurrPage.Editable;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(DocumentType: Enum RKSSalesDocumentTypeNVX; DocumentNo: Code[20])
    begin
    end;
}