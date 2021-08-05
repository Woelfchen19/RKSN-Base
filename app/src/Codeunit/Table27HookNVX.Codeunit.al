codeunit 50000 "Table27HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Gen. Prod. Posting Group', false, false)]
    //RKSN-36
    local procedure SetInventoryValueZero(Var Rec: Record Item)
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
        UserSetupNVX: Record UserSetupNVX;
        ItemLedgerEntry: Record "Item Ledger Entry";
        NoItemErr: Label 'This Product Posting Group is blocked for use on Items!', comment = 'DEA="Es ist nicht möglich, diese Produktbuchungsgruppe zuzuordnen, da diese nicht zum Datawarehouse gehört!"';
        NoUserRightErr: Label 'There are Ledger Entries for this Item and you are missing the necessary user rights to change the product posting group.',
                                comment = 'DEA="Es gibt zum Artikel bereits gebuchte Posten! Sie haben keine Rechte, um nachträglich die zugeordnete Produktbuchungsgruppe zu ändern."';
    begin

        If GenPrdPstGrp.Get(Rec."Gen. Prod. Posting Group") then
            case GenPrdPstGrp."Inventory Value Zero" of
                GenPrdPstGrp."Inventory Value Zero"::"No Item":
                    error(NoItemErr);
                GenPrdPstGrp."Inventory Value Zero"::Yes:
                    Rec.Validate("Inventory Value Zero", true);
                GenPrdPstGrp."Inventory Value Zero"::"No":
                    Rec.Validate("Inventory Value Zero", false);
            end;

        UserSetupNVX.Get(UserId());
        ItemLedgerEntry.SetCurrentKey("Item No.");
        ItemLedgerEntry.SetRange("Item No.", Rec."No.");
        IF not ItemLedgerEntry.IsEmpty() and (not UserSetupNVX."Allow Item Prod.Pst.Grp Change") then
            Error(NoUserRightErr);
    end;


    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterInsertEvent', '', false, false)]
    //RKSN-39
    local procedure InsertItemDimAfterInsert(var Rec: Record Item)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
        InvSetupNVX: Record InvSetupNVX;
    begin
        If Rec.IsTemporary then
            exit;
        GLSetup.Get();
        GLSetup.TestField("Shortcut Dimension 8 Code");

        IF not DimensionValue.get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Init();
            DimensionValue.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DimensionValue.Validate(Code, Rec."No.");
            If Rec.Description <> '' then
                DimensionValue.Validate(Name, Rec.Description);
            DimensionValue.Insert(true);
        END;

        If not DefaultDimension.Get(Database::item, Rec."No.", GLSetup."Shortcut Dimension 8 Code") then begin
            DefaultDimension.Init();
            DefaultDimension.Validate("Table ID", Database::Item);
            DefaultDimension.Validate("No.", Rec."No.");
            DefaultDimension.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DefaultDimension.Validate("Dimension Value Code", Rec."No.");
            DefaultDimension.Validate("Value Posting", DefaultDimension."Value Posting"::"Same Code");
            DefaultDimension.Insert(true);
        end;

        IF not InvSetupNVX.Get() then
            InvSetupNVX.Init();

        IF not Rec."Inventory Value Zero" then begin
            IF InvSetupNVX."Inventory Cost Center" <> '' then
                Rec.Validate("Global Dimension 1 Code", InvSetupNVX."Inventory Cost Center");
            IF InvSetupNVX."Inventory Section" <> '' then begin
                If not DefaultDimension.Get(Database::item, Rec."No.", GLSetup."Shortcut Dimension 3 Code") then begin
                    DefaultDimension.Init();
                    DefaultDimension.Validate("Table ID", Database::Item);
                    DefaultDimension.Validate("No.", Rec."No.");
                    DefaultDimension.Validate("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                    DefaultDimension.Validate("Dimension Value Code", InvSetupNVX."Inventory Section");
                    // DefaultDimension.Validate("Value Posting",DefaultDimension."Value Posting"::"Same Code");
                    DefaultDimension.Insert(true);
                end;
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterRenameEvent', '', false, false)]
    //RKSN-39
    local procedure InsertItemDimAfterRename(Rec: Record Item; xRec: Record Item)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        DefaultDimension: Record "Default Dimension";
    begin
        If Rec."No." = xRec."No." then
            exit;

        GLSetup.Get();
        GLSetup.TestField("Shortcut Dimension 8 Code");

        IF not DimensionValue.get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Init();
            DimensionValue.Validate("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            DimensionValue.Validate(Code, Rec."No.");
            If Rec.Description <> '' then
                DimensionValue.Name := Copystr(Rec.Description, 1, 50);
            DimensionValue.Insert(true);
        END;

        If not DefaultDimension.Get(Database::item, Rec."No.", GLSetup."Shortcut Dimension 8 Code") then begin
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
    //RKSN-39
    local procedure FillNameinItemDim(Rec: Record Item)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        GLSetup.Get();

        IF DimensionValue.get(GLSetup."Shortcut Dimension 8 Code", Rec."No.") then begin
            DimensionValue.Name := Copystr(Rec.Description, 1, 50);
            DimensionValue.Modify(true);
        end;
    end;
    [EventSubscriber(ObjectType::Table, Database::Item, 'OnAfterValidateEvent', 'Gen. Prod. Posting Group', false, false)]
    //RKSN-39
    local procedure SuggestInventoryPostingGroup(var Rec: Record Item)
    var
        GenPrdPstGrpNVX: record GenPrdPstGrpNVX; 
    begin
        if (GenPrdPstGrpNVX.get(rec."Gen. Prod. Posting Group")) and
           (GenPrdPstGrpNVX."Inventory Posting Group NVX" <> '') then
            rec.Validate("Inventory Posting Group",GenPrdPstGrpNVX."Inventory Posting Group NVX");                      
    end;
}
