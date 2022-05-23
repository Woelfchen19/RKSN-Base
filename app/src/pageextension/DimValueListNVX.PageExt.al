pageextension 50004 "DimValueListNVX" extends "Dimension Value List"
{
    // Editable = false;

    // layout
    // {
    //     addlast(Control1)
    //     {
    // field(VATPostingTypeNVX; Rec.VATPostingTypeNVX)
    // {
    //     ApplicationArea = All;
    //     Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
    //     Editable = false;
    //     TableRelation = VATPostingTypeNVX.Code;
    //     Visible = PostingTypeVisible;
    // }
    // field(VATPostingTypeDescNVX; Rec.VATPostingTypeDescNVX)
    // {
    //     ApplicationArea = All;
    //     Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
    //     Editable = false;
    //     Visible = PostingTypeVisible;
    // }
    //     field(DimValueNVXShortcutDimension1CodeNVX; Rec.ShortcutDimension1CodeNVX)
    //     {
    //         ApplicationArea = All;
    //         Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
    //         CaptionClass = '1,2,1';
    //         Editable = false;
    //         TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
    //         Visible = IsOE;
    //     }
    //     field(DimValueNVXShortcutDimension2CodeNVX; Rec.ShortcutDimension2CodeNVX)
    //     {
    //         ApplicationArea = All;
    //         Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
    //         CaptionClass = '1,2,2';
    //         Editable = false;
    //         TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
    //         Visible = IsOE;
    //     }
    //     field(DimValueNVXShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
    //     {
    //         ApplicationArea = All;
    //         Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
    //         CaptionClass = '1,2,5';
    //         Editable = true;
    //         TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
    //         Visible = DimValueNVXShortcutDimension5CodeVisible;
    //     }
    //     field(AssociatedNVX; Rec.AssociatedNVX)
    //     {
    //         ApplicationArea = All;
    //         Caption = 'Assosiated', comment = 'DEA="zugehörig"';
    //         Editable = true;
    //         Visible = AssosiatedVisible;
    //     }
    //     }
    // }

    // trigger OnOpenPage();
    // begin
    //     GLSetup.GetRecordOnce();
    //     PostingTypeVisible := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 3 Code";
    //     IsOE := GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 6 Code";
    //     DimValueNVXShortcutDimension5CodeVisible := GetFilter("Dimension Code") = GlSetup.ShortcutDimension9CodeNVX;
    //     AssosiatedVisible := GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 2 Code";
    // end;

    // var
    //     GLSetup: Record "General Ledger Setup";
    //     AssosiatedVisible: Boolean;
    //     DimValueNVXShortcutDimension5CodeVisible: Boolean;
    //     IsOE: Boolean;
    //     PostingTypeVisible: Boolean;
}