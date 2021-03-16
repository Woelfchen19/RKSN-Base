codeunit 50006 Table39HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Purchase Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Purchase Line")
    var
        PurchaseLineNVX: Record PurchaseLineNVX;
    begin
        If PurchaseLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then
            PurchaseLineNVX.Delete();
    end;
}