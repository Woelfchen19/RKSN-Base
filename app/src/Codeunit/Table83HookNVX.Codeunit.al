codeunit 50025 Table83HookNVX
{
    [EventSubscriber(ObjectType::Table, database::"item journal line", 'OnAfterValidateEvent', 'Entry Type', true, true)]
    local procedure OnAfterValidateEntryType(rec: record "Item Journal Line"; xrec: record "Item Journal Line"; CurrfieldNo: integer)
    var
        Error_EntryType: Label 'Only Entry Type "Positive Adjmt.", "Negative Adjmt" and "Transfer" are allowed!', comment = 'DEA="Nur die Postenarten Zugang, Abgang, Umlagerung sind erlaubt!"';
    begin
        if CurrfieldNo = rec.fieldno("entry type") then
            if not(rec."Entry Type" IN [rec."Entry Type"::"Positive Adjmt.", rec."Entry Type"::"Negative Adjmt.", rec."Entry Type"::Transfer]) then
                error(Error_EntryType)
    end;
}