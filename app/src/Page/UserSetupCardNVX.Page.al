page 50037 "UserSetupCardNVX"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "User Setup";
    Caption = 'User Setup Reminder', comment = 'DEA="Benutzer Einrichtung Mahnwesen"';
    layout
    {
        area(Content)
        {
            group(Reminder)
            {
                Caption = '', comment = 'DEA="Mahnwesen"';
                field("User ID"; Rec."User ID")
                {
                    ToolTip = 'Specifies the value of the User ID field.';
                    ApplicationArea = All;
                }
                field(AllCollectedAccountsNVX; Rec.AllCollectedAccountsNVX)
                {
                    ToolTip = 'Specifies the value of the All Collected Accounts field.';
                    ApplicationArea = All;
                }
                field(AllowedDimension5CodeChangeNVX; Rec.AllowedDimension5CodeChangeNVX)
                {
                    ToolTip = 'Specifies the value of the Allowed modify Business Field field.';
                    ApplicationArea = All;
                }
                field(AllowedModifyIssuedReminderNVX; Rec.AllowedModifyIssuedReminderNVX)
                {
                    ToolTip = 'Specifies the value of the Allowed modify Issued Reminder field.';
                    ApplicationArea = All;
                }
                field(AllowItemInvtPstGrpChangeNVX; Rec.AllowItemInvtPstGrpChangeNVX)
                {
                    ToolTip = 'Specifies the value of the Allow Item Invt.Post.Group Change field.';
                    ApplicationArea = All;
                }
                field(AllowItemProdPstGrpChangeNVX; Rec.AllowItemProdPstGrpChangeNVX)
                {
                    ToolTip = 'Specifies if the user is allowed to change the Inventory Posting Group on items although entries are existing';
                    ApplicationArea = All;
                }
                field(AllowSetupReminderNVX; Rec.AllowSetupReminderNVX)
                {
                    ToolTip = 'Specifies the value of the Allow Reminder Setup field.';
                    ApplicationArea = All;
                }
                field(BusinessFieldFilterNVX; Rec.BusinessFieldFilterNVX)
                {
                    ToolTip = 'Specifies the value of the BusinessField Filter field.';
                    ApplicationArea = All;
                }
                field(EASetupNVX; Rec.EASetupNVX)
                {
                    ToolTip = 'Specifies the value of the EA-setup field.';
                    ApplicationArea = All;
                }
                field(EditBusFieldCustLedgerEntryNVX; Rec.EditBusFieldCustLedgerEntryNVX)
                {
                    ToolTip = 'Specifies the value of the EDIT BusinessField CustLedgerEntry field.';
                    ApplicationArea = All;
                }
                field(EditCustomerPostingGroupNVX; Rec.EditCustomerPostingGroupNVX)
                {
                    ToolTip = 'Specifies the value of the Edit Customer Posting Group field.';
                    ApplicationArea = All;
                }
                field(EditVendorPostingGroupNVX; Rec.EditVendorPostingGroupNVX)
                {
                    ToolTip = 'Specifies the value of the Edit Vendor Posting Group field.';
                    ApplicationArea = All;
                }
                field(EVSetupNVX; Rec.EVSetupNVX)
                {
                    ToolTip = 'Specifies the value of the EV-setup field.';
                    ApplicationArea = All;
                }
                field(PBSetupNVX; Rec.PBSetupNVX)
                {
                    ToolTip = 'Specifies the value of the PB-setup field.';
                    ApplicationArea = All;
                }
                field(RDSetupNVX; Rec.RDSetupNVX)
                {
                    ToolTip = 'Specifies the value of the RD-setup field.';
                    ApplicationArea = All;
                }
                field(ReminderExtenionsAdminNVX; Rec.ReminderExtenionsAdminNVX)
                {
                    ToolTip = 'Specifies the value of the Admin Reminder Extension field.';
                    ApplicationArea = All;
                }
                field(ReminderRunAuthorizedNVX; Rec.ReminderRunAuthorizedNVX)
                {
                    ToolTip = 'Specifies the value of the Reminder Run authorized field.';
                    ApplicationArea = All;
                }
                field(RHSetupNVX; Rec.RHSetupNVX)
                {
                    ToolTip = 'Specifies the value of the RH-setup field.';
                    ApplicationArea = All;
                }
                field(SetupDynamicFieldsNVX; Rec.SetupDynamicFieldsNVX)
                {
                    ToolTip = 'Specifies the value of the Setup dynamic Fields field.';
                    ApplicationArea = All;
                }
                field(SOSetupNVX; Rec.SOSetupNVX)
                {
                    ToolTip = 'Specifies the value of the SO-setup field.';
                    ApplicationArea = All;
                }
            }
        }
    }
}