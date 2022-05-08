codeunit 50023 CustomerHookNVX
{

    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterValidateEvent', 'Name', true, true)]
    local procedure OnAfterValidateEvent(var Rec: Record "Customer"; var xRec: Record "Customer"; CurrFieldNo: Integer)
    var
        AppMgt: codeunit AppMgtNVX;
    begin
        Appmgt.InsertPKShortCutdimension(Rec);
        AppMgt.InsertPKDefaultDim(Rec);
    end;

}