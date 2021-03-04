pageextension 50034 FALedgerEntries extends "FA Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; FALedgerEntryNVX."Allocation Code")
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
        IF not FALedgerEntryNVX.Get("Entry No.") then
            FALedgerEntryNVX.Init();
    end;
}