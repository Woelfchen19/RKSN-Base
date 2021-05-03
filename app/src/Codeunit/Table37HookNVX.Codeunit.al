codeunit 50001 "Table37HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Sales Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    // local procedure DeleteRecordInAccompaniedTable(Rec: Record "Sales Line")
    // var
    //     SalesLineNVX: Record SalesLineNVX;
    // begin
    //     IF Rec.IsTemporary then
    //         exit;
    //     IF confirm(Format(Rec.IsTemporary)) then;
    //     If SalesLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then
    //         SalesLineNVX.Delete();
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Type', false, false)]
    // local procedure ValidateQuantityOnAfterValidateType(Rec: Record "Sales Line")
    // begin
    //     If Rec.Type = Rec.Type::"G/L Account" then begin
    //         Rec.Validate(Quantity,1);
    //         IF Rec.Modify() then;
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure CompositionSetValuesOnAfterInsertSalesLine(var Rec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        DimValueNVX: Record DimValueNVX;
        InvSetupNVX: Record InvSetupNVX;
        GLSetup: Record "General Ledger Setup";
        DimSetEntry: Record "Dimension Set Entry";
        Item: Record Item;
        DimMgt: Codeunit DimensionManagement;
        WrongTypeErr: Label 'Only the types ''Item'' or ''Comment'' are allowed.', comment = 'DEA="In einer Abfassung können sie nur Art ''Artikel'' oder ''leer'' wählen"';
    begin
        IF Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec.Type <> Rec.Type::Item) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type",Rec."Document No.");
        IF InvSetupNVX.Get() then;
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            IF not (Rec.Type in [Rec.Type::Item,Rec.Type::" "]) then
                Error(WrongTypeErr);        
        If not Item.get(Rec."No.") then
            exit;

        If not SalesHeaderNVX.Get(Rec."Document Type",Rec."Document No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := Rec."Document Type";
            SalesHeaderNVX."No." := Rec."Document No.";
            SalesHeaderNVX.Insert();
        end;
        IF not SalesLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX.Insert();
        end;
        IF InvSetupNVX.Get() then;
        //Get Dims from OE
        GLSetup.Get();
        IF DimSetEntry.Get(SalesHeader."Dimension Set ID",GLSetup."Shortcut Dimension 6 Code") then begin
            DimValueNVX.Get(GLSetup."Shortcut Dimension 6 Code",DimSetEntry."Dimension Value Code");
            Rec.Validate("Shortcut Dimension 2 Code",DimValueNVX."Shortcut Dimension 2 Code");
            SalesLineNVX."Shortcut Dimension 1 Code" := DimValueNVX."Shortcut Dimension 1 Code";
            IF Item."Inventory Value Zero" then
                Rec.Validate("Shortcut Dimension 1 Code",DimValueNVX."Shortcut Dimension 1 Code");
        end;
        //Get Dims from Header
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            IF SalesHeaderNVX."Shortcut Dimension 3 Code" <> '' then
                SalesLineNVX."Shortcut Dimension 3 Code" := SalesHeaderNVX."Shortcut Dimension 3 Code"
            else
                IF Item."Inventory Value Zero" then
                    SalesLineNVX."Shortcut Dimension 3 Code" := InvSetupNVX."Comp Sect - Inv Value Zero";

        IF Item."Inventory Value Zero" then
            DimMgt.ValidateShortcutDimValues(3,SalesLineNVX."Shortcut Dimension 3 Code",Rec."Dimension Set ID");

        IF (not Item."Inventory Value Zero") and (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then begin
            IF (SalesLineNVX."Shortcut Dimension 3 Code" = '') then
                SalesLineNVX."Allocation Code" := SalesHeaderNVX."Allocation Code";
            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
        end;
        Rec.Validate("Gen. Bus. Posting Group",InvSetupNVX."Comp Gen. Bus. Pst Grp Fixed");
        SalesLineNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    local procedure CompositionSetValuesOnAfterValidateNo(var Rec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        DimValueNVX: Record DimValueNVX;
        InvSetupNVX: Record InvSetupNVX;
        GLSetup: Record "General Ledger Setup";
        DimSetEntry: Record "Dimension Set Entry";
        Item: Record Item;
        DimMgt: Codeunit DimensionManagement;
    begin
        IF Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec.Type <> Rec.Type::Item) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type",Rec."Document No.");
        IF InvSetupNVX.Get() then;

        If not Item.get(Rec."No.") then
            exit;
        If not SalesHeaderNVX.Get(Rec."Document Type",Rec."Document No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := Rec."Document Type";
            SalesHeaderNVX."No." := Rec."Document No.";
            SalesHeaderNVX.Insert();
        end;
        IF not SalesLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX.Insert();
        end;
        IF InvSetupNVX.Get() then;
        //Get Dims from OE
        GLSetup.Get();
        IF DimSetEntry.Get(SalesHeader."Dimension Set ID",GLSetup."Shortcut Dimension 6 Code") then begin
            DimValueNVX.Get(GLSetup."Shortcut Dimension 6 Code",DimSetEntry."Dimension Value Code");
            Rec.Validate("Shortcut Dimension 2 Code",DimValueNVX."Shortcut Dimension 2 Code");
            SalesLineNVX."Shortcut Dimension 1 Code" := DimValueNVX."Shortcut Dimension 1 Code";
            IF Item."Inventory Value Zero" then
                Rec.Validate("Shortcut Dimension 1 Code",DimValueNVX."Shortcut Dimension 1 Code");
        end;
        //Get Dims from Header
        if (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then
            IF SalesHeaderNVX."Shortcut Dimension 3 Code" <> '' then
                SalesLineNVX."Shortcut Dimension 3 Code" := SalesHeaderNVX."Shortcut Dimension 3 Code"
        else
            IF Item."Inventory Value Zero" then
                SalesLineNVX."Shortcut Dimension 3 Code" := InvSetupNVX."Comp Sect - Inv Value Zero";

        IF Item."Inventory Value Zero" then
            DimMgt.ValidateShortcutDimValues(3,SalesLineNVX."Shortcut Dimension 3 Code",Rec."Dimension Set ID");

        IF not Item."Inventory Value Zero" and (SalesHeader."Sell-to Customer No." = InvSetupNVX."Composition Customer") then begin
            IF (SalesLineNVX."Shortcut Dimension 1 Code" = '') then
                SalesLineNVX."Allocation Code" := SalesHeaderNVX."Allocation Code";
            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
            Rec.Validate("Gen. Bus. Posting Group",InvSetupNVX."Comp Gen. Bus. Pst Grp Fixed");
        end;
        SalesLineNVX.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Type', false, false)]
    local procedure CheckType(Rec: Record "Sales Line")
    var
        SalesHeader: Record "Sales Header";
        InvSetupNVX: Record InvSetupNVX;
        WrongTypeErr: Label 'Only the types ''Item'' or ''Comment'' are allowed.', comment = 'DEA="In einer Abfassung können sie nur Art ''Artikel'' oder ''leer'' wählen"';
    begin
        IF Rec.IsTemporary or (Rec."Document Type" <> Rec."Document Type"::Order) or (Rec."Line No." = 0) then
            exit;
        SalesHeader.Get(Rec."Document Type",Rec."Document No.");
        IF InvSetupNVX.Get() then;
        if SalesHeader."Sell-to Customer No." <> InvSetupNVX."Composition Customer" then
            exit; //is normal sales exit here
        
        IF not (Rec.Type in [Rec.Type::Item,Rec.Type::" "]) then
            Error(WrongTypeErr);
    end;
}