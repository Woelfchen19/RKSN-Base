codeunit 50005 Table32HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Item Ledger Entry", 'OnBeforeVerifyOnInventory', '', false, false)]
    local procedure VerifyOnInventory(var ItemLedgerEntry: Record "Item Ledger Entry"; var IsHandled: Boolean)
    var
        Item: Record Item;
        InvSetupNVX: Record InvSetupNVX;
        IsNotOnInventoryErr: Label 'You have insufficient quantity of Item %1 on inventory.', comment = 'DEA="Sie haben keine ausreichende Menge des Artikels %1 auf Lager."';
    begin
        IsHandled := true;
        with ItemLedgerEntry do begin
            IF NOT Open THEN
                EXIT;
            IF Quantity >= 0 THEN
                EXIT;
            
            CASE "Entry Type" OF
                "Entry Type"::Consumption,"Entry Type"::"Assembly Consumption","Entry Type"::Transfer:
                    ERROR(IsNotOnInventoryErr,"Item No.");
            ELSE 
                BEGIN
                    Item.GET("Item No.");
                    CASE Item."Prevent Negative Inventory" OF
                        Item."Prevent Negative Inventory"::Yes:
                            ERROR(IsNotOnInventoryErr,"Item No.");
                        Item."Prevent Negative Inventory"::No:
                            EXIT;
                        Item."Prevent Negative Inventory"::Default:
                            BEGIN
                                InvSetupNVX.GET();
                                Case true of
                                    Item."Inventory Value Zero" AND (NOT InvSetupNVX."Allow Neg. Inv. no Stock Value"):
                                        ERROR(IsNotOnInventoryErr,"Item No.");
                                    (NOT Item."Inventory Value Zero") AND (NOT InvSetupNVX."Allow Neg. Inv. Stock Value"):
                                        ERROR(IsNotOnInventoryErr,"Item No.");
                                end;
                            END;
                END;
            END;
        end;
    END;
    end;
}