codeunit 50007 Table36HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Sales Header")
    var
        DocInfo: Record DocInfoNVX;
    begin
        IF DocInfo.Get(DocInfo.Department::Sales,Rec."Document Type",Rec."No.") then
            DocInfo.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(Rec: Record "Sales Header"; xRec: Record "Sales Header")
    var
        DocInfo: Record DocInfoNVX;
    begin
        IF not DocInfo.Get(DocInfo.Department::Sales,Rec."Document Type",xRec."No.") then
            exit;

        DocInfo."Document No." := Rec."No.";
        DocInfo.Modify();
    end;
}