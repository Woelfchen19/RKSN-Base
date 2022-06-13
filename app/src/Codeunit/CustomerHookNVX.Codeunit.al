codeunit 50023 "CustomerHookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyEvent(var Rec: Record "Customer"; var xRec: Record "Customer"; RunTrigger: Boolean)
    var
        AppMgt: codeunit AppMgtNVX;
    begin
        Appmgt.InsertPKShortCutdimension(Rec);
        AppMgt.InsertPKDefaultDim(Rec);
        AppMgt.SetCustomerPostingGroup(Rec);
    end;
}