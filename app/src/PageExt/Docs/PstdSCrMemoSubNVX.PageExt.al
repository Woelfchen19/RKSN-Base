pageextension 50017 PstdSCrMemoSubNVX extends "Posted Sales Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; SalesCrMemoLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
            field("VAT Posting TypeNVX"; SalesCrMemoLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if not SalesCrMemoLineNVX.Get(Rec."Document No.", Rec."Line No.") then
            SalesCrMemoLineNVX.Init();
    end;

    var
        SalesCrMemoLineNVX: Record SalesCrMemoLineNVX;
}