codeunit 50005 Codeunit80HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestGBPG', '', false, false)]
    local procedure SkipGBPGTestfield(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}