codeunit 50007 Table36HookNVX
{
    // Problematic because of the possibility of multiple inserts in one write transaction
    //
    // [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    // local procedure InsertRecordInAccompaniedTable(Rec: Record "Sales Header")
    // var
    //     DocInfo: Record DocInfoNVX;
    // begin
    //     IF DocInfo.Get(DocInfo.Department::Sales,Rec."Document Type",Rec."No.") then
    //         DocInfo.Delete();

    //     DocInfo.Init();
    //     DocInfo.Department := DocInfo.Department::Sales;
    //     DocInfo."Document Type" := Rec."Document Type";
    //     DocInfo."Document No." := Rec."No.";
    //     DocInfo.Insert();
    // end;

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