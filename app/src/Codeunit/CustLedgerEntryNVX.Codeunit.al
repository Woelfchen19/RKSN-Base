codeunit 50034 "CustLedgerEntryNVX"
{
    //ToDo perhaps i need it for Payment Terms Code or Reminder Code
    // [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnAfterCopyCustLedgerEntryFromGenJnlLine', '', true, true)]
    // local procedure OnAfterCopyCustLedgerEntryFromGenJnlLine(var CustLedgerEntry: Record "Cust. Ledger Entry"; GenJournalLine: Record "Gen. Journal Line")
    // var
    //     AppMgt: Codeunit AppMgtNVX;
    // begin
    //     if AppMgt.GetActivatedReminderExtensionSetup() then
    //         AppMgt.GetPaymentMethodCodeCustomer(
    //             CustLedgerEntry."Customer No.",
    //                 CustLedgerEntry.ShortcutDimension5CodeNVX,
    //                     CustLedgerEntry."Payment Method Code")
    // end;
}