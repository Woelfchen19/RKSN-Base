pageextension 50043 PstdPCrMemoSubNVX extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; PurchCrMemoLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting Type"; PurchCrMemoLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }            
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF not PurchCrMemoLineNVX.Get(Rec."Document No.",Rec."Line No.") then
            PurchCrMemoLineNVX.Init;
    end;
    
    var
        PurchCrMemoLineNVX: Record PurchCrMemoLineNVX;
}