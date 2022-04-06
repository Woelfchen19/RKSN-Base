codeunit 50012 Table27HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Gen. Prod. Posting Group', false, false)]
    local procedure SetInventoryValueZero(var Rec: Record Item)
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
        ItemLedgerEntry: Record "Item Ledger Entry";
        UserSetupNVX: Record UserSetupNVX;
        NoItemErr: Label 'This Product Posting Group is blocked for use on Items!', comment = 'DEA="Es ist nicht möglich, diese Produktbuchungsgruppe zuzuordnen, da diese nicht zum Datawarehouse gehört!"';
        NoUserRightErr: Label 'There are Ledger Entries for this Item and you are missing the necessary user rights to change the product posting group.',
                                comment = 'DEA="Es gibt zum Artikel bereits gebuchte Posten! Sie haben keine Rechte, um nachträglich die zugeordnete Produktbuchungsgruppe zu ändern."';
    begin

        UserSetupNVX.Get(UserId());
        ItemLedgerEntry.SetCurrentKey("Item No.");
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        if not ItemLedgerEntry.IsEmpty() and (not UserSetupNVX."Allow Item Prod.Pst.Grp Change") then
            Error(NoUserRightErr);

        if GenPrdPstGrp.Get(Rec."Gen. Prod. Posting Group") then
            case GenPrdPstGrp."Inventory Value Zero" of
                GenPrdPstGrp."Inventory Value Zero"::"No Item":
                    Error(NoItemErr);
                GenPrdPstGrp."Inventory Value Zero"::Yes:
                    Rec.Validate("Inventory Value Zero", true);
                GenPrdPstGrp."Inventory Value Zero"::No:
                    Rec.Validate("Inventory Value Zero", false);
            end;

        if (GenPrdPstGrp."Inventory Posting Group NVX" <> '') then
            Rec.Validate("Inventory Posting Group", GenPrdPstGrp."Inventory Posting Group NVX");
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Inventory Posting Group', false, false)]
    local procedure CheckforItemLedgerEntries(var Rec: Record Item)
    var
        ItemLedgerEntry: Record "Item Ledger Entry";
        UserSetupNVX: Record UserSetupNVX;
        NoUserRightErr: Label 'There are Ledger Entries for this Item and you are missing the necessary user rights to change the inventory posting group.',
                                comment = 'DEA="Es gibt zum Artikel bereits gebuchte Posten! Sie haben keine Rechte, um nachträglich die zugeordnete Lagerbuchungsgruppe zu ändern."';
    begin
        UserSetupNVX.Get(UserId());
        ItemLedgerEntry.SetCurrentKey("Item No.");
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        if not ItemLedgerEntry.IsEmpty() and (not UserSetupNVX."Allow Item Invt.Pst.Grp Change") then
            Error(NoUserRightErr);
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertItemDimAfterInsert(var Rec: Record Item)
    var
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        InvSetupNVX: Record InvSetupNVX;
    begin
        if Rec.IsTemporary then
            exit;
        GLSetup.Get();
        GLSetup.TestField("Shortcut Dimension 8 Code");

        if not DimensionValue.Get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Init();
            DimensionValue.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DimensionValue.Validate(Code, Rec."No.");
            if Rec.Description <> '' then
                DimensionValue.Validate(Name, Rec.Description);
            DimensionValue.Insert(true);
        end;

        if not DefaultDimension.Get(Database::Item, Rec."No.", GLSetup."Shortcut Dimension 8 Code") then begin
            DefaultDimension.Init();
            DefaultDimension.Validate("Table ID", Database::Item);
            DefaultDimension.Validate("No.", Rec."No.");
            DefaultDimension.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DefaultDimension.Validate("Dimension Value Code", Rec."No.");
            DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
            DefaultDimension.Insert(true);
        end;

        if not InvSetupNVX.Get() then
            InvSetupNVX.Init();

        if not Rec."Inventory Value Zero" then begin
            if InvSetupNVX."Inventory Cost Center" <> '' then begin
                Rec.Validate("Global Dimension 1 Code", InvSetupNVX."Inventory Cost Center");
                DefaultDimension.Get(Database::Item, Rec."No.", GLSetup."Shortcut Dimension 1 Code");
                DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
                DefaultDimension.Modify();
            end;
            if InvSetupNVX."Inventory Section" <> '' then
                if not DefaultDimension.Get(Database::Item, Rec."No.", GLSetup."Shortcut Dimension 3 Code") then begin
                    DefaultDimension.Init();
                    DefaultDimension.Validate("Table ID", Database::Item);
                    DefaultDimension.Validate("No.", Rec."No.");
                    DefaultDimension.Validate("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                    DefaultDimension.Validate("Dimension Value Code", InvSetupNVX."Inventory Section");
                    DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
                    DefaultDimension.Insert(true);
                end;
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterRenameEvent', '', false, false)]
    local procedure InsertItemDimAfterRename(Rec: Record Item; xRec: Record Item)
    var
        DefaultDimension: Record "Default Dimension";
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        if Rec."No." = xRec."No." then
            exit;

        GLSetup.Get();
        GLSetup.TestField("Shortcut Dimension 8 Code");

        if not DimensionValue.Get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Init();
            DimensionValue.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DimensionValue.Validate(Code, Rec."No.");
            if Rec.Description <> '' then
                DimensionValue.Name := CopyStr(Rec.Description, 1, 50);
            DimensionValue.Insert(true);
        end;

        if not DefaultDimension.Get(Database::Item, Rec."No.", GLSetup."Shortcut Dimension 8 Code") then begin
            DefaultDimension.Init();
            DefaultDimension.Validate("Table ID", Database::Item);
            DefaultDimension.Validate("No.", Rec."No.");
            DefaultDimension.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DefaultDimension.Validate("Dimension Value Code", Rec."No.");
            DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
            DefaultDimension.Insert(true);
        end else begin
            DefaultDimension.Validate("Dimension Value Code", Rec."No.");
            DefaultDimension.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Description', false, false)]
    local procedure FillNameinItemDim(Rec: Record Item)
    var
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();

        if DimensionValue.Get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Name := CopyStr(Rec.Description, 1, 50);
            DimensionValue.Modify(true);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Global Dimension 1 Code', false, false)]
    local procedure CheckItemDim(var Rec: Record Item)

    var
        InvSetupNVX: Record InvSetupNVX;
        InvValueErr: Label 'This item has inventory value. Cost Center and Section are obligatory. Only values set up in the inventory setup are allowed for items with inventory value., ',
                                comment = 'DEA="Der Artikel ist lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte muss der Lager-Einrichtung entsprechen"';
        InvValueZeroErr: Label 'This item has no inventory value. Cost Center and Section are obligatory. Values set up in the inventory setup are not allowed for items without inventory value.',
                                comment = 'DEA="Der Artikel ist nicht lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte ist pflichtig. Darüber hinaus dürfen die Dimensionswerte aus der Lager-Einrichtung für nicht lagerbewertete Artikel nicht zugeordnet werden!"';
    begin
        InvSetupNVX.Get();
        case Rec."Inventory Value Zero" of
            true:
                if Rec."Global Dimension 1 Code" = InvSetupNVX."Inventory Cost Center" then
                    Error(InvValueZeroErr);
            false:
                if Rec."Global Dimension 1 Code" <> InvSetupNVX."Inventory Cost Center" then
                    Error(InvValueErr);
        end; //of case
    end;
}
