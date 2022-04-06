pageextension 50019 PstdSInvoiceSubNVX extends "Posted Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; SalesInvoiceLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
            field("VAT Posting TypeNVX"; SalesInvoiceLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if not SalesInvoiceLineNVX.Get(Rec."Document No.", Rec."Line No.") then
            SalesInvoiceLineNVX.Init();
    end;

    var
        SalesInvoiceLineNVX: Record SalesInvoiceLineNVX;
}