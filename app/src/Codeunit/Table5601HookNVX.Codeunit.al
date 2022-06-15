codeunit 50002 Table5601HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"FA Ledger Entry", 'OnAfterInsertEvent', '', false, false)]
    local procedure SetAllocationCodeFromCorrectioEntry(var Rec: Record "FA Ledger Entry")
    var
        FALedgerEntryNVX: Record FALedgerEntryNVX;
        NewFALedgerEntryNVX: Record FALedgerEntryNVX;
    begin
        if Rec.IsTemporary() then
            exit;
        If Rec."Reversed Entry No." > 0 then
            if FALedgerEntryNVX.Get(Rec."Reversed Entry No.") then begin
                NewFALedgerEntryNVX."Entry No." := Rec."Entry No.";
                NewFALedgerEntryNVX."Allocation Code" := FALedgerEntryNVX."Allocation Code";
                if not NewFALedgerEntryNVX.Insert() then
                    NewFALedgerEntryNVX.Modify();
            end;
    end;
}