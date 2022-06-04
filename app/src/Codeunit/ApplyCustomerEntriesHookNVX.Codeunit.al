codeunit 50029 "ApplyCustomerEntriesHookNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnSelectCustLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure OnSelectCustLedgEntryOnAfterSetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            CustLedgerEntry.FilterGroup(2);
            CustLedgerEntry.SetRange(AssociatedNVX, GenJournalLine.AssociatedNVX);
            CustLedgerEntry.FilterGroup(0);
        end;
    end;
}