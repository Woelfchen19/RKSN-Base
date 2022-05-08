pageextension 50027 SalesQuoteSubformNVX extends "Sales Quote Subform"
{
    layout
    {
        addlast(Control1)
        {
            field(SalesShortcutDimension1CodeNVX; ShortcutDimCode1)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1338,1'; //= Sales + Dim Name;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                trigger OnValidate();
                var
                    Item: Record Item;
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if Item.Get(Rec."No.") and Item."Inventory Value Zero" then
                        Rec.Validate("Shortcut Dimension 1 Code", ShortcutDimCode1);

                    Rec.SetBusinessFieldNVX();
                end;
            }
            field(SalesShortcutDimension3CodeNVX; ShortcutDimCode3)
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
            field(GenBusPostingGroupNVX; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesQuote);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                    UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
                end;
            }
            field(GenProdPostingGroupNVX; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(VATBusPostingGroupNVX; "VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(VATProdPostingGroupNVX; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field(AllocationCodeNVX; AllocationCodeVar)
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    AppMgt: Codeunit AppMgtNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or Salesline!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Angebotszeilen! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 1 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 1 Code", AllocationCode."Shortcut Dimension 1 Code");
                            if Rec."Line No." > 0 then begin
                                AppMgt.InsertDimValue(AllocationCode);
                                AppMgt.ModifyDimensionSetEntry(Rec, AllocationCode.Code);
                                Rec.Modify();
                            end;
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            if Rec."Shortcut Dimension 1 Code" <> AllocationCode."Shortcut Dimension 1 Code" then
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
                Caption = 'Cust. Amount', comment = 'DEA="Deb. Betrag"';
                Editable = false;
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

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := SalesLineNVX."Allocation Code";
        ShortcutDimCode1 := SalesLineNVX."Shortcut Dimension 1 Code";
        ShortcutDimCode3 := SalesLineNVX."Shortcut Dimension 3 Code";
        CustUnitPrice := SalesLineNVX."Cust. Unit Price";
    end;
}