// codeunit 50001 Table37HookNVX
// {
// [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
// local procedure SetStatusCheckSuspended(var Rec: Record "Sales Line")
// begin
//     Rec.SuspendStatusCheck(true);
// end;
// }