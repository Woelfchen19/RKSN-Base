tableextension 50003 PurchaseLineNVX extends "Purchase Line"
{
    fields
    {
        modify(Type)
        {
            OptionCaption = ' ,G/L Account,Item', Comment = 'DEA=" ,Sachkonto,Artikel"';
        }
    }
    procedure UpdatePurchaseLineNVX(VendUnitPrice: Decimal)
    var
        PurchaseHeader: Record "Purchase Header";
        VATPostingSetup: Record "VAT Posting Setup";
        NetUnitPrice: Decimal;
        VatPercent: Decimal;
    begin
        if not PurchaseHeader.Get("Document Type", "Document No.") then
            exit;
        if PurchaseHeader."Prices Including VAT" then
            Validate("Direct Unit Cost", VendUnitPrice)
        else begin
            if VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then;
            if VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then
                VatPercent := VATPostingSetup."VAT %";
            NetUnitPrice := Round(VendUnitPrice / (100 + VatPercent) * 100, 0.01);
            Validate("Direct Unit Cost", NetUnitPrice);
        end;
    end;
}