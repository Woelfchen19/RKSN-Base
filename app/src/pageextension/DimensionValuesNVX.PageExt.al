pageextension 50005 DimensionValuesNVX extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field(VATPostingTypeNVX; VATPostingType)
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                Visible = PostingTypeVisible;
                trigger OnValidate();
                begin
                    if Rec."Dimension Code" <> '' then
                        if not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
                            DimValueNVX.Init();
                            DimValueNVX."Dimension Code" := Rec."Dimension Code";
                            DimValueNVX."Code" := Rec.Code;
                            DimValueNVX."VAT Posting Type" := VATPostingType;
                            DimValueNVX.Insert();
                        end else begin
                            DimValueNVX."VAT Posting Type" := VATPostingType;
                            DimValueNVX.Modify();
                        end;
                    DimValueNVX.CalcFields("VAT Posting Type Desc");
                end;
            }
            field(VATPostingTypeDescNVX; DimValueNVX."VAT Posting Type Desc")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Editable = false;
                Visible = PostingTypeVisible;
            }
            field(DimValueNVXShortcutDimension1CodeNVX; ShortcutDimension1)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1,2,1';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Visible = IsOE;
                trigger OnValidate();
                begin
                    if Rec."Dimension Code" <> '' then
                        if not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
                            DimValueNVX.Init();
                            DimValueNVX."Dimension Code" := Rec."Dimension Code";
                            DimValueNVX."Code" := Rec.Code;
                            DimValueNVX."Shortcut Dimension 1 Code" := ShortcutDimension1;
                            DimValueNVX.Insert();
                        end else begin
                            DimValueNVX."Shortcut Dimension 1 Code" := ShortcutDimension1;
                            DimValueNVX.Modify();
                        end;
                end;
            }
            field(DimValueNVXShortcutDimension2CodeNVX; ShortcutDimension2)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                CaptionClass = '1,2,2';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                Visible = IsOE;
                trigger OnValidate();
                begin
                    if Rec."Dimension Code" <> '' then
                        if not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
                            DimValueNVX.Init();
                            DimValueNVX."Dimension Code" := Rec."Dimension Code";
                            DimValueNVX."Code" := Rec.Code;
                            DimValueNVX."Shortcut Dimension 2 Code" := ShortcutDimension2;
                            DimValueNVX.Insert();
                        end else begin
                            DimValueNVX."Shortcut Dimension 2 Code" := ShortcutDimension2;
                            DimValueNVX.Modify();
                        end;
                end;
            }
            field(AssociatedNVX; Rec.AssociatedNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assosiated field.', Comment = 'DEA="zugehörig"';
                Visible = AssosiatedVisible;
            }
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimValueNVXShortcutDimension5CodeVisible;
            }
        }
    }

    actions
    {
        addlast("F&unctions")
        {
            action(AssosiatedDepartmentNVX)
            {
                ApplicationArea = All;
                Caption = 'Assosiated Department', comment = 'DEA="KST zuordnen"';
                Image = Administration;
                RunObject = page AssosiatedDepartmentListNVX;
                RunPageLink = "Shortcut Dimension 5 Code" = FIELD(Code);
                Visible = AssosiatedDepartment;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if not PostingTypeVisible and not IsOE then
            exit;

        DimValueNVX.GetDefinition(Rec."Dimension Code", Rec.Code);
        SetGlobalVariables();

        if PostingTypeVisible then
            DimValueNVX.CalcFields("VAT Posting Type Desc");
    end;

    trigger OnOpenPage();
    begin
        GLSetup.GetRecordOnce();
        PostingTypeVisible := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 3 Code";
        IsOE := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 6 Code";
        DimValueNVXShortcutDimension5CodeVisible := GetFilter("Dimension Code") = GlSetup.ShortcutDimension9CodeNVX;
        AssosiatedVisible := GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 1 Code";
        AssosiatedDepartment := GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 5 Code";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        DimValueNVX.GetDefinition(Rec."Dimension Code", Rec.Code);
        SetComplementaryFields();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    var
        DimValueNVX: Record DimValueNVX;
        GLSetup: Record "General Ledger Setup";
        AssosiatedDepartment: Boolean;
        AssosiatedVisible: Boolean;
        DimValueNVXShortcutDimension5CodeVisible: Boolean;
        IsOE: Boolean;
        PostingTypeVisible: Boolean;
        VATPostingType: Code[10];
        ShortcutDimension1: Code[20];
        ShortcutDimension2: Code[20];

    local procedure ClearGlobalVariables()
    begin
        Clear(DimValueNVX);
        VATPostingType := '';
        ShortcutDimension1 := '';
        ShortcutDimension2 := '';
    end;

    local procedure SetComplementaryFields()
    begin
        DimValueNVX."VAT Posting Type" := VATPostingType;
        DimValueNVX."Shortcut Dimension 1 Code" := ShortcutDimension1;
        DimValueNVX."Shortcut Dimension 2 Code" := ShortcutDimension2;
        DimValueNVX.Modify();
    end;

    local procedure SetGlobalVariables()
    begin
        VATPostingType := DimValueNVX."VAT Posting Type";
        ShortcutDimension1 := DimValueNVX."Shortcut Dimension 1 Code";
        ShortcutDimension2 := DimValueNVX."Shortcut Dimension 2 Code";
    end;
}