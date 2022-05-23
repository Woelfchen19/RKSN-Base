codeunit 50002 "CustLedgerEditHookNVX"
{
    Permissions = tabledata "G/L Entry" = rm,
                  tabledata "Detailed Cust. Ledg. Entry" = rm;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Cust. Entry-Edit", 'OnBeforeCustLedgEntryModify', '', true, true)]
    local procedure OnBeforeCustLedgEntryModify(var CustLedgEntry: Record "Cust. Ledger Entry"; FromCustLedgEntry: Record "Cust. Ledger Entry")
    var
        UserSetup: Record "User Setup";
        GLEntry: Record "G/L Entry";
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
    begin
        UserSetup.Get(UserID);
        if not UserSetup.EditBusFieldCustLedgerEntryNVX then
            exit;

        if CustLedgEntry.ShortcutDimension5CodeNVX <> FromCustLedgEntry.ShortcutDimension5CodeNVX then
            CustLedgEntry.Validate(ShortcutDimension5CodeNVX, FromCustLedgEntry.ShortcutDimension5CodeNVX);
        if CustLedgEntry.ShortcutDimension9CodeNVX <> FromCustLedgEntry.ShortcutDimension9CodeNVX then
            CustLedgEntry.Validate(ShortcutDimension9CodeNVX, FromCustLedgEntry.ShortcutDimension9CodeNVX);

        if (CustLedgEntry.ShortcutDimension5CodeNVX <> FromCustLedgEntry.ShortcutDimension5CodeNVX) or
            (CustLedgEntry.ShortcutDimension9CodeNVX <> FromCustLedgEntry.ShortcutDimension9CodeNVX)
        then begin
            GLEntry.SetRange("Posting Date", CustLedgEntry."Posting Date");
            GLEntry.SetRange("Document No.", CustLedgEntry."Document No.");
            if GLEntry.FindSet() then
                repeat
                    GLentry."Dimension Set ID" := CustLedgEntry."Dimension Set ID";
                    GLEntry.Modify();
                until GLEntry.Next() = 0;
        end;
        DetailedCustLedgEntry.SetRange("Posting Date", CustLedgEntry."Posting Date");
        DetailedCustLedgEntry.SetRange("Document No.", CustLedgEntry."Document No.");
        if DetailedCustLedgEntry.FindSet() then
            repeat
                DetailedCustLedgEntry.DimensionSetIDNVX := CustLedgEntry."Dimension Set ID";
                DetailedCustLedgEntry.Modify();
            until DetailedCustLedgEntry.Next() = 0;
    end;
}