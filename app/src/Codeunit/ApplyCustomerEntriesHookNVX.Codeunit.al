codeunit 50029 "ApplyCustomerEntriesHookNVX"
{
    //ToDo
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnSelectCustLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure OnSelectCustLedgEntryOnAfterSetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        // AppMgt.SetCustLedgEntryFilter(CustLedgerEntry, GenJournalLine);
    end;
}