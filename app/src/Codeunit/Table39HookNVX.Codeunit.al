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

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Type', false, false)]
    // local procedure ValidateQuantityOnAfterValidateType(Rec: Record "Purchase Line")
    // begin
    //     If Rec.Type = Rec.Type::"G/L Account" then
    //         Rec.Validate(Quantity,1);
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure ValidateQuantityOnAfterValidateNo(Rec: Record "Purchase Line")
    // begin
    //     If Rec.Type = Rec.Type::"G/L Account" then begin
    //         Rec.Validate(Quantity,1);
    //         If Rec.Modify() then;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure InsertFixedPurchaseGenBusPostingGroup(var Rec: Record "Purchase Line")
    var
        Item: Record Item;
        ItemNVX: Record ItemNVX;
        InvSetupNVX: Record InvSetupNVX;
    begin
        IF Rec.Type = Rec.Type::Item then begin
            Item.Get(Rec."No.");
            IF Item."Inventory Value Zero" then
                exit;
            IF ItemNVX.Get(Rec."No.") and ItemNVX."Deactivate Inventory Gen. Bus. Posting Group" then
                exit;
            InvSetupNVX.Get();
            Rec.Validate("Gen. Bus. Posting Group",InvSetupNVX."Purchase Gen. Bus. Posting Group Fixed");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure CheckFixedPurchaseGenBusPostingGroup(var Rec: Record "Purchase Line")
    var
        Item: Record Item;
        ItemNVX: Record ItemNVX;
        InvSetupNVX: Record InvSetupNVX;
        WrongGenBusPostingGroupErr: Label 'Gen. Business Posting Group can not be changed. Check Item Master Data where required.', comment = 'DEA="Der Steuerschlüssel kann nicht geändert werden. Überprüfen Sie gegebenenfalls die Stammdaten des Artikels!"';
    begin
        IF Rec.Type = Rec.Type::Item then begin
            Item.Get(Rec."No.");
            IF Item."Inventory Value Zero" then
                exit;
            IF ItemNVX.Get(Rec."No.") and ItemNVX."Deactivate Inventory Gen. Bus. Posting Group" then
                exit;
            InvSetupNVX.Get();
            IF Rec."Gen. Bus. Posting Group" <> InvSetupNVX."Purchase Gen. Bus. Posting Group Fixed" then
                Error(WrongGenBusPostingGroupErr);
        end;
        
    end;
}