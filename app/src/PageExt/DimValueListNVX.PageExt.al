pageextension 50004 DimValueListNVX extends "Dimension Value List"
{
    Editable = false;

    layout
    {
        addlast(Control1)
        {
            field("VAT Posting Type NVX"; DimValueNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                Visible = PostingTypeVisible;
                Editable = false;
            }
            field("VAT Posting Type Desc NVX"; DimValueNVX."VAT Posting Type Desc")
            {
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Visible = PostingTypeVisible;
                ApplicationArea = All;
                Editable = false;
            }
            field("DimValueNVX Shortcut Dimension 1 CodeNVX"; DimValueNVX."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,1';
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Visible = IsOE;
                Editable = false;
            }
            field("DimValueNVX Shortcut Dimension 2 CodeNVX"; DimValueNVX."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,2';
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                Visible = IsOE;
                Editable = false;
            }
        }
    }

    var
        DimValueNVX: Record DimValueNVX;
        IsOE: Boolean;
        PostingTypeVisible: Boolean;

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
        if GetFilter("Global Dimension No.") = '3' then
            PostingTypeVisible := true
        else
            PostingTypeVisible := false;

        if GetFilter("Global Dimension No.") = '6' then
            IsOE := true
        else
            IsOE := false;
    end;
}