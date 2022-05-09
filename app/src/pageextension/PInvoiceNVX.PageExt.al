pageextension 50008 "PInvoiceNVX" extends "Purchase Invoice"
{
    layout
    {

        addafter("Buy-from Vendor Name")
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
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::PurchaseInvoice);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                end;
            }
        }
        modify("Prices Including VAT")
        {
            trigger OnAfterValidate();
            var
                LPurchaseLine: Record "Purchase Line";
                PurchaseLineNVX: Record PurchaseLineNVX;
            begin
                PurchaseLineNVX.SetRange("Document Type", Rec."Document Type");
                PurchaseLineNVX.SetRange("Document No.", Rec."No.");
                if PurchaseLineNVX.FindSet() then
                    repeat
                        LPurchaseLine.Get(PurchaseLineNVX."Document Type", PurchaseLineNVX."Document No.", PurchaseLineNVX."Line No.");
                        LPurchaseLine.UpdatePurchaseLineNVX(PurchaseLineNVX."Vend. Unit Price");
                    until PurchaseLineNVX.Next() = 0;
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
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        PageEditable := CurrPage.Editable;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(DocumentType: Enum RKSPurchaseDocumentTypeNVX; DocumentNo: Code[20])
    begin
    end;
}