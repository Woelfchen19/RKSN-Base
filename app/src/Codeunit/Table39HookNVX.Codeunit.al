codeunit 50006 Table39HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Purchase Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;
}