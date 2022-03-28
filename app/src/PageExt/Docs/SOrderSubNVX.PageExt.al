pageextension 50025 "SOrderSubNVX" extends "Sales Order Subform"
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
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                trigger OnValidate();
                var
                    Item: Record Item;
                begin
                    if IsCompositionNVX() then
                        SalesLineNVX.TestField("Allocation Code", '');
                    if Rec."Line No." > 0 then
                        if not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            SalesLineNVX.Init();
                            SalesLineNVX."Document Type" := Rec."Document Type";
                            SalesLineNVX."Document No." := Rec."Document No.";
                            SalesLineNVX."Line No." := Rec."Line No.";
                            SalesLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
                            SalesLineNVX.Insert();
                        end else begin
                            SalesLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
                            SalesLineNVX.Modify();
                        end;
                    if Item.Get(Rec."No.") and Item."Inventory Value Zero" then
                        Rec.Validate("Shortcut Dimension 1 Code", ShortcutDimCode1);

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
                        if not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            SalesLineNVX.Init();
                            SalesLineNVX."Document Type" := Rec."Document Type";
                            SalesLineNVX."Document No." := Rec."Document No.";
                            SalesLineNVX."Line No." := Rec."Line No.";
                            SalesLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
                            SalesLineNVX.Insert();
                        end else begin
                            SalesLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
                            SalesLineNVX.Modify();
                        end;
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
                    RKSMgt: Codeunit RKSMgtNVX;
                    FilterOptionNVX: Enum FilterOptionNVX;
                    NewGBPG: Code[20];
                begin
                    if IsCompositionNVX() then
                        exit;

                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesOrder);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);

                    UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
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
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    Item: Record Item;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Item.get(Rec."No.") and not Item."Inventory Value Zero" then
                        if (AllocationCodeVar <> '') then
                            SalesLineNVX.TestField("Shortcut Dimension 3 Code", '');

                    if Rec."Line No." > 0 then
                        if not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            SalesLineNVX.Init();
                            SalesLineNVX."Document Type" := Rec."Document Type";
                            SalesLineNVX."Document No." := Rec."Document No.";
                            SalesLineNVX."Line No." := Rec."Line No.";
                            SalesLineNVX."Allocation Code" := AllocationCodeVar;
                            SalesLineNVX.Insert();
                        end else begin
                            SalesLineNVX."Allocation Code" := AllocationCodeVar;
                            SalesLineNVX.Modify();
                        end;


                    if AllocationCodeVar <> '' then begin
                        if Rec."Shortcut Dimension 2 Code" = '' then
                            AllocationCode.Get(AllocationCodeVar);
                        Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                        if Rec."Line No." > 0 then
                            Rec.Modify();
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
                        if not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            SalesLineNVX.Init();
                            SalesLineNVX."Document Type" := Rec."Document Type";
                            SalesLineNVX."Document No." := Rec."Document No.";
                            SalesLineNVX."Line No." := Rec."Line No.";
                            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
                            SalesLineNVX.Insert();
                        end else begin
                            SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
                            SalesLineNVX.Modify();
                        end;
                end;
            }

            field("Allocation Amount SalesNVX"; SalesLineNVX."Allocation Amount")
            {
                Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
                ApplicationArea = All;
                Editable = false;
            }
            field("Allocation Amount Incl. VAT SalesNVX"; SalesLineNVX."Allocation Amount Incl. VAT")
            {
                Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(Control51)
        {
            field("Allocation Amount HeaderNVX"; SalesHeaderNVX."Allocation Amount")
            {
                Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT SumNVX"; SalesHeaderNVX."Allocation Amount Incl. VAT" - SalesHeaderNVX."Allocation Amount")
            {
                Caption = 'VAT Sum', comment = 'DEA="Summe USt."';
                ApplicationArea = All;
                Editable = false;
            }
            field("Allocation Amount Incl. VAT HeaderNVX"; SalesHeaderNVX."Allocation Amount Incl. VAT")
            {
                Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Unit Price")
        {
            field(SalesLineNVXCustUnitPriceNVX; SalesLineNVX."Cust. Unit Price")
            {
                ApplicationArea = All;
                Caption = 'Cust. Unit Price', comment = 'DEA="Deb. VK-Preis"';

                trigger OnValidate();
                var
                begin
                    SalesLineNVX."Cust. Amount" := round(Rec.Quantity * SalesLineNVX."Cust. Unit Price", 0.01);
                    SalesLineNVX.Modify();
                    UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
                    Modify();
                end;
            }
            field(SalesLineNVXCustAmountNVX; SalesLineNVX."Cust. Amount")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Cust. Amount', comment = 'DEA="Deb. Betrag"';
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
                SalesLineNVX."Cust. Amount" := round(Rec.Quantity * SalesLineNVX."Cust. Unit Price", 0.01);
                SalesLineNVX.Modify();
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
        }
        modify("ShortcutDimCode3")
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
        AllocationCodeVar: Code[10];
        CompGenBusPstGrpWES: Code[20];
        ShortcutDimCode1: Code[20];
        ShortcutDimCode3: Code[20];

    trigger OnAfterGetRecord()
    begin
        if not IsCompositionNVX() then
            CompFieldsEditable := false
        else
            CompFieldsEditable := true;
        if not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX.Insert();
            Clear(AllocationCodeVar);
            Clear(ShortcutDimCode1);
            Clear(ShortcutDimCode3);
            Clear(CompGenBusPstGrpWES);
        end else begin
            AllocationCodeVar := SalesLineNVX."Allocation Code";
            ShortcutDimCode1 := SalesLineNVX."Shortcut Dimension 1 Code";
            ShortcutDimCode3 := SalesLineNVX."Shortcut Dimension 3 Code";
            CompGenBusPstGrpWES := SalesLineNVX."Comp Gen. Bus. Pst Grp WES";
        end;
        SalesLineNVX.CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");

        if SalesHeaderNVX."No." <> Rec."Document No." then begin
            if not SalesHeaderNVX.Get(Rec."Document Type", Rec."Document No.") then begin
                SalesHeaderNVX.Init();
                SalesHeaderNVX."Document Type" := "Document Type";
                SalesHeaderNVX."No." := "Document No.";
                SalesHeaderNVX.Insert();
            end;
            SalesHeaderNVX.CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
        end;
        if IsCompositionNVX() then
            GBPGEditable := false
        else
            GBPGEditable := true;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        SalesLineNVX.Init();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if (AllocationCodeVar <> '') or (ShortcutDimCode1 <> '') or (ShortcutDimCode3 <> '') then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX."Allocation Code" := AllocationCodeVar;
            SalesLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
            SalesLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
            SalesLineNVX.Insert();
        end;
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        if SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then
            SalesLineNVX.Delete(true);
        SalesLineNVX.Init();
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        exit(true);
    end;

    local procedure IsCompositionNVX(): Boolean
    begin
        InvSetupNVX.Get();
        if InvSetupNVX."Composition Customer" = Rec."Sell-to Customer No." then
            exit(true)
        else
            exit(false);
    end;
}