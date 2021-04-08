tableextension 50002 PurchaseLineNVX extends "Purchase Line"
{
    procedure UpdatePurchaseLine(VendUnitPrice: Decimal)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        PurchaseHeader: Record "Purchase Header";
        VatPercent: Decimal;
        NetUnitPrice: Decimal;
    begin       
        IF not PurchaseHeader.Get("Document Type","Document No.") then
            exit;
        IF PurchaseHeader."Prices Including VAT" then
            Validate("Direct Unit Cost", VendUnitPrice)
        else begin
            if VATPostingSetup.get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then;
            if VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then
                VatPercent := VATPostingSetup."VAT %";
            NetUnitPrice := round(VendUnitPrice / (100 + VatPercent) * 100, 0.01);
            Validate("Direct Unit Cost", NetUnitPrice);
        end;
    end;
}