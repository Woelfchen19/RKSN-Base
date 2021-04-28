codeunit 50007 "Table36HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Sales Header")
    var
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        IF Rec.IsTemporary then
            exit;
        IF SalesHeaderNVX.Get(Rec."Document Type",Rec."No.") then
            SalesHeaderNVX.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(Rec: Record "Sales Header"; xRec: Record "Sales Header")
    var
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        IF Rec.IsTemporary then
            exit;
        IF not SalesHeaderNVX.Get(Rec."Document Type",xRec."No.") then
            exit;

        SalesHeaderNVX."No." := Rec."No.";
        SalesHeaderNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure SetCustomer(var Rec: Record "Sales Header";RunTrigger : Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
    begin
        IF Rec.IsTemporary or not RunTrigger then
            exit;
        IF Rec."Document Type" = Rec."Document Type"::Order then begin
            InvSetupNVX.Get();
            Rec.Validate("Sell-to Customer No.",InvSetupNVX."Composition Customer");
            // Rec.Modify();
        end;
    end;
}