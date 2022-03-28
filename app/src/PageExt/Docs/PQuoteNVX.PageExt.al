pageextension 50012 "PQuoteNVX" extends "Purchase Quote"
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
                    RKSMgt: Codeunit RKSMgtNVX;
                    FilterOptionNVX: Enum FilterOptionNVX;
                    NewGBPG: Code[20];
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::PurchaseQuote);
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

    var
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        PageEditable := CurrPage.Editable;
    end;
}