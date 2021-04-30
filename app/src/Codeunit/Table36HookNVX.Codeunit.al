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

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure SetCompositionFields(var Rec: Record "Sales Header";RunTrigger : Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        IF Rec.IsTemporary or not RunTrigger then
            exit;
        IF Rec."Document Type" = Rec."Document Type"::Order then begin
            InvSetupNVX.Get();
            If not SalesHeaderNVX.Get(Rec."Document Type",Rec."No.") then begin
                SalesHeaderNVX.Init();
                SalesHeaderNVX."Document Type" := Rec."Document Type";
                SalesHeaderNVX."No." := Rec."No.";
                SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES" := InvSetupNVX."Comp Gen. Bus. Pst Grp WES";
                SalesHeaderNVX.Insert();
            end else begin
                SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES" := InvSetupNVX."Comp Gen. Bus. Pst Grp WES";
                SalesHeaderNVX.Modify();
            end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterValidateEvent', 'Sell-to Customer No.', false, false)]
    local procedure ClearCompositionFields(var Rec: Record "Sales Header")
    var
        InvSetupNVX: Record InvSetupNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        IF Rec.IsTemporary then
            exit;
        IF Rec."Document Type" = Rec."Document Type"::Order then begin
            InvSetupNVX.Get();
            IF Rec."Sell-to Customer No." <> InvSetupNVX."Composition Customer" then
                IF SalesHeaderNVX.Get(Rec."Document Type",Rec."No.") then begin
                    Clear(SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES");
                    SalesHeaderNVX.Modify();
                end;
        end;
    end;
}