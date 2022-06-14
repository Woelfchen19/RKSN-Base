pageextension 50013 "PurchaseQuoteSubfromNVX" extends "Purchase Quote Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Purchase Shortcut Dimension 1NVX"; ShortcutDimCode1)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1'; //= Purchase + Dim Name;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Editable = PageEditable;
                trigger OnValidate();
                var
                    DefaultDim: Record "Default Dimension";
                    Item: Record Item;
                    ItemNVX: Record ItemNVX;
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if ShortcutDimCode1 = '' then begin
                        Rec.Validate("Shortcut Dimension 1 Code", DefaultDim.GetDefaultDimNVX(Type, "No.", 1));
                        Modify();
                        exit;
                    end;
                    if Rec.Type = Rec.Type::Item then begin
                        if not ItemNVX.Get(Rec."No.") then
                            ItemNVX.Init();
                        Item.Get("No.");
                        if (not ItemNVX.Activation) and Item."Inventory Value Zero" then
                            Rec.Validate("Shortcut Dimension 1 Code", ShortcutDimCode1);
                    end else
                        Rec.Validate("Shortcut Dimension 1 Code", ShortcutDimCode1);

                    Modify();
                end;
            }
            field("Purchase Shortcut Dimension 3NVX"; ShortcutDimCode3)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                Editable = PageEditable;
                trigger OnValidate();
                var
                    DefaultDim: Record "Default Dimension";
                    Item: Record Item;
                    ItemNVX: Record ItemNVX;
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if ShortcutDimCode3 = '' then begin
                        ShortcutDimCode3 := DefaultDim.GetDefaultDimNVX(Type, "No.", 3);
                        ValidateShortcutDimCode(3, ShortcutDimCode3);
                        Clear(ShortcutDimCode3);
                        Modify();
                        exit;
                    end;
                    if Rec.Type = Rec.Type::Item then begin
                        if not ItemNVX.Get(Rec."No.") then
                            ItemNVX.Init();
                        Item.Get("No.");
                        if (not ItemNVX.Activation) and Item."Inventory Value Zero" then
                            ValidateShortcutDimCode(3, ShortcutDimCode3);
                    end else
                        ValidateShortcutDimCode(3, ShortcutDimCode3);

                    Modify();
                end;
            }
            field("Gen. Bus. Posting Group NVX"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::PurchaseQuote);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                    UpdatePurchaseLineNVX(PurchaseLineNVX."Vend. Unit Price");
                    Modify();
                end;
            }
            field("Gen. P Posting Group NVX"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Bus. Posting Group NVX"; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Prod. Posting Group NVX"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("Allocation CodeNVX"; AllocationCodeVar)
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                Editable = PageEditable;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    Item: Record Item;
                    AppMgt: Codeunit AppMgtNVX;
                    UselessAllocationCodeMsg: Label 'An Allocation Code has no function if used together with an item with inventory value!', comment = 'DEA="Der Artikel ist Lagerbewertet eingerichtet, ein Verteilungscode hat keine Funktion!"';
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Rec.Type = Rec.Type::Item then begin
                        Item.Get(Rec."No.");
                        if not Item."Inventory Value Zero" then begin
                            if AllocationCodeVar <> '' then
                                Message(UselessAllocationCodeMsg);
                            Clear(AllocationCodeVar);
                            if PurchaseLineNVX."Allocation Code" <> '' then begin
                                Clear(PurchaseLineNVX."Allocation Code");
                                PurchaseLineNVX.Modify();
                            end;
                            exit;
                        end;
                    end;

                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            if Rec."Line No." > 0 then begin
                                AppMgt.InsertAllocationDimValue(AllocationCode);
                                AppMgt.ModifyDimensionSetEntry(Rec, AllocationCode.Code);
                                Rec.Modify();
                            end;
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;
                end;
            }
        }
        addafter("Direct Unit Cost")
        {
            field(PurchaseLineNVXCustUnitPriceNVX; VendUnitPrice)
            {
                ApplicationArea = All;
                Caption = 'Vend. Unit Price', comment = 'DEA="Kred. VK-Preis"';
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();
                    UpdatePurchaseLineNVX(VendUnitPrice);
                end;
            }
            field(PurchaseLineNVXCustAmountNVX; PurchaseLineNVX."Vend. Amount")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Vend. Amount', comment = 'DEA="Kred. Betrag"';
            }
        }
        modify("No.")
        {
            trigger OnAfterValidate();
            begin
                if Rec.Quantity = 0 then
                    Rec.Validate(Quantity, 1);
            end;
        }
        modify("VAT Prod. Posting Group")
        {
            Enabled = false;
            Visible = false;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate();
            begin
                if Rec."Line No." > 0 then
                    SetComplementaryFields();
            end;
        }
        modify(ShortcutDimCode3)
        {
            Enabled = false;
        }
    }

    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
        PurchaseLineNVX: Record PurchaseLineNVX;
        PageEditable: Boolean;
        AllocationCodeVar: Code[10];
        ShortcutDimCode1: Code[20];
        ShortcutDimCode3: Code[20];
        VendUnitPrice: Decimal;

    trigger OnAfterGetRecord()
    begin
        PurchaseLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        PurchaseHeaderNVX.GetDefinition(Rec."Document Type", Rec."Document No.");
        SetGlobalVariables();
        PageEditable := CurrPage.Editable();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        PurchaseLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        SetComplementaryFields();
        exit(true)
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := PurchaseLineNVX."Allocation Code";
        ShortcutDimCode1 := PurchaseLineNVX."Shortcut Dimension 1 Code";
        ShortcutDimCode3 := PurchaseLineNVX."Shortcut Dimension 3 Code";
        VendUnitPrice := PurchaseLineNVX."Vend. Unit Price";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(PurchaseLineNVX);
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        Clear(VendUnitPrice);
    end;

    local procedure SetComplementaryFields()
    begin
        PurchaseLineNVX."Allocation Code" := AllocationCodeVar;
        PurchaseLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
        PurchaseLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
        PurchaseLineNVX."Vend. Unit Price" := VendUnitPrice;
        PurchaseLineNVX."Vend. Amount" := Round(Rec.Quantity * VendUnitPrice, 0.01);
        PurchaseLineNVX.Modify();
    end;
}