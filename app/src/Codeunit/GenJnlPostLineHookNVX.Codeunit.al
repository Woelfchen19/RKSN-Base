codeunit 50007 "GenJnlPostLineHookNVX"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterCustLedgEntryInsert', '', true, true)]
    local procedure OnAfterCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        CustLedgerEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertVATEntry', '', true, true)]
    local procedure OnBeforeInsertVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VATEntry.DimensionSetIDNVX := GenJournalLine."Dimension Set ID";
        VATEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

}