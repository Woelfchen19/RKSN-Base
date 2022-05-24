codeunit 50029 "ApplyCustomerEntriesHookNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnSelectCustLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure OnSelectCustLedgEntryOnAfterSetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.SetAutoCalcFields(AssociatedNVX);
        CustLedgerEntry.FilterGroup(2);
        CustLedgerEntry.SetRange(AssociatedNVX, GenJournalLine.AssociatedNVX);
        CustLedgerEntry.FilterGroup(0);
    end;
}