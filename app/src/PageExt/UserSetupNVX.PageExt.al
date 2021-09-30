pageextension 50002 "UserSetupNVX" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field("Allow Item Prod.Post.Group Change NVX"; UserSetupNVX."Allow Item Prod.Pst.Grp Change")
            //RKSN-37
            {
                ApplicationArea = All;
                Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
                ToolTip = 'Specifies if the user is allowed to change the Prod. Posting Group on items although entries are existing', 
                comment = 'DEA="Gibt an, ob die Produktbuchungsgruppe am Artikel geändert werden darf obwohl bereits Artikelposten existieren"';
                trigger OnValidate();
                begin
                    UserSetupNVX.Modify();
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
                    UserSetupNVX.Modify();
                end;
            }
        }
    }
    
    actions
    {
    }

    var
        UserSetupNVX: Record UserSetupNVX;

    trigger OnAfterGetRecord();
    begin
        If not UserSetupNVX.get("User ID") then begin
            UserSetupNVX.Init();
            UserSetupNVX."User ID" := "User ID";
            UserSetupNVX.Insert();
        end;
    end;


}