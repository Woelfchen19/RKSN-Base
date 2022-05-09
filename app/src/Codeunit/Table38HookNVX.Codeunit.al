codeunit 50017 "Table38HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Purchase Header")
    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
    begin
        if PurchaseHeaderNVX.Get(Rec."Document Type", Rec."No.") then
            PurchaseHeaderNVX.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Header", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(Rec: Record "Purchase Header"; xRec: Record "Purchase Header")
    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
    begin
        if not PurchaseHeaderNVX.Get(Rec."Document Type", xRec."No.") then
            exit;

        PurchaseHeaderNVX."No." := Rec."No.";
        PurchaseHeaderNVX.Modify();
    end;
}