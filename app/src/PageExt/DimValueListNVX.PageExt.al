pageextension 50007 "DimValueListNVX" extends "Dimension Value List"
{
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
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));  
                Visible = IsOE;     
            }
            field("DimValueNVX Shortcut Dimension 2 CodeNVX"; DimValueNVX."Shortcut Dimension 2 Code")
            {
                ApplicationArea = All;
                CaptionClass = '1,2,2';
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                Visible = IsOE;      
            }
            
        }
    }
    
    var
        DimValueNVX: Record DimValueNVX;
        PostingTypeVisible: Boolean;        
        IsOE: Boolean;

    trigger OnAfterGetRecord();
    begin
        IF (not PostingTypeVisible) and (not IsOE) then
            exit;

        If not DimValueNVX.GET("Dimension Code",Code) then begin
            DimValueNVX.Init();
            DimValueNVX."Dimension Code" := "Dimension Code";
            DimValueNVX.Code := Code;
            DimValueNVX.Insert();
        end;
        IF PostingTypeVisible then
            DimValueNVX.CalcFields("VAT Posting Type Desc");
    end;

    trigger OnOpenPage();
    begin
        IF GetFilter("Global Dimension No.") = '3' then
            PostingTypeVisible := true
        else
            PostingTypeVisible := false;

        IF GetFilter("Global Dimension No.") = '6' then
            IsOE := true
        else
            IsOE := false;
    end;
}