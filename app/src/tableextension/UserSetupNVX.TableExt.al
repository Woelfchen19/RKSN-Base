tableextension 50011 "UserSetupNVX" extends "User Setup"
{
    fields
    {
        field(50000; AllowItemProdPstGrpChangeNVX; Boolean)
        {
            Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
            DataClassification = CustomerContent;
        }
        field(50001; AllowItemInvtPstGrpChangeNVX; Boolean)
        {
            Caption = 'Allow Item Invt.Post.Group Change', comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
            DataClassification = CustomerContent;
        }
        field(50002; AllowSetupReminderNVX; Boolean)
        {
            Caption = 'Allow Reminder Setup', comment = 'DEA="Zugriff Erweiterung Mahnung erlauben"';
            DataClassification = CustomerContent;
        }
        field(50003; AllowedDimension5CodeChangeNVX; Boolean)
        {
            Caption = 'Allowed modify Businessfield', comment = 'DEA="Änderung Code Dim.Geschäftsfeld erlaubt"';
            DataClassification = CustomerContent;
        }
        field(50004; AllowedModifyIssuedReminderNVX; Boolean)
        {
            Caption = 'Allowed modify Issued Reminder', comment = 'DEA="Änderungen registrierte Mahnungen zulassen"';
            DataClassification = CustomerContent;
        }
        field(50005; ReminderExtenionsAdminNVX; Boolean)
        {
            Caption = 'Admin Reminder Extension', comment = 'DEA="Admin Mahnwesen erweitert"';
            DataClassification = CustomerContent;
        }
        field(50006; EditCustomerPostingGroupNVX; Boolean)
        {
            Caption = 'Edit Customer Posting Group', comment = 'DEA="EDIT Sammelkonto.Debitoren"';
        }
        field(50007; EditVendorPostingGroupNVX; Boolean)
        {
            Caption = 'Edit Vendor Posting Group', comment = 'DEA="EDIT Sammelkonto.Kreditoren"';
        }
        field(50010; PBSetupNVX; Boolean)
        {
            Caption = 'PB-setup', comment = 'DEA="PB-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50011; RDSetupNVX; Boolean)
        {
            Caption = 'RD-setup', comment = 'DEA="RD-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50012; RHSetupNVX; Boolean)
        {
            Caption = 'RH-setup', comment = 'DEA="RH-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50013; EASetupNVX; Boolean)
        {
            Caption = 'EA-setup', comment = 'DEA="EA-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50014; SOSetupNVX; Boolean)
        {
            Caption = 'SO-setup', comment = 'DEA="SO-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50015; EVSetupNVX; Boolean)
        {
            Caption = 'EV-setup', comment = 'DEA="EV-setup"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            begin
                CreateBusinessFieldFilterNVX();
            end;
        }
        field(50016; ReminderRunAuthorizedNVX; Boolean)
        {
            Caption = 'Reminder Run authorized', comment = 'DEA="Mahnlauf berechtigt"';
            DataClassification = CustomerContent;
        }
        field(50017; EditBusFieldCustLedgerEntryNVX; Boolean)
        {
            Caption = 'EDIT BusinessField CustLedgerEntry', comment = 'DEA="EDIT Geschäftsfeld Debitorenposten"';
        }
        field(50018; SetupDynamicFieldsNVX; Boolean)
        {
            Caption = 'Setup dynamic Fields', comment = 'DEA="setup dynamische Felder erlaubt"';
        }
        field(50019; AllCollectedAccountsNVX; Boolean)
        {
            Caption = 'All Collected Accounts', comment = 'DEA="Alle Sammelkto"';
        }
        field(50020; BusinessFieldFilterNVX; Code[40])
        {
            Caption = 'BusinessField Filter', comment = 'DEA="Geschäftsfeld Filter"';
        }
    }

    procedure GetRecordOnceNVX()
    begin
        ReminderExtensionSetup.GetRecordOnce();
        if not ReminderExtensionSetup.IsReminderExtensionActivated() then
            exit;

        if RecordHasBeenRead then
            exit;
        Get();
        RecordHasBeenRead := true;
    end;

    /// <summary>
    /// ToDo
    /// </summary>
    /// <param name="WithTestUser"></param>
    // procedure GetRecordOnce(WithTestUser: Boolean)
    // begin
    //     ReminderExtensionSetup.GetRecordOnce();
    //     if not ReminderExtensionSetup.IsReminderExtensionActivated() then
    //         exit;

    //     if not WithTestUser then
    //         GetRecordOnce()
    //     else
    //         AppMgt.GetUserSetup(Rec,true);
    //         if RecordHasBeenRead then
    //             exit;
    //     Get();
    //     RecordHasBeenRead := true;
    // end;

    procedure CreateBusinessFieldFilterNVX()
    var
        SetupReminderExtension: record "ReminderExtensionSetupNVX";
        InclusiveEmptyEntries: Boolean;
    begin
        InclusiveEmptyEntries := SetupReminderExtension.Get() and SetupReminderExtension.AllowEmptyfilter;
        AppMgt.CreateBusinessFieldFilter(Rec, InclusiveEmptyEntries);
    end;

    var
        ReminderExtensionSetup: Record ReminderExtensionSetupNVX;
        AppMgt: Codeunit AppMgtNVX;
        RecordHasBeenRead: Boolean;
}