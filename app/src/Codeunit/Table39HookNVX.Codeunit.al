codeunit 50018 "Table39HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Purchase Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure InsertFixedPurchaseGenBusPostingGroup(var Rec: Record "Purchase Line")
    var
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        ItemNVX: Record ItemNVX;
    begin
        if Rec.Type = Rec.Type::Item then begin
            Item.Get(Rec."No.");
            if Item."Inventory Value Zero" then
                exit;
            if ItemNVX.Get(Rec."No.") and ItemNVX."No Inv Gen. Bus. Posting Group" then
                exit;
            InvSetupNVX.Get();
            Rec.Validate("Gen. Bus. Posting Group", InvSetupNVX."Purch Gen. Bus. Pst Grp Fixed");
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure CheckFixedPurchaseGenBusPostingGroup(var Rec: Record "Purchase Line")
    var
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        ItemNVX: Record ItemNVX;
        WrongGenBusPostingGroupErr: Label 'Gen. Business Posting Group can not be changed. Check Item Master Data where required.', comment = 'DEA="Der Steuerschlüssel kann nicht geändert werden. Überprüfen Sie gegebenenfalls die Stammdaten des Artikels!"';
    begin
        if Rec.Type = Rec.Type::Item then begin
            Item.Get(Rec."No.");
            if Item."Inventory Value Zero" then
                exit;
            if ItemNVX.Get(Rec."No.") and ItemNVX."No Inv Gen. Bus. Posting Group" then
                exit;
            InvSetupNVX.Get();
            if Rec."Gen. Bus. Posting Group" <> InvSetupNVX."Purch Gen. Bus. Pst Grp Fixed" then
                Error(WrongGenBusPostingGroupErr);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Dimension Set ID', false, false)]
    local procedure CheckForInventorySetupDimensions(Rec: Record "Purchase Line")
    var
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[10] of Code[20];
        InvValueErr: Label 'This item has inventory value. Cost Center and Section are obligatory. Only values set up in the inventory setup are allowed for items with inventory value., ',
                                comment = 'DEA="Der Artikel ist lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte muss der Lager-Einrichtung entsprechen"';
    begin
        if Rec.Type <> Rec.Type::Item then
            exit;
        if Item.Get(Rec."No.") and Item."Inventory Value Zero" then
            exit;
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
        InvSetupNVX.Get();
        if ShortcutDims[1] <> InvSetupNVX."Inventory Cost Center" then
            Error(InvValueErr);
        if ShortcutDims[3] <> InvSetupNVX."Inventory Section" then
            Error(InvValueErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Qty. to Receive', false, false)]
    local procedure CheckForPartialShipment(var Rec: Record "Purchase Line")
    var
        Item: Record Item;
        NoPartialShipmentErr: Label 'Partial shipments are not allowed.', comment = 'DEA="Teillieferungen sind bei nicht lagerbewerteten Artikeln im Modul Einkauf nicht zulässig."';
    begin
        if Item.Get(Rec."No.") and (not Item."Inventory Value Zero") then
            exit;
        if Rec."Quantity (Base)" <> Rec."Qty. to Receive (Base)" then
            Error(NoPartialShipmentErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Purchase Line", 'OnAfterValidateEvent', 'Type', false, false)]
    local procedure CheckType(Rec: Record "Purchase Line")
    var
        TypeNotAllowedErr: Label 'Type %1 is not allowed,', Comment = 'DEA="Art %1 ist nicht erlaubt."';
    begin
        if (Rec.Type in [Rec.Type::"Charge (Item)", Rec.Type::"Fixed Asset"]) then
            Error(TypeNotAllowedErr, Rec.Type);
    end;
}