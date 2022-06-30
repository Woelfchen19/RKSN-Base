codeunit 50034 "CustEntryApplyPostedEntriesNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"CustEntry-Apply Posted Entries", 'OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters', '', true, true)]
    local procedure OnApplyApplyCustEntryFormEntryOnAfterCustLedgEntrySetFilters
    (
        var CustLedgerEntry: Record "Cust. Ledger Entry";
        var ApplyingCustLedgerEntry: Record "Cust. Ledger Entry")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetCustLedgEntryFilter(CustLedgerEntry, true);
    end;
}