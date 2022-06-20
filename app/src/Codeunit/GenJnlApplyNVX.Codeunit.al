codeunit 50029 "GenJnlApplyNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnSelectCustLedgEntryOnAfterSetFilters', '', true, true)]
    local procedure OnSelectCustLedgEntryOnAfterSetFilters(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    begin
        AppMgt.SetCustLedgEntryFilter(CustLedgerEntry, GenJournalLine."Dimension Set ID", true);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Gen. Jnl.-Apply", 'OnAfterRun', '', true, true)]
    local procedure OnAfterRun(var GenJnlLine: Record "Gen. Journal Line")
    begin
        AppMgt.ChangeShortcutDimension5CodeGenJnlLine(GenJnlLine);
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
}