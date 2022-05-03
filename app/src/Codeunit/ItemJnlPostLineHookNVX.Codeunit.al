codeunit 50027 ItemJnlPostLineHookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertItemLedgEntry', '', true, true)]
    local procedure OnBeforeInsertItemLedgEntry(var ItemLedgerEntry: Record "Item Ledger Entry"; ItemJournalLine: Record "Item Journal Line"; TransferItem: Boolean)
    begin
        ItemLedgerEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforeInsertValueEntry', '', true, true)]
    local procedure OnBeforeInsertValueEntry
    (
        var ValueEntry: Record "Value Entry";
        ItemJournalLine: Record "Item Journal Line";
        var ItemLedgerEntry: Record "Item Ledger Entry";
        var ValueEntryNo: Integer;
        var InventoryPostingToGL: Codeunit "Inventory Posting To G/L";
        CalledFromAdjustment: Boolean
    )
    begin
        ValueEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;
}