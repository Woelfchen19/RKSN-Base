codeunit 50021 Page31HookNVX
{
    [EventSubscriber(ObjectType::Page, Page::"Item List", 'OnBeforeCopyItem', '', false, false)]
    local procedure SubstitueItemCopyReport(var Item: Record Item; var IsHandled: Boolean)
    var
        NewItem: Record Item;
        ItemCopyNVX: Report ItemCopyNVX;
        Text11500: Label 'Do you want to edit the new item?', comment = 'DEA="Möchten Sie den neuen Artikel bearbeiten?"';
    begin
        ItemCopyNVX.ItemDef(Item);
        ItemCopyNVX.RUNMODAL;
        IF ItemCopyNVX.ItemReturn(NewItem) THEN
            IF CONFIRM(Text11500,TRUE) THEN BEGIN
                PAGE.RUNMODAL(PAGE::"Item Card",NewItem);
            END;            
        IsHandled := true;
    end;
}