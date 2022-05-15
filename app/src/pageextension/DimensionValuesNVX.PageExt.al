pageextension 50005 "DimensionValuesNVX" extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field(VATPostingTypeNVX; Rec.VATPostingTypeNVX)
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                Visible = PostingTypeVisible;
            }
            field(VATPostingTypeDescNVX; Rec.VATPostingTypeDescNVX)
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Editable = false;
                Visible = PostingTypeVisible;
            }
            field(DimValueNVXShortcutDimension1CodeNVX; Rec.ShortcutDimension1CodeNVX)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1,2,1';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Visible = IsOE;
            }
            field(DimValueNVXShortcutDimension2CodeNVX; Rec.ShortcutDimension2CodeNVX)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                CaptionClass = '1,2,2';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                Visible = IsOE;
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
                RunObject = Page AssosiatedDepartmentListNVX;
                RunPageLink = "Shortcut Dimension 5 Code" = FIELD(Code);
                Visible = AssosiatedDepartment;
            }
        }
    }

    trigger OnOpenPage();
    begin
        GLSetup.GetRecordOnce();
        PostingTypeVisible := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 3 Code";
        IsOE := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 6 Code";
        DimValueNVXShortcutDimension5CodeVisible := GetFilter("Dimension Code") = GlSetup.ShortcutDimension9CodeNVX;
        AssosiatedVisible := GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 2 Code";
        AssosiatedDepartment := GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 5 Code";
    end;

    var
        GLSetup: Record "General Ledger Setup";
        AssosiatedDepartment: Boolean;
        AssosiatedVisible: Boolean;
        DimValueNVXShortcutDimension5CodeVisible: Boolean;
        IsOE: Boolean;
        PostingTypeVisible: Boolean;
}