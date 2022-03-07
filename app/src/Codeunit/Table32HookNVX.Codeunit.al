codeunit 50005 Table32HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnBeforeVerifyOnInventory', '', false, false)]
    local procedure VerifyOnInventory(var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        IsNotOnInventoryErr: Label 'You have insufficient quantity of Item %1 on inventory.', comment = 'DEA="Sie haben keine ausreichende Menge des Artikels %1 auf Lager."';
    begin
        IsHandled := true;
        if not ItemLedgerEntry.Open then
            exit;
        if ItemLedgerEntry.Quantity >= 0 then
            exit;

        case ItemLedgerEntry."Entry Type" of
            ItemLedgerEntry."Entry Type"::Consumption, ItemLedgerEntry."Entry Type"::"Assembly Consumption", ItemLedgerEntry."Entry Type"::Transfer:
                Error(IsNotOnInventoryErr, ItemLedgerEntry."Item No.");
            else begin
                    Item.Get(ItemLedgerEntry."Item No.");
                    case Item."Prevent Negative Inventory" of
                        Item."Prevent Negative Inventory"::Yes:
                            Error(IsNotOnInventoryErr, ItemLedgerEntry."Item No.");
                        Item."Prevent Negative Inventory"::No:
                            exit;
                        Item."Prevent Negative Inventory"::Default:
                            begin
                                InvSetupNVX.Get();
                                case true of
                                    Item."Inventory Value Zero" and (not InvSetupNVX."Allow Neg. Inv. no Stock Value"):
                                        Error(IsNotOnInventoryErr, ItemLedgerEntry."Item No.");
                                    (not Item."Inventory Value Zero") and (not InvSetupNVX."Allow Neg. Inv. Stock Value"):
                                        Error(IsNotOnInventoryErr, ItemLedgerEntry."Item No.");
                                end;
                            end;
                    end;
                end;
        end;
    end;
}