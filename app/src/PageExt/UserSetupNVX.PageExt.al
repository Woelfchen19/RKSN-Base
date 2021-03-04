pageextension 50002 UserSetupNVX extends "User Setup"
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
                //TODO ToolTip
                ToolTip = 'TODO', comment = 'DEA="TODO"';
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