pageextension 50042 PstdPInvoiceSubNVX extends "Posted Purch. Invoice Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; PurchInvLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting Type"; PurchInvLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }            
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF not PurchInvLineNVX.Get(Rec."Document No.",Rec."Line No.") then
            PurchInvLineNVX.Init;
    end;
    
    var
        PurchInvLineNVX: Record PurchInvLineNVX;
}