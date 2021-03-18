pageextension 50044 PstdSCrMemoSubNVX extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; SalesCrMemoLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting Type"; SalesCrMemoLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }            
        }
    }

    trigger OnAfterGetRecord();
    begin
        IF not SalesCrMemoLineNVX.Get(Rec."Document No.",Rec."Line No.") then
            SalesCrMemoLineNVX.Init;
    end;
    
    var
        SalesCrMemoLineNVX: Record SalesCrMemoLineNVX;
}