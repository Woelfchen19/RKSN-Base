codeunit 50007 Table36HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Sales Header")
    var
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        if Rec.IsTemporary then
            exit;
        if SalesHeaderNVX.Get(Rec."Document Type", Rec."No.") then
            SalesHeaderNVX.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(Rec: Record "Sales Header"; xRec: Record "Sales Header")
    var
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        if Rec.IsTemporary then
            exit;
        if not SalesHeaderNVX.Get(Rec."Document Type", xRec."No.") then
            exit;

        SalesHeaderNVX."No." := Rec."No.";
        SalesHeaderNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnBeforeInsertEvent', '', false, false)]
    local procedure SetCustomer(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
        MissingSetupErr: Label 'Inventory Setup field Composition Customer must be filled', Comment = 'DEA="In der Lager Einrichtung fehlt im Feld "Abfassung Debitor" die Zuordnung. Sie können deshalb keinen neuen Auftrag generieren!"';
    begin
        if Rec.IsTemporary or not RunTrigger then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            if not InvSetupNVX.Get() then
                Clear(InvSetupNVX);
            if InvSetupNVX."Composition Customer" = '' then
                Error(MissingSetupErr);
            Rec.Validate("Sell-to Customer No.", InvSetupNVX."Composition Customer");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Header", 'OnAfterInsertEvent', '', false, false)]
    local procedure SetCompositionFields(var Rec: Record "Sales Header"; RunTrigger: Boolean)
    var
        InvSetupNVX: Record InvSetupNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        if Rec.IsTemporary or not RunTrigger then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            InvSetupNVX.Get();
            if not SalesHeaderNVX.Get(Rec."Document Type", Rec."No.") then begin
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
        if Rec.IsTemporary then
            exit;
        if Rec."Document Type" = Rec."Document Type"::Order then begin
            InvSetupNVX.Get();
            if Rec."Sell-to Customer No." <> InvSetupNVX."Composition Customer" then
                if SalesHeaderNVX.Get(Rec."Document Type", Rec."No.") then begin
                    Clear(SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES");
                    SalesHeaderNVX.Modify();
                end;
        end;
    end;
}