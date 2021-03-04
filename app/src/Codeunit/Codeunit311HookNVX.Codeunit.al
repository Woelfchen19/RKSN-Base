codeunit 50017 Codeunit311HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeShowWarningForThisItem', '', false, false)]
    local procedure HandleStockOutWarning(Item: record Item; var ShowWarning: Boolean; var IsHandled: Boolean)
    var
        ItemCheckCU: Codeunit "Item-Check Avail.";
        MyNotifications: Record "My Notifications";
        InvSetupNVX: Record InvSetupNVX;
    begin
        IsHandled := true;

        IF Item.Type = Item.Type::Service THEN begin
            ShowWarning := false;
            exit;
        end;

        IF NOT MyNotifications.IsEnabledForRecord(ItemCheckCU.GetItemAvailabilityNotificationId, Item) THEN begin
            ShowWarning := false;
            exit;
        end;

        CASE Item."Stockout Warning" OF
            Item."Stockout Warning"::No :
                ShowWarning := false;
            Item."Stockout Warning"::Yes :
                ShowWarning := true;
            Item."Stockout Warning"::Default :
            BEGIN
                InvSetupNVX.GET();
                Case true of
                    Item."Inventory Value Zero" AND (NOT InvSetupNVX."Allow Neg. Inv. no Stock Value"):
                        ShowWarning := true;
                    (NOT Item."Inventory Value Zero") AND (NOT InvSetupNVX."Allow Neg. Inv. Stock Value"):
                        ShowWarning := true;
                else
                    ShowWarning := false;
                end;
            END;
        END;
    end;
}