pageextension 50027 "DimValueNVX" extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field("VAT Posting Type NVX"; VATPostingType)
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                Visible = PostingTypeVisible;
                trigger OnValidate();
                begin                    
                    IF Rec."Dimension Code" <> '' then
                        IF not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
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
            field("VAT Posting Type Desc NVX"; DimValueNVX."VAT Posting Type Desc")
            {
                Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
                Visible = PostingTypeVisible;
                ApplicationArea = All;
                Editable = false;
            }
            field("DimValueNVX Shortcut Dimension 1 CodeNVX"; ShortcutDimension1)
            {
                ApplicationArea = All;
                CaptionClass = '1,2,1';
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));  
                Visible = IsOE;
                trigger OnValidate();
                begin
                    IF Rec."Dimension Code" <> '' then
                        IF not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
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
            field("DimValueNVX Shortcut Dimension 2 CodeNVX"; ShortcutDimension2)
            {
                ApplicationArea = All;
                CaptionClass = '1,2,2';
                Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
                Visible = IsOE;
                trigger OnValidate();
                begin
                    IF Rec."Dimension Code" <> '' then
                        IF not DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then begin
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
            
        }
    }
    
    var
        DimValueNVX: Record DimValueNVX;
        GLSetup: Record "General Ledger Setup";
        VATPostingType: Code[10];
        ShortcutDimension1: Code[20];
        
        ShortcutDimension2: Code[20];
        PostingTypeVisible: Boolean;        
        GLSetupRead: Boolean;
        IsOE: Boolean;

    trigger OnAfterGetRecord();
    begin
        IF (not PostingTypeVisible) and (not IsOE) then
            exit;

        If not DimValueNVX.GET(Rec."Dimension Code",Rec.Code) then begin
            DimValueNVX.Init();
            DimValueNVX."Dimension Code" := "Dimension Code";
            DimValueNVX.Code := Code;
            DimValueNVX.Insert();
            Clear(VATPostingType);
            Clear(ShortcutDimension1);
            Clear(ShortcutDimension2);
        end else begin
            VATPostingType := DimValueNVX."VAT Posting Type";
            ShortcutDimension1 := DimValueNVX."Shortcut Dimension 1 Code";
            ShortcutDimension2 := DimValueNVX."Shortcut Dimension 2 Code";
        end;

        IF PostingTypeVisible then
            DimValueNVX.CalcFields("VAT Posting Type Desc");
    end;

    trigger OnOpenPage();
    begin
        GetGLSetup();

        IF GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 3 Code" then
            PostingTypeVisible := true
        else
            PostingTypeVisible := false;

        IF GetFilter("Dimension Code") = GLSetup."Shortcut Dimension 6 Code" then
            IsOE := true
        else
            IsOE := false;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(VATPostingType);
        Clear(ShortcutDimension1);
        Clear(ShortcutDimension2);
        DimValueNVX.Init();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        If (VATPostingType <> '') OR (ShortcutDimension1 <> '') OR (ShortcutDimension2 <> '') then begin
            DimValueNVX.Init();
            DimValueNVX."Dimension Code" := "Dimension Code";
            DimValueNVX.Code := Code;
            DimValueNVX."VAT Posting Type" := VATPostingType;
            DimValueNVX."Shortcut Dimension 1 Code" := ShortcutDimension1;
            DimValueNVX."Shortcut Dimension 2 Code" := ShortcutDimension2;
            DimValueNVX.Insert();
        end;
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        Clear(VATPostingType);
        Clear(ShortcutDimension1);
        Clear(ShortcutDimension2);
        DimValueNVX.Init();
        exit(true);
    end;


    local procedure GetGLSetup();
    begin
        if not GLSetupRead then begin
          GLSetup.Get();
          GLSetupRead := true;
        end;
    end;

    
}