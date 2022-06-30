codeunit 50039 "ApplyVendorEntriesNVX"
{
    [EventSubscriber(ObjectType::Page, Page::"Apply Vendor Entries", 'OnFindApplyingEntryOnAfterSetFilters', '', true, true)]
    local procedure OnFindApplyingEntryOnAfterSetFilters(ApplyingVendLedgEntry: Record "Vendor Ledger Entry"; VAR VendorLedgerEntry: Record "Vendor Ledger Entry")
    begin
        AppMgt.SetVendLedgEntryFilter(VendorLedgerEntry, true);
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
}