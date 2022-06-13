pageextension 50047 "UserSetupNVX" extends "User Setup"
{
    layout
    {
        addlast(Control1)
        {
            field(AllowItemInvtPstGrpChangeNVX; Rec.AllowItemInvtPstGrpChangeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Allow Item Invt.Post.Group Change field.', Comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
            }
            field(AllowItemProdPstGrpChangeNVX; Rec.AllowItemProdPstGrpChangeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies if the user is allowed to change the Inventory Posting Group on items although entries are existing',
                comment = 'DEA="Gibt an, ob die Lagerbuchungsgruppe am Artikel geändert werden darf obwohl bereits Artikelposten existieren"';
            }
            field(PBSetupNVX; Rec.PBSetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the PB-setup field.', Comment = 'DEA="PB-setup"';
            }
            field(RDSetupNVX; Rec.RDSetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RD-setup field.', Comment = 'DEA="RD-setup"';
            }
            field(RHSetupNVX; Rec.RHSetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the RH-setup field.', Comment = 'DEA="RH-setup"';
            }
            field(EASetupNVX; Rec.EASetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EA-setup field.', Comment = 'DEA="EA-setup"';
            }
            field(SOSetupNVX; Rec.SOSetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the SO-setup field.', Comment = 'DEA="SO-setup"';
            }
            field(EVSetupNVX; Rec.EVSetupNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the EV-setup field.', Comment = 'DEA="EV-setup"';
            }
            field(ReminderRunAuthorizedNVX; Rec.ReminderRunAuthorizedNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Reminder Run authorized field.', Comment = 'DEA="Mahnlauf berechtigt"';
            }
            field(AllowSetupReminderNVX; Rec.AllowSetupReminderNVX)
            {
                ToolTip = 'Specifies the value of the Allow Reminder Setup field.', Comment = 'DEA="Zugriff Erweiterung Mahnung erlauben"';
                ApplicationArea = All;
            }
            field(AllowedDimension5CodeChangeNVX; Rec.AllowedDimension5CodeChangeNVX)
            {
                ToolTip = 'Specifies the value of the Allowed modify Business Field field.';
                ApplicationArea = All;
            }
            field(EditBusFieldCustLedgerEntryNVX; Rec.EditBusFieldCustLedgerEntryNVX)
            {
                ToolTip = 'Specifies the value of the EDIT BusinessField CustLedgerEntry field.';
                ApplicationArea = All;
            }
            field(EditCustomerPostingGroupNVX; Rec.EditCustomerPostingGroupNVX)
            {
                ToolTip = 'Specifies the value of the Edit Customer Posting Group field.', Comment = 'DEA="EDIT Sammelkonto.Debitoren"';
                ApplicationArea = All;
            }
            field(EditVendorPostingGroupNVX; Rec.EditVendorPostingGroupNVX)
            {
                ToolTip = 'Specifies the value of the Edit Vendor Posting Group field.', Comment = 'DEA="EDIT Sammelkonto.Kreditoren"';
                ApplicationArea = All;
            }
            field(AllCollectedAccountsNVX; Rec.AllCollectedAccountsNVX)
            {
                ToolTip = 'Specifies the value of the All Collected Accounts field.', Comment = 'DEA="Alle Sammelkto"';
                ApplicationArea = All;
            }
            field(SetupDynamicFieldsNVX; Rec.SetupDynamicFieldsNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Setup dynamic Fields field.', Comment = 'DEA="setup dynamische Felder erlaubt"';
            }
            field(AllowedModifyIssuedReminderNVX; Rec.AllowedModifyIssuedReminderNVX)
            {
                ToolTip = 'Specifies the value of the Allowed modify Issued Reminder field.', Comment = 'DEA="Änderungen registrierte Mahnungen zulassen"';
                ApplicationArea = All;
            }
            field(AllowedDimension5CodeNVX; Rec.AllowedDimension5CodeChangeNVX)
            {
                ToolTip = 'Specifies the value of the Allowed modify Business Field field.', Comment = 'DEA=""Änderung Code Dim.Geschäftsfeld erlaubt"';
                ApplicationArea = All;
            }
            field(BusinessFieldFilterNVX; Rec.BusinessFieldFilterNVX)
            {
                ToolTip = 'Specifies the value of the BusinessField Filter field.', Comment = 'DEA="Geschäftsfeld Filter"';
                ApplicationArea = All;
            }
            field(ReminderExtenionsAdministratorNVX; Rec.ReminderExtenionsAdminNVX)
            {
                ToolTip = 'Specifies the value of the Admin Reminder Extension field.', Comment = 'DEA="Admin Mahnwesen erweitert"';
                ApplicationArea = All;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        Rec.CreateBusinessFieldFilterNVX();
    end;
}