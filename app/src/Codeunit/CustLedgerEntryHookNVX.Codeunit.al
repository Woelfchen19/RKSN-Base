codeunit 50007 CustLedgerEntryHookNVX
{

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyCustLedgerEntry(var Rec: Record "Cust. Ledger Entry"; var xRec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    begin
        Rec.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;
}