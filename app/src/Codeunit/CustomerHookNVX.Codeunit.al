codeunit 50023 CustomerHookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertEvent(var Rec: Record "Customer"; RunTrigger: Boolean)
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
    begin
        CustomerBusinessField.InsertSetupBusinessField(Rec."No.");
    end;

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