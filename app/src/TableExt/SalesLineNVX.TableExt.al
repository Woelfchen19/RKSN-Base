tableextension 50004 SalesLineNVX extends "Sales Line"
{
    fields
    {
        modify(Type)
        {
            OptionCaption = ' ,G/L Account,Item', Comment = 'DEA=" ,Sachkonto,Artikel"';
        }
    }

    procedure UpdateSalesLineNVX(CustUnitPrice: Decimal)
    var
        SalesHeader: Record "Sales Header";
        VATPostingSetup: Record "VAT Posting Setup";
        NetUnitPrice: Decimal;
        VatPercent: Decimal;
    begin
        if not SalesHeader.Get("Document Type", "Document No.") then
            exit;
        if SalesHeader."Prices Including VAT" then
            Validate("Unit Price", CustUnitPrice)
        else begin
            if VATPostingSetup.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then;
            if VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then
                VatPercent := VATPostingSetup."VAT %";
            NetUnitPrice := Round(CustUnitPrice / (100 + VatPercent) * 100, 0.01);
            Validate("Unit Price", NetUnitPrice);
        end;
    end;
}