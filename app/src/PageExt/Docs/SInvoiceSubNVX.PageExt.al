pageextension 50023 SInvoiceSubNVX extends "Sales Invoice Subform"
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
                Editable = PageEditable;
                trigger OnValidate();
                var
                    Item: Record Item;
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

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
                Editable = PageEditable;
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
                Editable = PageEditable;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesInvoice);
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
                TableRelation = AllocationCodeNVX.Code;
                Editable = PageEditable;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

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
        }
        addafter("Unit Price")
        {
            field(SalesLineNVXCustUnitPriceNVX; CustUnitPrice)
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
                Editable = false;
                Caption = 'Cust. Amount', comment = 'DEA="Deb. Betrag"';
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
        modify("Shortcut Dimension 1 Code")
        {
            Enabled = false;
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
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLineNVX: Record SalesLineNVX;
        PageEditable: Boolean;
        AllocationCodeVar: Code[10];
        ShortcutDimCode1: Code[20];
        ShortcutDimCode3: Code[20];
        CustUnitPrice: Decimal;

    trigger OnAfterGetRecord()
    begin
        SalesLineNVX.GetDefinition(Rec."Document Type", Rec."Document No.", Rec."Line No.");
        SalesHeaderNVX.GetDefinition(Rec."Document Type", Rec."Document No.");
        SetGlobalVariables();
        PageEditable := CurrPage.Editable();
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

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := SalesLineNVX."Allocation Code";
        ShortcutDimCode1 := SalesLineNVX."Shortcut Dimension 1 Code";
        ShortcutDimCode3 := SalesLineNVX."Shortcut Dimension 3 Code";
        CustUnitPrice := SalesLineNVX."Cust. Unit Price";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(SalesLineNVX);
        Clear(AllocationCodeVar);
        Clear(ShortcutDimCode1);
        Clear(ShortcutDimCode3);
        Clear(CustUnitPrice);
    end;

    local procedure SetComplementaryFields()
    begin
        SalesLineNVX."Allocation Code" := AllocationCodeVar;
        SalesLineNVX."Shortcut Dimension 1 Code" := ShortcutDimCode1;
        SalesLineNVX."Shortcut Dimension 3 Code" := ShortcutDimCode3;
        SalesLineNVX."Cust. Unit Price" := CustUnitPrice;
        SalesLineNVX."Cust. Amount" := Round(Rec.Quantity * CustUnitPrice, 0.01);
        SalesLineNVX.Modify();
    end;
}