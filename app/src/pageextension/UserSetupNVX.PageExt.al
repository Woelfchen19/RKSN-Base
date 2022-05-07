pageextension 50047 UserSetupNVX extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field(AllowItemInvtPstGrpChangeNVX; Rec.AllowItemInvtPstGrpChangeNVX)
            {
                ToolTip = 'Specifies the value of the Allow Item Invt.Post.Group Change field.', Comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
                ApplicationArea = All;
            }
            field(AllowItemProdPstGrpChangeNVX; Rec.AllowItemProdPstGrpChangeNVX)
            {
                ToolTip = 'Specifies if the user is allowed to change the Inventory Posting Group on items although entries are existing',
                comment = 'DEA="Gibt an, ob die Lagerbuchungsgruppe am Artikel geändert werden darf obwohl bereits Artikelposten existieren"';
                ApplicationArea = All;
            }
            field(PBSetupNVX; Rec.PBSetupNVX)
            {
                ToolTip = 'Specifies the value of the PB-setup field.', Comment = 'DEA="PB-setup"';
                ApplicationArea = All;
            }
            field(RDSetupNVX; Rec.RDSetupNVX)
            {
                ToolTip = 'Specifies the value of the RD-setup field.', Comment = 'DEA="RD-setup"';
                ApplicationArea = All;
            }
            field(RHSetupNVX; Rec.RHSetupNVX)
            {
                ToolTip = 'Specifies the value of the RH-setup field.', Comment = 'DEA="RH-setup"';
                ApplicationArea = All;
            }
            field(EASetupNVX; Rec.EASetupNVX)
            {
                ToolTip = 'Specifies the value of the EA-setup field.', Comment = 'DEA="EA-setup"';
                ApplicationArea = All;
            }
            field(SOSetupNVX; Rec.SOSetupNVX)
            {
                ToolTip = 'Specifies the value of the SO-setup field.', Comment = 'DEA="SO-setup"';
                ApplicationArea = All;
            }
            field(EVSetupNVX; Rec.EVSetupNVX)
            {
                ToolTip = 'Specifies the value of the EV-setup field.', Comment = 'DEA="EV-setup"';
                ApplicationArea = All;
            }
            field(ReminderRunAuthorizedNVX; Rec.ReminderRunAuthorizedNVX)
            {
                ToolTip = 'Specifies the value of the Reminder Run authorized field.', Comment = 'DEA="Mahnlauf berechtigt"';
                ApplicationArea = All;
            }
        }
    }
}