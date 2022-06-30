codeunit 50038 "ApplyCustomerEntriesNVX"
{
    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnFindFindApplyingEntryOnAfterCustLedgEntrySetFilters', '', true, true)]
    local procedure OnFindFindApplyingEntryOnAfterCustLedgEntrySetFilters(ApplyingCustLedgerEntry: Record "Cust. Ledger Entry"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        AppMgt.SetCustLedgEntryFilter(CustLedgerEntry, true);
    end;


    [EventSubscriber(ObjectType::Page, Page::"Apply Customer Entries", 'OnOpenPageEvent', '', true, true)]
    local procedure "Apply Customer Entries_OnOpenPageEvent"(var Rec: Record "Cust. Ledger Entry")
    begin

    end;

    var
        AppMgt: Codeunit AppMgtNVX;
}