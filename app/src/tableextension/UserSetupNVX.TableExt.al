tableextension 50011 "UserSetupNVX" extends "User Setup"
{
    fields
    {
        field(50000; "AllowItemProdPstGrpChangeNVX"; Boolean)
        {
            Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
            DataClassification = CustomerContent;
        }
        field(50001; "AllowItemInvtPstGrpChangeNVX"; Boolean)
        {
            Caption = 'Allow Item Invt.Post.Group Change', comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
            DataClassification = CustomerContent;
        }
        field(50010; PBSetupNVX; Boolean)
        {
            Caption = 'PB-setup', comment = 'DEA="PB-setup"';
            DataClassification = CustomerContent;
        }
        field(50011; RDSetupNVX; Boolean)
        {
            Caption = 'RD-setup', comment = 'DEA="RD-setup"';
            DataClassification = CustomerContent;
        }
        field(50012; RHSetupNVX; Boolean)
        {
            Caption = 'RH-setup', comment = 'DEA="RH-setup"';
            DataClassification = CustomerContent;
        }
        field(50013; EASetupNVX; Boolean)
        {
            Caption = 'EA-setup', comment = 'DEA="EA-setup"';
            DataClassification = CustomerContent;
        }
        field(50014; SOSetupNVX; Boolean)
        {
            Caption = 'SO-setup', comment = 'DEA="SO-setup"';
            DataClassification = CustomerContent;
        }
        field(50015; EVSetupNVX; Boolean)
        {
            Caption = 'EV-setup', comment = 'DEA="EV-setup"';
            DataClassification = CustomerContent;
        }
        field(50016; ReminderRunAuthorizedNVX; Boolean)
        {
            Caption = 'Reminder Run authorized', comment = 'DEA="Mahnlauf berechtigt"';
            DataClassification = CustomerContent;
        }
    }
}