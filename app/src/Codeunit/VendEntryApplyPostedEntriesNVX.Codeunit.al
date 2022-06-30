codeunit 50035 "VendEntryApplyPostedEntriesNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"VendEntry-Apply Posted Entries", 'OnApplyVendEntryFormEntryOnAfterVendLedgEntrySetFilters', '', true, true)]
    local procedure OnApplyVendEntryFormEntryOnAfterVendLedgEntrySetFilters
    (
        var VendLedgEntry: Record "Vendor Ledger Entry";
        var ApplyingVendLedgEntry: Record "Vendor Ledger Entry")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetVendLedgEntryFilter(VendLedgEntry, true);
    end;
}