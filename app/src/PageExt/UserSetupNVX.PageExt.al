pageextension 50047 UserSetupNVX extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Allow Item Prod.Post.Group Change NVX"; UserSetupNVX."Allow Item Prod.Pst.Grp Change")
            {
                ApplicationArea = All;
                Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
                ToolTip = 'Specifies if the user is allowed to change the Prod. Posting Group on items although entries are existing',
                comment = 'DEA="Gibt an, ob die Produktbuchungsgruppe am Artikel geändert werden darf obwohl bereits Artikelposten existieren"';
                trigger OnValidate();
                begin
                    SetComplementaryFields();
                end;
            }
            field("Allow Item Invt.Post.Group Change NVX"; UserSetupNVX."Allow Item Invt.Pst.Grp Change")
            {
                ApplicationArea = All;
                Caption = 'Allow Item Invt.Post.Group Change', comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
                ToolTip = 'Specifies if the user is allowed to change the Inventory Posting Group on items although entries are existing',
                comment = 'DEA="Gibt an, ob die Lagerbuchungsgruppe am Artikel geändert werden darf obwohl bereits Artikelposten existieren"';
                trigger OnValidate();
                begin
                    SetComplementaryFields();
                end;
            }
        }
    }

    var
        UserSetupNVX: Record UserSetupNVX;
        AllowItemInvtPstGrpChange: Boolean;
        AllowItemProdPstGrpChange: Boolean;


    trigger OnAfterGetRecord()
    begin
        UserSetupNVX.GetDefinition(Rec."User ID");
        SetGlobalVariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        UserSetupNVX.GetDefinition(Rec."User ID");
        SetComplementaryFields();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure SetGlobalVariables()
    begin
        AllowItemProdPstGrpChange := UserSetupNVX."Allow Item Prod.Pst.Grp Change";
        AllowItemInvtPstGrpChange := UserSetupNVX."Allow Item Invt.Pst.Grp Change";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(UserSetupNVX);
        Clear(AllowItemProdPstGrpChange);
        Clear(AllowItemInvtPstGrpChange)
    end;

    local procedure SetComplementaryFields()
    begin
        if (AllowItemProdPstGrpChange = UserSetupNVX."Allow Item Prod.Pst.Grp Change") and
            (AllowItemInvtPstGrpChange = UserSetupNVX."Allow Item Invt.Pst.Grp Change") then
            exit;

        UserSetupNVX."Allow Item Prod.Pst.Grp Change" := AllowItemProdPstGrpChange;
        UserSetupNVX."Allow Item Invt.Pst.Grp Change" := AllowItemInvtPstGrpChange;
        UserSetupNVX.Modify();
    end;
}