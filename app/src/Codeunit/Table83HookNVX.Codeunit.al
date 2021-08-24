codeunit 50025 "Table83HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Item Journal Line", 'OnAfterValidateEvent', 'Entry Type', true, true)]
    local procedure OnAfterValidateEntryType(rec: record "Item Journal Line"; xrec: record "Item Journal Line"; CurrfieldNo: integer)
    var
        EntryTypeErr: Label 'Only Entry Type "Positive Adjmt.", "Negative Adjmt" and "Transfer" are allowed!', comment = 'DEA="Nur die Postenarten Zugang, Abgang, Umlagerung sind erlaubt!"';
    begin
        if CurrfieldNo = rec.fieldno("entry type") then
            if not (rec."Entry Type" IN [rec."Entry Type"::"Positive Adjmt.", rec."Entry Type"::"Negative Adjmt.", rec."Entry Type"::Transfer]) then
                error(EntryTypeErr)
    end;
}