pageextension 50000 "BankAccountLedgerEntriesNVX" extends "Bank Account Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; BankAccountLedgerEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not BankAccountLedgerEntryNVX.Get("Entry No.") then
            BankAccountLedgerEntryNVX.Init();
    end;

    var
        BankAccountLedgerEntryNVX: Record BankAccountLedgerEntryNVX;
}