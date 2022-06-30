codeunit 50032 "PurchaseHeaderApplyNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purchase Header Apply", 'OnRunOnBeforeFilterVendLedgEntry', '', true, true)]
    local procedure OnRunOnBeforeFilterVendLedgEntry(var VendLedgEntry: Record "Vendor Ledger Entry")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetVendLedgEntryFilter(VendLedgEntry, true);
    end;

    //ToDo check the code above
    //OnRunOnBeforeFilterVendLedgEntry
    //OnRunOnBeforeFilterVendLedgEntryFindFirst

    // TableNo = "Purchase Header";

    // trigger OnRun()
    // begin
    //     PurchHeader.Copy(Rec);
    //     PayToVendorNo := PurchHeader."Pay-to Vendor No.";
    //     VendLedgEntry.SetCurrentKey("Vendor No.", Open);
    //     VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
    //     VendLedgEntry.SetRange(Open, true);

    //     AppMgt.SetVendLedgEntryFilter(VendLedgEntry, Rec, true);

    //     if "Applies-to ID" = '' then
    //         "Applies-to ID" := "No.";
    //     if "Applies-to ID" = '' then
    //         Error(
    //           Text000Msg,
    //           FieldCaption("No."), FieldCaption("Applies-to ID"));
    //     ApplyVendEntries.SetPurch(PurchHeader, VendLedgEntry, FieldNo("Applies-to ID"));
    //     ApplyVendEntries.SetRecord(VendLedgEntry);
    //     ApplyVendEntries.SetTableView(VendLedgEntry);
    //     ApplyVendEntries.LookupMode(true);
    //     OK := ApplyVendEntries.RunModal() = ACTION::LookupOK;
    //     Clear(ApplyVendEntries);
    //     if not OK then
    //         exit;
    //     VendLedgEntry.Reset();
    //     VendLedgEntry.SetCurrentKey("Vendor No.", Open);
    //     VendLedgEntry.SetRange("Vendor No.", PayToVendorNo);
    //     VendLedgEntry.SetRange(Open, true);
    //     VendLedgEntry.SetRange("Applies-to ID", "Applies-to ID");
    //     if VendLedgEntry.FindFirst() then begin
    //         "Applies-to Doc. Type" := 0;
    //         "Applies-to Doc. No." := '';
    //     end else
    //         "Applies-to ID" := '';

    //     Modify();
    // end;

    // var
    //     PurchHeader: Record "Purchase Header";
    //     VendLedgEntry: Record "Vendor Ledger Entry";
    //     AppMgt: Codeunit AppMgtNVX;
    //     ApplyVendEntries: Page "Apply Vendor Entries";
    //     OK: Boolean;
    //     PayToVendorNo: Code[20];
    //     Text000Msg: Label 'You must specify %1 or %2.', comment = 'DEA="Sie müssen %1 or %2 spezifizieren."';
}