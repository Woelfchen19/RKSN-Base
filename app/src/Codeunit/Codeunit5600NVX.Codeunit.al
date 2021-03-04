codeunit 50016 Codeunit5600NVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"FA Insert Ledger Entry", 'OnBeforeInsertRegister', '', false, false)]
    local procedure InsertRecInAccompaniedLedgerTable(VAR FALedgerEntry : Record "FA Ledger Entry";VAR FALedgerEntry2 : Record "FA Ledger Entry")
    var
        FixedAssetNVX: Record FixedAssetNVX;
        FALedgerEntryNVX: Record FALedgerEntryNVX;
    begin
        IF FixedAssetNVX.get(FALedgerEntry."FA No.") AND (FixedAssetNVX."Allocation Code" <> '') then begin
            FALedgerEntryNVX.Init();
            FALedgerEntryNVX."Entry No." := FALedgerEntry."Entry No.";
            FALedgerEntryNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
            FALedgerEntryNVX.Insert();
        end;
    end;
}