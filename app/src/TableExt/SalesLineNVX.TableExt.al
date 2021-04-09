tableextension 50003 SalesLineNVX extends "Sales Line"
{
    procedure UpdateSalesLine(CustUnitPrice: Decimal)
    var
        VATPostingSetup: Record "VAT Posting Setup";
        SalesHeader: Record "Sales Header";
        VatPercent: Decimal;
        NetUnitPrice: Decimal;
    begin       
        IF not SalesHeader.Get("Document Type","Document No.") then
            exit;
        IF SalesHeader."Prices Including VAT" then
            Validate("Unit Price", CustUnitPrice)
        else begin
            if VATPostingSetup.get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then;
            if VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then
                VatPercent := VATPostingSetup."VAT %";
            NetUnitPrice := round(CustUnitPrice / (100 + VatPercent) * 100, 0.01);
            Validate("Unit Price", NetUnitPrice);
        end;
    end;
}