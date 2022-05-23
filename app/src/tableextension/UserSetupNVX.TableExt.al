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
        field(50020; BusinessFieldFilterNVX; Code[20])
        {
            Caption = 'BusinessField Filter', comment = 'DEA="Geschäftsfeld Filter"';
        }
    }

    procedure CreateBusinessFieldFilterNVX()
    var
        SetupReminderExtension: record SetupReminderExtensionNVX;
        AppMgt: Codeunit AppMgtNVX;
        InclusiveEmptyEntries: Boolean;
    begin
        InclusiveEmptyEntries := SetupReminderExtension.Get() and SetupReminderExtension.AllowEmptyfilter;
        AppMgt.CreateBusinessFieldFilter(Rec, InclusiveEmptyEntries);
    end;
}