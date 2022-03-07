pageextension 50001 ItemCardNVX extends "Item Card"
{
    layout
    {
        addlast(InventoryGrp)
        {
            field(InventoryValueZeroNVX; Rec."Inventory Value Zero")
            {
                ApplicationArea = All;
                Editable = false;
            }
        }

        addlast("Posting Details")
        {
            field(GlobalDimension1CodeNVX; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field(GlobalDimension2CodeNVX; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }
            field(GlobalDimension3CodeNVX; GlobalDimension3Code)
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                CaptionClass = '1,2,3';
                trigger OnValidate();
                begin
                    DimMgt.SaveDefaultDim(Database::Item, Rec."No.", 3, GlobalDimension3Code);
                end;
            }
            field("VAT Prod. Posting Group NVX"; Rec."VAT Prod. Posting Group")
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
            field("Deactivate balance line - Inventory Value ZeroNVX"; ItemNVX."No bal line - Inv Value Zero")
            {
                ApplicationArea = All;
                Caption = 'Deactivate balance line - Inventory Value Zero', comment = 'DEA="Entlastungszeile ohne Wertefluss deaktiviert"';
                trigger OnValidate();
                begin
                    if ItemNVX."No bal line - Inv Value Zero" then
                        Rec.TestField("Inventory Value Zero", true);
                    ItemNVX.Modify();
                end;
            }
            field("Deactivate Inventory Gen. Bus. Posting GroupNVX"; ItemNVX."No Inv Gen. Bus. Posting Group")
            {
                Caption = 'Deactivate Inventory Gen. Bus. Posting Group', comment = 'DEA="Steuerschlüssel Lager Einr.deaktivieren"';
                ApplicationArea = All;
                trigger OnValidate();
                var
                    ItemEntry: Record "Item Ledger Entry";
                    ItemEntryNotEmptyErr: Label 'You cannot change this field if there are posted item entries', comment = 'DEA="Diese Einrichtung ist nur solange änderbar als es zum betreffenden Artikel noch keine Bewegungsposten gibt"';
                begin
                    ItemEntry.SetRange("Item No.", Rec."No.");
                    if not ItemEntry.IsEmpty() then
                        Error(ItemEntryNotEmptyErr);
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
        if DefaultDim.FindFirst() then
            GlobalDimension3Code := DefaultDim."Dimension Value Code";

        if not ItemNVX.Get("No.") then begin
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