pageextension 50027 DimValueNVX extends "Dimension Values"
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
                trigger OnValidate();
                begin
                    DimValueNVX.Modify();
                    DimValueNVX.CalcFields("VAT Posting Type Desc");
                end;                    
            }
            field("VAT Posting Type Desc NVX"; DimValueNVX."VAT Posting Type Desc")
            {
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Visible = PostingTypeVisible;
                ApplicationArea = All;
                Editable = false;
            }
            
            
        }
    }
    
    var
        DimValueNVX: Record DimValueNVX;
        GLSetup: Record "General Ledger Setup";
        PostingTypeVisible: Boolean;        
        GLSetupRead: Boolean;

    trigger OnAfterGetRecord();
    begin
        GetGLSetup();
        IF GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 3 Code" then
            PostingTypeVisible := true
        else begin
            PostingTypeVisible := false;
            exit;
        end;
        If not DimValueNVX.GET("Dimension Code",Code) then begin
            DimValueNVX.Init();
            DimValueNVX."Dimension Code" := "Dimension Code";
            DimValueNVX.Code := Code;
            DimValueNVX.Insert();
        end;       
        DimValueNVX.CalcFields("VAT Posting Type Desc");
    end;

    local procedure GetGLSetup();
    begin
        if not GLSetupRead then begin
          GLSetup.get;
          GLSetupRead := true;
        end;
    end;
}