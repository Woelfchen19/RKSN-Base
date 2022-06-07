codeunit 50000 ItemCheckAvailHookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item-Check Avail.", 'OnBeforeShowWarningForThisItem', '', false, false)]
    local procedure HandleStockOutWarning(Item: Record Item; var ShowWarning: Boolean; var IsHandled: Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
        MyNotifications: Record "My Notifications";
        ItemCheckCU: Codeunit "Item-Check Avail.";
    begin
        IsHandled := true;

        if Item.Type = Item.Type::Service then begin
            ShowWarning := false;
            exit;
        end;

        if not MyNotifications.IsEnabledForRecord(ItemCheckCU.GetItemAvailabilityNotificationId(), Item) then begin
            ShowWarning := false;
            exit;
        end;

        case Item."Stockout Warning" of
            Item."Stockout Warning"::No:
                ShowWarning := false;
            Item."Stockout Warning"::Yes:
                ShowWarning := true;
            Item."Stockout Warning"::Default:
                begin
                    InvSetupNVX.Get();
                    case true of
                        Item."Inventory Value Zero" and (not InvSetupNVX."Allow Neg. Inv. no Stock Value"):
                            ShowWarning := true;
                        (not Item."Inventory Value Zero") and (not InvSetupNVX."Allow Neg. Inv. Stock Value"):
                            ShowWarning := true;
                        else
                            ShowWarning := false;
                    end;
                end;
        end;
    end;
}