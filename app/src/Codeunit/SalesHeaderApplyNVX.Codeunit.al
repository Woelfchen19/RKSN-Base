codeunit 50037 "SalesHeaderApplyNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales Header Apply", 'OnRunOnBeforeFilterCustLedgEntry', '', true, true)]
    local procedure OnRunOnBeforeFilterCustLedgEntry(var CustLedgEntry: Record "Cust. Ledger Entry")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetCustLedgEntryFilter(CustLedgEntry, true);
    end;

    //ToDo check the code above
    //OnRunOnBeforeFilterCustLedgEntry
    //OnRunOnBeforeFilterCustLedgEntryFindFirst    
    // var
    //         AppMgt: Codeunit AppMgtNVX;
    //     begin
    //             AppMgt.SetCustLedgEntryFilter(CustLedgEntry, SalesHeader."Dimension Set ID", true);
    //     end;

    //     procedure GetApplyCustLedgerEntries(var CustomerLedgerEntry: Record "Cust. Ledger Entry")
    //     var
    //         AppMgt: Codeunit AppMgtNVX;
    //     begin
    //         AppMgt.GetCustLedgEntryFilterForApply(CustLedgEntry2);
    //         CustomerLedgerEntry.Copy(CustLedgEntry2);
    //     end;

    //     var
    //         CustLedgEntry: Record "Cust. Ledger Entry";
    //         CustLedgEntry2: Record "Cust. Ledger Entry";
    //         SalesHeader: Record "Sales Header";
    //         ApplyCustEntries: Page "Apply Customer Entries";
    //         OK: Boolean;
    //         BilToCustNo: Code[20];
    //         Text000Err: Label 'You must specify %1 or %2.', comment = 'DEA="Sie müssen %1 oder %2 angeben!"';
}