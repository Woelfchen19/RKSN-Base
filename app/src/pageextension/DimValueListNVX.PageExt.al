pageextension 50004 DimValueListNVX extends "Dimension Value List"
{
    Editable = false;

    layout
    {
        addlast(Control1)
        {
            field(VATPostingTypeNVX; DimValueNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                Visible = PostingTypeVisible;
                Editable = false;
            }
            field(VATPostingTypeDescNVX; DimValueNVX."VAT Posting Type Desc")
            {
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Visible = PostingTypeVisible;
                ApplicationArea = All;
                Editable = false;
            }
            field(DimValueNVXShortcutDimension1CodeNVX; DimValueNVX."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,1';
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Visible = IsOE;
                Editable = false;
            }
            field(DimValueNVXShortcutDimension2CodeNVX; DimValueNVX."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,2';
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                Visible = IsOE;
                Editable = false;
            }
            field(DimValueNVXShortcutDimension5CodeNVX; DimValueNVX."Shortcut Dimension 5 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
                Visible = DimValueNVXShortcutDimension5CodeVisible;
                Editable = true;
            }
            field(AssociatedNVX; DimValueNVX.Assosiated)
            {
                ApplicationArea = All;
                Caption = 'Assosiated', comment = 'DEA="zugehörig"';
                Visible = AssosiatedVisible;
                Editable = true;
            }
        }
    }

    trigger OnAfterGetRecord();
    begin
        if (not PostingTypeVisible) and (not IsOE) then
            exit;
        DimValueNVX.GetDefinition(Rec."Dimension Code", Rec.Code);
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
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimValueNVX: Record DimValueNVX;
        IsOE: Boolean;
        PostingTypeVisible: Boolean;
        DimValueNVXShortcutDimension5CodeVisible: Boolean;
        AssosiatedVisible: Boolean;
}
