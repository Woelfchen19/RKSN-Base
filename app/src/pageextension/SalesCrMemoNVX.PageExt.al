pageextension 50020 "SalesCrMemoNVX" extends "Sales Credit Memo"
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
                    NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::SalesCrMemo);
                    if (NewGBPG <> '') then
                        Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
                end;
            }
            field(ShortCutDimension5CodeNVX; ShortcutDims[5])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';

                trigger OnLookup(var Text: Text): Boolean
                var
                    DimensionValue: Record "Dimension Value";
                    UserSetup: Record "User Setup";
                    AppMgt: Codeunit AppMgtNVX;
                    DimensionValueList: Page "Dimension Value List";
                    NewParentDimSetID: Integer;
                    OldParentDimSetID: Integer;
                begin
                    AppMgt.GetUserSetup(UserSetup, true);
                    AppMgt.AllowdBusinessFieldsForUser();
                    DimensionValue.FilterGroup(2);
                    DimensionValue.SetRange("Global Dimension No.", 5);
                    DimensionValue.SetFilter(Code, UserSetup.BusinessFieldFilterNVX);
                    DimensionValue.FilterGroup(0);
                    DimensionValueList.LookupMode(true);
                    DimensionValueList.SetTableView(DimensionValue);
                    if DimensionValueList.RunModal() = action::LookupOK then begin
                        DimensionValueList.GetRecord(DimensionValue);
                        ShortcutDims[5] := DimensionValue.Code;
                        DimMgt.ValidateShortcutDimValues(5, DimensionValue.Code, Rec."Dimension Set ID");
                        OldParentDimSetID := Rec."Dimension Set ID";
                        DimMgt.ValidateShortcutDimValues(5, DimensionValue.Code, Rec."Dimension Set ID");
                        NewParentDimSetID := Rec."Dimension Set ID";
                        Rec.UpdateAllLineDim(NewParentDimSetID, OldParentDimSetID);
                    end;
                end;

                trigger OnValidate()
                var
                    UserSetup: Record "User Setup";
                    AppMgt: Codeunit AppMgtNVX;
                    NewParentDimSetID: Integer;
                    OldParentDimSetID: Integer;
                begin
                    AppMgt.GetUserSetup(UserSetup, true);
                    AppMgt.AllowdBusinessFieldsForUser();
                    AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, ShortcutDims[5], true);

                    OldParentDimSetID := Rec."Dimension Set ID";
                    DimMgt.ValidateShortcutDimValues(5, ShortcutDims[5], Rec."Dimension Set ID");
                    NewParentDimSetID := Rec."Dimension Set ID";
                    Rec.UpdateAllLineDim(NewParentDimSetID, OldParentDimSetID);
                end;
            }
            field("Transaction No. NVX"; SalesHeaderNVX."Transaction No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Transaction No.', comment = 'DEA="Verkauf Transaktionsnummer"';
                Editable = false;
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
                    Item: Record Item;
                    DimensionValue: Record "Dimension Value";
                    ConfirmUpdateQst: Label 'Do you want to update Sales %1 and %2 in Sales Line with the values defined in %3?', comment = 'DEA="Möchten Sie Verkauf-%1 und %2 mit den Daten aus %3 aktualisieren?"';
                begin
                    DimMgt.ValidateShortcutDimValues(6, ShortcutDims[6], Rec."Dimension Set ID");
                    Rec.Modify();
                    if ShortcutDims[6] = '' then
                        exit;
                    if Item.Get(SalesLine."No.") then;
                    if not Item."Inventory Value Zero" then begin
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

                                SalesLine.Modify();
                                SalesLineNVX.Modify();

                            until SalesLine.Next() = 0;

                        end;
                    end;
                end;
            }
        }

        modify("Prices Including VAT")
        {
            trigger OnAfterValidate();
            var
                LSalesLine: Record "Sales Line";
                SalesLineNVX: Record SalesLineNVX;
            begin
                SalesLineNVX.SetRange("Document Type", Rec."Document Type");
                SalesLineNVX.SetRange("Document No.", Rec."No.");
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
                PromotedIsBig = true;
                PromotedCategory = Process;
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
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesLine: Record "Sales Line";
        SalesLineNVX: Record SalesLineNVX;

        DimMgt: Codeunit DimensionManagement;
        PageEditable: Boolean;
        ShortcutDims: array[10] of Code[20];

    trigger OnAfterGetRecord();
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
        PageEditable := CurrPage.Editable;

        if not SalesHeaderNVX.Get("Document Type", "No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := "Document Type";
            SalesHeaderNVX."No." := "No.";
            SalesHeaderNVX.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(DocumentType: Enum RKSSalesDocumentTypeNVX; DocumentNo: Code[20])
    begin
    end;
}