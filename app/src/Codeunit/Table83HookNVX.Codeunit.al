codeunit 50025 Table83HookNVX
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

    [EventSubscriber(ObjectType::Table, Database::"Item journal Line", 'OnAfterModifyEvent', '', false, false)]
    local procedure CheckDimensions(var Rec: Record "Item Journal Line"; var xRec: Record "Item Journal Line")
    var
        Item: Record Item;
        InvSetupNVX: Record InvSetupNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[8] of Code[20];
        WrongDimInventoryValueErr: Label 'Item has inventory value. Dimension have to match the setup.', Comment = 'DEA="Der erfasste Artikel ist lagerbewertet eingerichtet. Die Angaben zu Kostenstelle und Sparte müssen dem setup der Lager Einrichtung entsprechen!"';
        WrongDimInventoryValueZeroErr: Label 'This item has no inventory value. Cost Center and Section are obligatory. Values set up in the inventory setup are not allowed for items without inventory value.', Comment = 'DEA="Der Artikel ist nicht lagerbewertet eingerichtet. Das setup zu Kostenstelle und Sparte ist pflichtig. Darüber hinaus dürfen die Dimensionswerte aus der Lager-Einrichtung für lagerbewertete Artikel nicht zugeordnet werden!"';
    begin
        IF Rec."Dimension Set ID" = xRec."Dimension Set ID" then
            exit;
        If not Item.Get(Rec."Item No.") then
            exit;
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
        Case Item."Inventory Value Zero" of
            true:
                begin
                    Rec.TestField("Shortcut Dimension 1 Code");
                    Rec.TestField("Shortcut Dimension 2 Code");
                    if ShortcutDims[3] = '' then
                        Error(WrongDimInventoryValueZeroErr);
                end;
            false:
                begin
                    InvSetupNVX.Get();
                    if Rec."Shortcut Dimension 1 Code" <> InvSetupNVX."Inventory Cost Center" then
                        Error(WrongDimInventoryValueErr);
                    if ShortcutDims[3] <> InvSetupNVX."Inventory Section" then
                        Error(WrongDimInventoryValueErr);
                end;
        end; //of Case
    end;
}