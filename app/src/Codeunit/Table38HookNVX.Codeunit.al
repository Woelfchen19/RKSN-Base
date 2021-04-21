codeunit 50008 Table38HookNVX
{
    
    // Problematic because of the possibility of multiple inserts in one write transaction
    //
    // [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterInsertEvent', '', false, false)]
    // local procedure InsertRecordInAccompaniedTable(Rec: Record "Purchase Header")
    // var
    //     DocInfo: Record DocInfoNVX;
    // begin
    //     IF DocInfo.Get(DocInfo.Department::Purchase,Rec."Document Type",Rec."No.") then
    //         DocInfo.Delete();

    //     DocInfo.Init();
    //     DocInfo.Department := DocInfo.Department::Purchase;
    //     DocInfo."Document Type" := Rec."Document Type";
    //     DocInfo."Document No." := Rec."No.";
    //     DocInfo.Insert();
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Purchase Header")
    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
    begin
        IF PurchaseHeaderNVX.Get(Rec."Document Type",Rec."No.") then
            PurchaseHeaderNVX.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(Rec: Record "Purchase Header"; xRec: Record "Purchase Header")
    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
    begin
        IF not PurchaseHeaderNVX.Get(Rec."Document Type",xRec."No.") then
            exit;

        PurchaseHeaderNVX."No." := Rec."No.";
        PurchaseHeaderNVX.Modify();
    end;
}