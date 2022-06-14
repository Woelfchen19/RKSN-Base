pageextension 50025 "SalesOrderSubformNVX" extends "Sales Order Subform"
{
    layout
    {
        addlast(Control1)
        {
            field("Sales Shortcut Dimension 1 CodeNVX"; ShortcutDimCode1)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1338,1'; //= Sales + Dim Name;
                Editable = false;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Visible = false;

                trigger OnValidate();
                var
                    Item: Record Item;
                begin
                    if IsCompositionNVX() then
                        SalesLineNVX.TestField("Allocation Code", '');

                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if Item.Get(Rec."No.") and Item."Inventory Value Zero" then
                        Rec.Validate("Shortcut Dimension 1 Code", ShortcutDimCode1);

                    Rec.SetBusinessFieldNVX();
                end;
            }
            field("Sales Shortcut Dimension 3 CodeNVX"; ShortcutDimCode3)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1338,3'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));

                trigger OnValidate();
                var
                    Item: Record Item;
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if Item.Get(Rec."No.") and Item."Inventory Value Zero" then
                        ValidateShortcutDimCode(3, ShortcutDimCode3);
                end;
            }
            field("Gen. Bus. Posting Group NVX"; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = GBPGEditable;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    if IsCompositionNVX() then
                        exit;

                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesOrder);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);

                    UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
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
                Editable = PageEditable;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    Item: Record Item;
                    AppMgt: Codeunit AppMgtNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or Salesline!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in der Verkaufszeile! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Item.Get(Rec."No.") and not Item."Inventory Value Zero" then
                        if (AllocationCodeVar <> '') then
                            SalesLineNVX.TestField("Shortcut Dimension 3 Code", '');

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
            field("Comp Gen. Bus. Pst Grp WESNVX"; CompGenBusPstGrpWES)
            {
                ApplicationArea = All;
                Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                Editable = CompFieldsEditable;
                TableRelation = "Gen. Business Posting Group".Code;
                trigger OnValidate()
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();
                end;
            }
        }
        addafter("Unit Price")
        {
            field(SalesLineNVXCustUnitPriceNVX; SalesLineNVX."Cust. Unit Price")
            {
                ApplicationArea = All;
                Caption = 'Cust. Unit Price', comment = 'DEA="Deb. VK-Preis"';
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();
                    UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
                end;
            }
            field(SalesLineNVXCustAmountNVX; SalesLineNVX."Cust. Amount")
            {
                ApplicationArea = All;
                Caption = 'Cust. Amount', comment = 'DEA="Deb. Betrag"';
                Editable = false;
            }

            field(ShortcutDimCode9NVX; ShortcutDimCodeVisible[9])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,9';
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
            }
            field(ShortcutDimCode10NVX; ShortcutDimCodeVisible[10])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,10';
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
            }

        }
        modify("VAT Prod. Posting Group")
        {
            Enabled = false;
            Visible = false;
        }
        modify("No.")
        {
            trigger OnAfterValidate();
            begin
                if Rec.Quantity = 0 then
                    Rec.Validate(Quantity, 1);
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate();
            begin
                if Rec."Line No." > 0 then
                    SetComplementaryFields();
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
        }
        modify(ShortcutDimCode3)
        {
            Enabled = false;
        }
    }

    var
        InvSetupNVX: Record InvSetupNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        CompFieldsEditable: Boolean;
        GBPGEditable: Boolean;
        PageEditable: Boolean;
        ShortcutDimCodeVisible: array[10] of Boolean;
        AllocationCodeVar: Code[10];
        CompGenBusPstGrpWES: Code[20];
        ShortcutDimCode1: Code[20];
        ShortcutDimCode3: Code[20];
        CustUnitPrice: Decimal;

    trigger OnAfterGetRecord()
    begin
        SalesLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        SalesHeaderNVX.GetDefinition(Rec."Document Type", Rec."Document No.");
        SetGlobalVariables();

        if IsCompositionNVX() then begin
            GBPGEditable := false;
            CompFieldsEditable := true;
        end else begin
            GBPGEditable := true;
            CompFieldsEditable := false
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
        PageEditable := CurrPage.Editable();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        SalesLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        SetComplementaryFields();
        exit(true)
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(SalesLineNVX);
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        Clear(CustUnitPrice);
        Clear(CompGenBusPstGrpWES)
    end;

    local procedure IsCompositionNVX(): Boolean
    begin
        InvSetupNVX.Get();
        if InvSetupNVX."Composition Customer" = Rec."Sell-to Customer No." then
            exit(true)
        else
            exit(false);
    end;

    local procedure SetComplementaryFields()
    begin
        SalesLineNVX."Allocation Code" := AllocationCodeVar;
        SalesLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
        SalesLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
        SalesLineNVX."Cust. Unit Price" := CustUnitPrice;
        SalesLineNVX."Cust. Amount" := Round(Rec.Quantity * CustUnitPrice, 0.01);
        SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
        if SalesLineNVX.Modify() then;
    end;

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := SalesLineNVX."Allocation Code";
        ShortcutDimCode1 := SalesLineNVX."Shortcut Dimension 1 Code";
        ShortcutDimCode3 := SalesLineNVX."Shortcut Dimension 3 Code";
        CustUnitPrice := SalesLineNVX."Cust. Unit Price";
        CompGenBusPstGrpWES := SalesLineNVX."Comp Gen. Bus. Pst Grp WES";
    end;
}