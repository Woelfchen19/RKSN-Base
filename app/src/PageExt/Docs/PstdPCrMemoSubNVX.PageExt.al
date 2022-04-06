pageextension 50014 PstdPCrMemoSubNVX extends "Posted Purch. Cr. Memo Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; PurchCrMemoLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
            field("VAT Posting TypeNVX"; PurchCrMemoLineNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if not PurchCrMemoLineNVX.Get(Rec."Document No.", Rec."Line No.") then
            PurchCrMemoLineNVX.Init();
    end;

    var
        PurchCrMemoLineNVX: Record PurchCrMemoLineNVX;
}