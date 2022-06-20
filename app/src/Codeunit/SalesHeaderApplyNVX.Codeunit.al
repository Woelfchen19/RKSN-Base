codeunit 50037 "SalesHeaderApplyNVX"
{
    TableNo = "Sales Header";

    trigger OnRun()
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        SalesHeader.Copy(Rec);
        BilToCustNo := SalesHeader."Bill-to Customer No.";
        CustLedgEntry.SetCurrentKey("Customer No.", Open);
        CustLedgEntry.SetRange("Customer No.", BilToCustNo);
        CustLedgEntry.SetRange(Open, true);
        if AppMgt.GetActivatedReminderExtensionSetup() then
            AppMgt.SetCustLedgEntryFilter(CustLedgEntry, SalesHeader."Dimension Set ID", true);
        if SalesHeader."Applies-to ID" = '' then
            SalesHeader."Applies-to ID" := SalesHeader."No.";
        if SalesHeader."Applies-to ID" = '' then
            Error(
              Text000Err,
              SalesHeader.FieldCaption("No."), SalesHeader.FieldCaption("Applies-to ID"));
        ApplyCustEntries.SetSales(SalesHeader, CustLedgEntry, SalesHeader.FieldNo("Applies-to ID"));
        ApplyCustEntries.SetRecord(CustLedgEntry);
        ApplyCustEntries.SetTableView(CustLedgEntry);
        ApplyCustEntries.LookupMode(true);
        OK := ApplyCustEntries.RunModal() = ACTION::LookupOK;
        if OK then
            ApplyCustEntries.GetRecord(CustLedgEntry2);
        Clear(ApplyCustEntries);
        if not OK then
            exit;
        CustLedgEntry.Reset();
        CustLedgEntry.SetCurrentKey("Customer No.", Open);
        CustLedgEntry.SetRange("Customer No.", BilToCustNo);
        CustLedgEntry.SetRange(Open, true);
        CustLedgEntry.SetRange("Applies-to ID", SalesHeader."Applies-to ID");
        if CustLedgEntry.FindFirst() then begin
            SalesHeader."Applies-to Doc. Type" := 0;
            SalesHeader."Applies-to Doc. No." := '';
        end else
            SalesHeader."Applies-to ID" := '';

        Modify();
    end;

    procedure GetApplyCustLedgerEntries(var CustomerLedgerEntry: Record "Cust. Ledger Entry")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.GetCustLedgEntryFilterForApply(CustLedgEntry2);
        CustomerLedgerEntry.Copy(CustLedgEntry2);
    end;

    var
        CustLedgEntry: Record "Cust. Ledger Entry";
        CustLedgEntry2: Record "Cust. Ledger Entry";
        SalesHeader: Record "Sales Header";
        ApplyCustEntries: Page "Apply Customer Entries";
        OK: Boolean;
        BilToCustNo: Code[20];
        Text000Err: Label 'You must specify %1 or %2.', comment = 'DEA="Sie müssen %1 oder %2 angeben!"';
}