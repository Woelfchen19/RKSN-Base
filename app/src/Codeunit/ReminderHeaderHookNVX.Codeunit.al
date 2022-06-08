codeunit 50036 "ReminderHeaderHookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Reminder Header", 'OnBeforeValidateEvent', 'Reminder Terms Code', true, true)]
    local procedure OnBeforeValidateEvent(var Rec: Record "Reminder Header"; var xRec: Record "Reminder Header"; CurrFieldNo: Integer)
    var
        AppMgt: Codeunit AppMgtNVX;
        Shortcutdminension5: Code[20];
    begin
        //ToDo Shortcutdminension5
        Shortcutdminension5 := 'MAH_PB_01';
        AppMgt.GetReminderTermsCodeCode(Rec."Customer No.", Shortcutdminension5, Rec."Reminder Terms Code");
    end;
}