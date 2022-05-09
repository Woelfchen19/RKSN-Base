codeunit 50002 "CustLedgerEditHookNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', true, true)]
    local procedure OnBeforeCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    begin
        CustLedgEntry.Validate(ShortcutDimension5CodeNVX, FromCustLedgEntry.ShortcutDimension5CodeNVX);
    end;
}