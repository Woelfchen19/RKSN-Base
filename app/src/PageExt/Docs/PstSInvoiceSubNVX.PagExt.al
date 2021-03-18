pageextension 50045 PstdSInvoiceSubNVX extends "Posted Sales Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; SalesInvoiceLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting Type"; SalesInvoiceLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }            
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF not SalesInvoiceLineNVX.Get(Rec."Document No.",Rec."Line No.") then
            SalesInvoiceLineNVX.Init;
    end;
    
    var
        SalesInvoiceLineNVX: Record SalesInvoiceLineNVX;
}