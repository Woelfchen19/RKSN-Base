pageextension 50034 FALedgerEntriesNVX extends "FA Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; FALedgerEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
        }
    }

    var
        FALedgerEntryNVX: Record FALedgerEntryNVX;

    trigger OnAfterGetRecord();
    begin
        if not FALedgerEntryNVX.Get("Entry No.") then
            FALedgerEntryNVX.Init();
    end;
}