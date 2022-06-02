pageextension 50024 "SalesOrderNVX" extends "Sales Order"
{
    layout
    {
        addafter("Sell-to Customer Name")
        {
            field(GenBsnPstGrpNVX; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    RKSMgt: Codeunit AllocationMgtNVX;
                    NewGBPG: Code[20];
                    FilterOptionNVX: Enum FilterOptionNVX;
                begin
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesOrder);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                end;
            }
            field(ShortCutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';

                trigger OnLookup(var Text: Text): Boolean
                var
                    AppMgt: Codeunit AppMgtNVX;
                begin
                    AppMgt.OnLookupShortcutDimension5Code(Rec);
                end;

                trigger OnValidate()
                var
                    AppMgt: Codeunit AppMgtNVX;
                begin
                    AppMgt.OnValidateShortcutDimension(Rec);
                end;
            }
        }
        addlast("Invoice Details")
        {
            field("Comp Shortcut Dimension 3NVX"; CompShortcutDimension3)
            {
                ApplicationArea = All;
                Caption = 'Composition Section', comment = 'DEA="Abfassung Sparte"';
                Editable = CompFieldsEditable;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                trigger OnValidate()
                begin
                    if Rec."No." <> '' then
                        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
                            SalesHeaderNVX.Init();
                            SalesHeaderNVX."Document Type" := "Document Type";
                            SalesHeaderNVX."No." := "No.";
                            SalesHeaderNVX."Shortcut Dimension 3 Code" := CompShortcutDimension3;
                            SalesHeaderNVX.Insert();
                        end else begin
                            SalesHeaderNVX."Shortcut Dimension 3 Code" := CompShortcutDimension3;
                            SalesHeaderNVX.Modify();
                        end;
                    if IsCompositionNVX() then
                        if Rec.SalesLinesExist() then
                            if Confirm(UpdateLinesQst) then begin
                                GetNVXLinesNVX();
                                SalesLineNVX.FindSet();
                                repeat
                                    SalesLine.Get(SalesLineNVX."Document Type", SalesLineNVX."Document No.", SalesLineNVX."Line No.");
                                    if Item.Get(SalesLine."No.") then begin
                                        if SalesHeaderNVX."Shortcut Dimension 3 Code" <> '' then
                                            SalesLineNVX."Shortcut Dimension 3 Code" := SalesHeaderNVX."Shortcut Dimension 3 Code"
                                        else
                                            if Item."Inventory Value Zero" then
                                                SalesLineNVX."Shortcut Dimension 3 Code" := InvSetupNVX."Comp Sect - Inv Value Zero";
                                        if Item."Inventory Value Zero" then
                                            DimMgt.ValidateShortcutDimValues(3, SalesLineNVX."Shortcut Dimension 3 Code", Rec."Dimension Set ID");
                                        SalesLineNVX.Modify()
                                    end;
                                until SalesLineNVX.Next() = 0;
                            end;
                end;
            }
            field("Comp Allocation CodeNVX"; AllocationCodeVar)
            {
                ApplicationArea = All;
                Caption = 'Composition Allocation', comment = 'DEA="Abfassung Verteilung"';
                Editable = CompFieldsEditable;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate()
                begin
                    if Rec."No." <> '' then
                        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
                            SalesHeaderNVX.Init();
                            SalesHeaderNVX."Document Type" := "Document Type";
                            SalesHeaderNVX."No." := "No.";
                            SalesHeaderNVX."Allocation Code" := AllocationCodeVar;
                            SalesHeaderNVX.Insert();
                        end else begin
                            SalesHeaderNVX."Allocation Code" := AllocationCodeVar;
                            SalesHeaderNVX.Modify();
                        end;
                    if Rec.SalesLinesExist() then
                        if Confirm(UpdateLinesQst) then begin
                            GetLinesNVX();
                            SalesLineNVX.Reset();
                            repeat
                                if Item.Get(SalesLine."No.") and not Item."Inventory Value Zero" then begin
                                    SalesLineNVX.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                    if SalesLineNVX."Shortcut Dimension 1 Code" = '' then begin
                                        SalesLineNVX."Allocation Code" := SalesHeaderNVX."Allocation Code";
                                        SalesLineNVX.Modify();
                                    end;
                                end;
                            until SalesLine.Next() = 0;

                        end;
                end;
            }
            field("Comp Gen. Bus. Pst Grp WES NVX"; CompGenBusPstGrpWES)
            {
                ApplicationArea = All;
                Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                Editable = CompFieldsEditable;
                TableRelation = "Gen. Business Posting Group".Code;
                trigger OnValidate()
                begin
                    if Rec."No." <> '' then
                        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
                            SalesHeaderNVX.Init();
                            SalesHeaderNVX."Document Type" := "Document Type";
                            SalesHeaderNVX."No." := "No.";
                            SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
                            SalesHeaderNVX.Insert();
                        end else begin
                            SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
                            SalesHeaderNVX.Modify();
                        end;
                    if Rec.SalesLinesExist() then
                        if Confirm(UpdateLinesQst) then begin
                            GetLinesNVX();
                            SalesLineNVX.Reset();
                            repeat
                                if Item.Get(SalesLine."No.") and not Item."Inventory Value Zero" then begin
                                    SalesLineNVX.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                    SalesLineNVX."Comp Gen. Bus. Pst Grp WES" := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
                                    SalesLineNVX.Modify();
                                end;
                            until SalesLine.Next() = 0;
                        end;
                end;
            }
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field("Shortcut Dimension 6 CodeNVX"; ShortcutDims[6])
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
                CaptionClass = '1,2,6';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
                trigger OnValidate()
                var
                    DimensionValue: Record "Dimension Value";
                    Item: Record Item;
                    ConfirmUpdateQst: Label 'Do you want to update Sales %1 and %2 in Sales Line with the values defined in %3?', comment = 'DEA="Möchten Sie Verkauf-%1 und %2 mit den Daten aus %3 aktualisieren?"';
                begin
                    DimMgt.ValidateShortcutDimValues(6, ShortcutDims[6], Rec."Dimension Set ID");
                    Rec.Modify();
                    if ShortcutDims[6] = '' then
                        exit;
                    if Item.Get(SalesLine."No.") then;
                    if IsCompositionNVX() or (not Item."Inventory Value Zero") then begin
                        GLSetup.GetRecordOnce();
                        DimensionValue.Get(GLSetup."Shortcut Dimension 6 Code", ShortcutDims[6]);
                        Rec.Modify();
                        SalesLine.Reset();
                        SalesLine.SetRange("Document Type", "Document Type");
                        SalesLine.SetRange("Document No.", "No.");
                        SalesLine.SetRange(Type, SalesLine.Type::Item);
                        if SalesLine.FindSet() then begin
                            if not Confirm(ConfirmUpdateQst, false, GLSetup."Shortcut Dimension 1 Code", GLSetup."Shortcut Dimension 2 Code", GLSetup."Shortcut Dimension 6 Code") then
                                exit;

                            SalesLineNVX.Reset();
                            repeat
                                SalesLine.Validate("Shortcut Dimension 2 Code", DimensionValue.ShortcutDimension2CodeNVX);
                                SalesLineNVX.Get(SalesLine."Document Type", SalesLine."Document No.", SalesLine."Line No.");
                                SalesLineNVX."Shortcut Dimension 1 Code" := DimensionValue.ShortcutDimension1CodeNVX;
                                if Item."Inventory Value Zero" then
                                    SalesLine.Validate("Shortcut Dimension 1 Code", DimensionValue.ShortcutDimension1CodeNVX);
                                SalesLine.Modify();
                                SalesLineNVX.Modify();
                            until SalesLine.Next() = 0;
                        end;
                    end;
                end;
            }

        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate();
            begin
                if not IsCompositionNVX() then
                    CompFieldsEditable := false;
            end;
        }
        modify("Prices Including VAT")
        {
            trigger OnAfterValidate();
            var
                LSalesLine: Record "Sales Line";
            begin
                GetNVXLinesNVX();
                if SalesLineNVX.FindSet() then
                    repeat
                        LSalesLine.Get(SalesLineNVX."Document Type", SalesLineNVX."Document No.", SalesLineNVX."Line No.");
                        LSalesLine.UpdateSalesLineNVX(SalesLineNVX."Cust. Unit Price");
                    until SalesLineNVX.Next() = 0;
            end;
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(PreviewDimDistributionNVX)
            {
                ApplicationArea = All;
                Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
                Image = PreviewChecks;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction();
                var
                    DistrPurchLine: Record DistrPurchLineNVX;
                    PreviewPurchDimDistrPage: Page PreviewPurchDimDistrNVX;
                begin
                    OnPreviewDimDistributionNVX(Rec."Document Type", rec."No.");
                    DistrPurchLine.SetRange("Document Type", Rec."Document Type");
                    DistrPurchLine.SetRange("Document No.", Rec."No.");
                    PreviewPurchDimDistrPage.SetRecord(DistrPurchLine);
                    PreviewPurchDimDistrPage.SetTableView(DistrPurchLine);
                    PreviewPurchDimDistrPage.Run();
                end;
            }
        }
    }

    var
        GLSetup: Record "General Ledger Setup";
        InvSetupNVX: Record InvSetupNVX;
        Item: Record Item;
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLine: Record "Sales Line";
        SalesLineNVX: Record SalesLineNVX;
        DimMgt: Codeunit DimensionManagement;
        CompFieldsEditable: Boolean;
        PageEditable: Boolean;
        AllocationCodeVar: Code[10];
        CompGenBusPstGrpWES: Code[20];
        CompShortcutDimension3: Code[20];
        ShortcutDims: array[10] of Code[20];
        UpdateLinesQst: Label 'Do you want to update the lines?', comment = 'DEA="Möchten Sie die Zelen aktualisieren?"';

    trigger OnAfterGetRecord();
    begin
        if not IsCompositionNVX() then
            CompFieldsEditable := false
        else
            CompFieldsEditable := true;
        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := "Document Type";
            SalesHeaderNVX."No." := "No.";
            SalesHeaderNVX.Insert();

            CompShortcutDimension3 := '';
            AllocationCodeVar := '';
            CompGenBusPstGrpWES := '';
        end else begin
            CompShortcutDimension3 := SalesHeaderNVX."Shortcut Dimension 3 Code";
            AllocationCodeVar := SalesHeaderNVX."Allocation Code";
            CompGenBusPstGrpWES := SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES";
        end;
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
        PageEditable := CurrPage.Editable;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        CompShortcutDimension3 := '';
        AllocationCodeVar := '';
        CompGenBusPstGrpWES := '';

        SalesHeaderNVX.Init();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if (AllocationCodeVar <> '') or (CompShortcutDimension3 <> '') or (CompGenBusPstGrpWES <> '') then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := Rec."Document Type";
            SalesHeaderNVX."No." := Rec."No.";
            SalesHeaderNVX."Allocation Code" := AllocationCodeVar;
            SalesHeaderNVX."Comp Gen. Bus. Pst Grp WES" := CompGenBusPstGrpWES;
            SalesHeaderNVX."Shortcut Dimension 3 Code" := CompShortcutDimension3;
            SalesHeaderNVX.Insert();
        end;

        exit(true);
    end;

    local procedure GetLinesNVX()
    begin
        if (SalesLine.GetFilter("Document No.") <> Rec."No.") then begin
            SalesLine.Reset();
            SalesLine.SetRange("Document Type", Rec."Document Type");
            SalesLine.SetRange("Document No.", Rec."No.");
        end;
    end;

    local procedure GetNVXLinesNVX()
    begin
        if (SalesLineNVX.GetFilter("Document No.") <> Rec."No.") then begin
            SalesLineNVX.Reset();
            SalesLineNVX.SetRange("Document Type", Rec."Document Type");
            SalesLineNVX.SetRange("Document No.", Rec."No.");
        end;
    end;

    local procedure IsCompositionNVX(): Boolean
    begin
        InvSetupNVX.Get();
        if InvSetupNVX."Composition Customer" = Rec."Sell-to Customer No." then
            exit(true)
        else
            exit(false);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(DocumentType: Enum RKSSalesDocumentTypeNVX; DocumentNo: Code[20])
    begin
    end;
}