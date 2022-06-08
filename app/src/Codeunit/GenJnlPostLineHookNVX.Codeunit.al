codeunit 50007 "GenJnlPostLineHookNVX"
{

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertGlobalGLEntry', '', true, true)]
    local procedure OnBeforeInsertGlobalGLEntry(var GlobalGLEntry: Record "G/L Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        GlobalGLEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnAfterCustLedgEntryInsert', '', true, true)]
    local procedure OnAfterCustLedgEntryInsert(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        //CustLedgerEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeCustLedgEntryInsert', '', true, true)]
    local procedure OnBeforeInsertCustLedgEntry(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            CustLedgerEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
            CustLedgerEntry.SetAssociatedNVX();
            // AppMgt.GetPaymentMethodCodeCustomer(
            //     CustLedgerEntry."Customer No.",
            //         CustLedgerEntry.ShortcutDimension5CodeNVX,
            //             CustLedgerEntry."Payment Method Code");
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertDtldCustLedgEntry', '', true, true)]
    local procedure OnBeforeInsertDtldCustLedgEntry(var DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; GenJournalLine: Record "Gen. Journal Line"; DtldCVLedgEntryBuffer: Record "Detailed CV Ledg. Entry Buffer")
    begin
        DtldCustLedgEntry.DimensionSetIDNVX := GenJournalLine."Dimension Set ID";
        DtldCustLedgEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
    end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Post Line", 'OnBeforeInsertVATEntry', '', true, true)]
    local procedure OnBeforeInsertVATEntry(var VATEntry: Record "VAT Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        VATEntry.DimensionSetIDNVX := GenJournalLine."Dimension Set ID";
        VATEntry.CopyShortCutDimensionsFromDimensionValuesNVX();
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