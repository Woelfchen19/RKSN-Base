pageextension 50001 ItemCardNVX extends "Item Card"
{
    layout
    {
        addlast(InventoryGrp)
        {
            field(InventoryValueZeroNVX; "Inventory Value Zero")
            //RKSN-36
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        addlast("Posting Details")
        {
            field(GlobalDimension1Code; "Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(GlobalDimension2Code; "Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(GlobalDimension3Code; GlobalDimension3Code)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
                CaptionClass = '1,2,3';
                trigger OnValidate();
                begin
                    DimMgt.SaveDefaultDim(Database::Item, Rec."No.", 3, GlobalDimension3Code);
                end;
            }
            field("VAT Prod. Posting Group NVX"; "VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }
        addlast(Planning)
        {
            field(ActivationNVX; ItemNVX.Activation)
            {
                ApplicationArea = All;
                Caption = 'Activation', comment = 'DEA="Aktivierung"';
                trigger OnValidate();
                begin
                    ItemNVX.Modify();
                end;
            }
            
        }
        modify("VAT Prod. Posting Group")
        {
            Enabled = false;
            Visible = false;
        }

    }

    var
        GLSetup: Record "General Ledger Setup";
        ItemNVX: Record ItemNVX;
        DimMgt: Codeunit DimensionManagement;
        GLSetupRead: Boolean;
        GlobalDimension3Code: Code[20];


    trigger OnAfterGetRecord();
    var
        DefaultDim: Record "Default Dimension";
    begin
        ReadGLSetup();
        DefaultDim.SetRange("Table ID", Database::Item);
        DefaultDim.SetRange("No.", Rec."No.");
        DefaultDim.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
        IF DefaultDim.FindFirst then
            GlobalDimension3Code := DefaultDim."Dimension Value Code";

        IF not ItemNVX.Get("No.") then begin
            ItemNVX.Init();
            ItemNVX."Item No." := "No.";
            ItemNVX.Insert();
        end;
    end;


    local procedure ReadGLSetup();
    begin
        if not GLSetupRead then begin
            GLSetup.Get();
            GLSetupRead := true;
        end;
    end;


}