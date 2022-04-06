codeunit 50016 Table37HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Sales Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure CompositionSetValuesOnAfterInsertSalesLine(var Rec: Record "Sales Line")
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimValueNVX: Record DimValueNVX;
        GLSetup: Record "General Ledger Setup";
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        DimMgt: Codeunit DimensionManagement;
        WrongTypeErr: Label 'Only the types ''Item'' or ''Comment'' are allowed.', comment = 'DEA="In einer Abfassung können sie nur Art ''Artikel'' oder ''leer'' wählen"';
    begin
        if Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec.Type <> Rec.Type::Item) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        if InvSetupNVX.Get() then;
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            if not (Rec.Type in [Rec.Type::Item, Rec.Type::" "]) then
                Error(WrongTypeErr);
        if not Item.Get(Rec."No.") then
            exit;

        SalesHeaderNVX.GetDefinition(Rec."Document Type", Rec."Document No.");
        SalesLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        if InvSetupNVX.Get() then;
        
        //Get Dims from OE
        GLSetup.Get();
        if DimSetEntry.Get(SalesHeader."Dimension Set ID", GLSetup."Shortcut Dimension 6 Code") then begin
            DimValueNVX.Get(GLSetup."Shortcut Dimension 6 Code", DimSetEntry."Dimension Value Code");
            Rec.Validate("Shortcut Dimension 2 Code", DimValueNVX."Shortcut Dimension 2 Code");
            SalesLineNVX."Shortcut Dimension 1 Code" := DimValueNVX."Shortcut Dimension 1 Code";
            if Item."Inventory Value Zero" then
                Rec.Validate("Shortcut Dimension 1 Code", DimValueNVX."Shortcut Dimension 1 Code");
        end;
        //Get Dims from Header
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            if SalesHeaderNVX."Shortcut Dimension 3 Code" <> '' then
                SalesLineNVX."Shortcut Dimension 3 Code" := SalesHeaderNVX."Shortcut Dimension 3 Code"
            else
                if Item."Inventory Value Zero" then
                    SalesLineNVX."Shortcut Dimension 3 Code" := InvSetupNVX."Comp Sect - Inv Value Zero";

        if Item."Inventory Value Zero" then
            DimMgt.ValidateShortcutDimValues(3, SalesLineNVX."Shortcut Dimension 3 Code", Rec."Dimension Set ID");

        if (not Item."Inventory Value Zero") and (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then begin
            if (SalesLineNVX."Shortcut Dimension 3 Code" = '') then
                SalesLineNVX."Allocation Code" := SalesHeaderNVX."Allocation Code";
            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
        end;
        Rec.Validate("Gen. Bus. Posting Group", InvSetupNVX."Comp Gen. Bus. Pst Grp Fixed");
        SalesLineNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure CompositionSetValuesOnAfterValidateNo(var Rec: Record "Sales Line")
    var
        DimSetEntry: Record "Dimension Set Entry";
        DimValueNVX: Record DimValueNVX;
        GLSetup: Record "General Ledger Setup";
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        SalesHeader: Record "Sales Header";
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        DimMgt: Codeunit DimensionManagement;
    begin
        if Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec.Type <> Rec.Type::Item) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        if InvSetupNVX.Get() then;

        if not Item.Get(Rec."No.") then
            exit;

        SalesHeaderNVX.GetDefinition(Rec."Document Type", Rec."Document No.");
        SalesLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        if InvSetupNVX.Get() then;

        //Get Dims from OE
        GLSetup.Get();
        if DimSetEntry.Get(SalesHeader."Dimension Set ID", GLSetup."Shortcut Dimension 6 Code") then begin
            DimValueNVX.Get(GLSetup."Shortcut Dimension 6 Code", DimSetEntry."Dimension Value Code");
            Rec.Validate("Shortcut Dimension 2 Code", DimValueNVX."Shortcut Dimension 2 Code");
            SalesLineNVX."Shortcut Dimension 1 Code" := DimValueNVX."Shortcut Dimension 1 Code";
            if Item."Inventory Value Zero" then
                Rec.Validate("Shortcut Dimension 1 Code", DimValueNVX."Shortcut Dimension 1 Code");
        end;
        //Get Dims from Header
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            if SalesHeaderNVX."Shortcut Dimension 3 Code" <> '' then
                SalesLineNVX."Shortcut Dimension 3 Code" := SalesHeaderNVX."Shortcut Dimension 3 Code"
            else
                if Item."Inventory Value Zero" then
                    SalesLineNVX."Shortcut Dimension 3 Code" := InvSetupNVX."Comp Sect - Inv Value Zero";

        if Item."Inventory Value Zero" then
            DimMgt.ValidateShortcutDimValues(3, SalesLineNVX."Shortcut Dimension 3 Code", Rec."Dimension Set ID");

        if not Item."Inventory Value Zero" and (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then begin
            if (SalesLineNVX."Shortcut Dimension 1 Code" = '') then
                SalesLineNVX."Allocation Code" := SalesHeaderNVX."Allocation Code";
            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
            Rec.Validate("Gen. Bus. Posting Group", InvSetupNVX."Comp Gen. Bus. Pst Grp Fixed");
        end;
        SalesLineNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Type', false, false)]
    local procedure CheckType(Rec: Record "Sales Line")
    var
        InvSetupNVX: Record InvSetupNVX;
        SalesHeader: Record "Sales Header";
        TypeNotAllowedErr: Label 'Type %1 is not allowed,', Comment = 'DEA="Art %1 ist nicht erlaubt."';
        WrongTypeErr: Label 'Only the types ''Item'' or ''Comment'' are allowed.', comment = 'DEA="In einer Abfassung können sie nur Art ''Artikel'' oder ''leer'' wählen"';
    begin
        if Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type", Rec."Document No.");
        if InvSetupNVX.Get() then;
        if SalesHeader."Sell-to Customer No." <> InvSetupNVX."Composition Customer" then begin
            if (Rec.Type in [Rec.Type::"Charge (Item)", Rec.Type::"Fixed Asset", Rec.Type::Resource]) then
                Error(TypeNotAllowedErr, Rec.Type);
            exit; //is normal sales exit here
        end;

        if not (Rec.Type in [Rec.Type::Item, Rec.Type::" "]) then
            Error(WrongTypeErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Qty. to Ship', false, false)]
    local procedure CheckForPartialShipment(var Rec: Record "Sales Line")
    var
        NoPartialShipmentErr: Label 'Partial shipments are not allowed.', comment = 'DEA="Teillieferungen sind im Modul Verkauf nicht zulässig."';
    begin
        if Rec."Quantity (Base)" <> Rec."Qty. to Ship (Base)" then
            Error(NoPartialShipmentErr);
    end;
}