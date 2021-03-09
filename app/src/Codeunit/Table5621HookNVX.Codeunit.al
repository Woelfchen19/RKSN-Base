codeunit 50022 Table5621HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteAccompaniedRecord(VAR Rec: Record "FA Journal Line"; RunTrigger: Boolean)
    var
        FAJnlLineNVX: Record FAJnlLineNVX;
    begin
        If not RunTrigger then
            exit;
        IF FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then
            FAJnlLineNVX.Delete(true);
    end;
}