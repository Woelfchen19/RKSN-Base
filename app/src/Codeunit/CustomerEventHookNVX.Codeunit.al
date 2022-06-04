codeunit 50032 "CustomerEventHookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Customer", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertEvent(var Rec: Record "Customer"; RunTrigger: Boolean)
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
    begin
        CustomerBusinessField.InsertSetupBusinessField(Rec."No.", false);
    end;
}