codeunit 50007 "GenJnlPostLineHookNVX"
{
    //ToDo check OnAfter
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    local procedure OnBeforeInsertGlobalGLEntry(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GlobalGLEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterCustLedgEntryInsert', '', true, true)]
    local procedure OnBeforeInsertCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            CustLedgerEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
            CustLedgerEntry.SetAssociatedNVX();
            CustLedgerEntry.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertDtldCustLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry.DimensionSetIDNVX := GenJournalLine."Dimension Set ID";
        DtldCustLedgEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
        DtldCustLedgEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterVendLedgEntryInsert', '', true, true)]
    local procedure OnBeforeInsertVendLedgEntry(var VendorLedgerEntry: Record "Vendor Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            VendorLedgerEntry.SetAssociatedNVX();
            VendorLedgerEntry.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterInsertVATEntry', '', true, true)]
    local procedure OnAfterInsertVATEntry(GenJnlLine: Record "Gen. Journal Line"; VATEntry: Record "VAT Entry"; GLEntryNo: Integer; var NextEntryNo: Integer)
    begin
        VATEntry.DimensionSetIDNVX := GenJnlLine."Dimension Set ID";
        VATEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
        VATEntry.Modify();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnCustPostApplyCustLedgEntryOnBeforeCheckPostingGroup', '', true, true)]
    local procedure OnCustPostApplyCustLedgEntryOnBeforeCheckPostingGroup(var GenJournalLine: Record "Gen. Journal Line"; var Customer: Record "Customer")
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
    begin
        if CustomerBusinessField.Get(Customer."No.", GenJournalLine.ShortcutDimension5CodeNVX) then
            GenJournalLine."Posting Group" := CustomerBusinessField."Shortcut Dimension 5 Code";
    end;

}