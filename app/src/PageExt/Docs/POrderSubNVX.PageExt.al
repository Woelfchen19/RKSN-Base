pageextension 50011 "POrderSubNVX" extends "Purchase Order Subform"
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
                trigger OnValidate();
                var
                    DefaultDim: Record "Default Dimension";
                    Item: Record Item;
                    ItemNVX: Record ItemNVX;
                begin
                    if Rec."Line No." > 0 then
                        if not PurchaseLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            PurchaseLineNVX.Init();
                            PurchaseLineNVX."Document Type" := Rec."Document Type";
                            PurchaseLineNVX."Document No." := Rec."Document No.";
                            PurchaseLineNVX."Line No." := Rec."Line No.";
                            PurchaseLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
                            PurchaseLineNVX.Insert();
                        end else begin
                            PurchaseLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
                            PurchaseLineNVX.Modify();
                        end;

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
                trigger OnValidate();
                var
                    DefaultDim: Record "Default Dimension";
                    Item: Record Item;
                    ItemNVX: Record ItemNVX;
                begin
                    if Rec."Line No." > 0 then
                        if not PurchaseLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            PurchaseLineNVX.Init();
                            PurchaseLineNVX."Document Type" := Rec."Document Type";
                            PurchaseLineNVX."Document No." := Rec."Document No.";
                            PurchaseLineNVX."Line No." := Rec."Line No.";
                            PurchaseLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
                            PurchaseLineNVX.Insert();
                        end else begin
                            PurchaseLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
                            PurchaseLineNVX.Modify();
                        end;

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
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit RKSMgtNVX;
                    FilterOptionNVX: Enum FilterOptionNVX;
                    NewGBPG: Code[20];
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::PurchaseOrder);
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
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    Item: Record Item;
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
                        if not PurchaseLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            PurchaseLineNVX.Init();
                            PurchaseLineNVX."Document Type" := Rec."Document Type";
                            PurchaseLineNVX."Document No." := Rec."Document No.";
                            PurchaseLineNVX."Line No." := Rec."Line No.";
                            PurchaseLineNVX."Allocation Code" := AllocationCodeVar;
                            PurchaseLineNVX.Insert();
                        end else begin
                            PurchaseLineNVX."Allocation Code" := AllocationCodeVar;
                            PurchaseLineNVX.Modify();
                        end;


                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 2 Code" = '' then begin
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
            field("Allocation AmountNVX"; PurchaseLineNVX."Allocation Amount")
            {
                Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
                ApplicationArea = All;
                Editable = false;
            }
            field("Allocation Amount Incl. VATNVX"; PurchaseLineNVX."Allocation Amount Incl. VAT")
            {
                Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(Control43)
        {
            field("Allocation Amount HeaderNVX"; PurchaseHeaderNVX."Allocation Amount")
            {
                Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT SumNVX"; PurchaseHeaderNVX."Allocation Amount Incl. VAT" - PurchaseHeaderNVX."Allocation Amount")
            {
                Caption = 'VAT Sum', comment = 'DEA="Summe USt."';
                ApplicationArea = All;
                Editable = false;
            }
            field("Allocation Amount Incl. VAT HeaderNVX"; PurchaseHeaderNVX."Allocation Amount Incl. VAT")
            {
                Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
                ApplicationArea = All;
                Editable = false;
            }
        }
        addafter("Direct Unit Cost")
        {
            field(PurchaseLineNVXCustUnitPriceNVX; PurchaseLineNVX."Vend. Unit Price")
            {
                ApplicationArea = All;
                Caption = 'Vend. Unit Price', comment = 'DEA="Kred. VK-Preis"';

                trigger OnValidate();
                var
                begin
                    PurchaseLineNVX."Vend. Amount" := round(Rec.Quantity * PurchaseLineNVX."Vend. Unit Price", 0.01);
                    PurchaseLineNVX.Modify();
                    UpdatePurchaseLineNVX(PurchaseLineNVX."Vend. Unit Price");
                    Modify();
                end;
            }
            field(PurchaseLineNVXCustAmountNVX; PurchaseLineNVX."Vend. Amount")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Vend. Amount', comment = 'DEA="Kred. Betrag"';
            }
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
                PurchaseLineNVX."Vend. Amount" := round(Rec.Quantity * PurchaseLineNVX."Vend. Unit Price", 0.01);
                PurchaseLineNVX.Modify();
            end;
        }
        modify("Unit of Measure Code")
        {
            trigger OnAfterValidate();
            begin
            end;
        }
        modify("Unit of Measure")
        {
            trigger OnAfterValidate();
            begin
            end;
        }
        modify("Qty. to Receive")
        {
            trigger OnAfterValidate();
            begin
            end;
        }
        modify("Qty. to Invoice")
        {
            trigger OnAfterValidate();
            begin
            end;
        }
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
        }
        modify("Shortcut Dimension 2 Code")
        {
            trigger OnAfterValidate();
            begin
            end;
        }
        modify("ShortcutDimCode3")
        {
            Enabled = false;
        }
    }

    var
        PurchaseHeaderNVX: Record PurchaseHeaderNVX;
        PurchaseLineNVX: Record PurchaseLineNVX;
        AllocationCodeVar: Code[10];
        ShortcutDimCode1: Code[20];
        ShortcutDimCode3: Code[20];

    trigger OnAfterGetRecord()
    begin
        if not PurchaseLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
            PurchaseLineNVX.Init();
            PurchaseLineNVX."Document Type" := Rec."Document Type";
            PurchaseLineNVX."Document No." := Rec."Document No.";
            PurchaseLineNVX."Line No." := Rec."Line No.";
            PurchaseLineNVX.Insert();
            Clear(AllocationCodeVar);
        end else begin
            AllocationCodeVar := PurchaseLineNVX."Allocation Code";
            ShortcutDimCode1 := PurchaseLineNVX."Shortcut Dimension 1 Code";
            ShortcutDimCode3 := PurchaseLineNVX."Shortcut Dimension 3 Code";
        end;
        PurchaseLineNVX.CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");

        if PurchaseHeaderNVX."No." <> Rec."Document No." then begin
            if not PurchaseHeaderNVX.Get(Rec."Document Type", Rec."Document No.") then begin
                PurchaseHeaderNVX.Init();
                PurchaseHeaderNVX."Document Type" := "Document Type";
                PurchaseHeaderNVX."No." := "Document No.";
                PurchaseHeaderNVX.Insert();
            end;
            PurchaseHeaderNVX.CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        PurchaseLineNVX.Init();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if (AllocationCodeVar <> '') or (ShortcutDimCode1 <> '') or (ShortcutDimCode3 <> '') then begin
            PurchaseLineNVX.Init();
            PurchaseLineNVX."Document Type" := Rec."Document Type";
            PurchaseLineNVX."Document No." := Rec."Document No.";
            PurchaseLineNVX."Line No." := Rec."Line No.";
            PurchaseLineNVX."Allocation Code" := AllocationCodeVar;
            PurchaseLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
            PurchaseLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
            PurchaseLineNVX.Insert();
        end;
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean;
    begin
        if PurchaseLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then
            PurchaseLineNVX.Delete(true);
        PurchaseLineNVX.Init();
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        exit(true);
    end;
}