table 50006 "ReminderExtensionSetupNVX"
{
    Caption = 'Reminder Extension Setup', comment = 'DEA="Erweiterung Mahnung Einrichtung"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
            DataClassification = CustomerContent;
        }
        field(2; ActivateReminderExtension; Boolean)
        {
            Caption = 'Activate Module Reminderextension', comment = 'DEA="Modul Mahnwesen Erweiterung aktivieren"';
            DataClassification = CustomerContent;
        }
        field(3; AllowEmptyfilter; Boolean)
        {
            Caption = 'use also empty filter', comment = 'DEA="Leeren Filter berücksichten"';
            DataClassification = CustomerContent;
        }
        field(4; WebSiteIBAN; Code[50])
        {
            Caption = 'Website IBAN', comment = 'DEA="Webseite IBAN"';
            DataClassification = CustomerContent;
        }
        field(8; "Test User Activate"; Boolean)
        {
            Caption = 'Test User Activate', comment = 'DEA="Testbenutzer aktiviert"';
            DataClassification = CustomerContent;
        }
        field(7; "Test User ID"; Code[50])
        {
            Caption = 'Test User ID', comment = 'DEA="Testbenutzer"';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = "User Setup";
        }
        field(9; ActiveChangeLogEntryDim; Boolean)
        {
            Caption = 'Activate ChangeLogEntry Dimension', comment = 'DEA="Änderungsprotokol Dimension aktivieren"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }
    procedure GetRecordOnce()
    begin
        if RecordHasBeenRead then
            exit;
        Rec.Get();
        RecordHasBeenRead := true;
    end;

    procedure RefreshUserSetup()
    var
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
    begin
        if UserSetup.FindSet() then
            repeat
                AppMgt.CreateBusinessFieldFilter(UserSetup, Rec.AllowEmptyfilter);
            until UserSetup.Next() = 0;
    end;

    procedure TestUserActivate(): Boolean
    begin
        exit(Rec."Test User Activate")
    end;

    procedure IsReminderExtensionActivated(): Boolean
    begin
        exit(Rec.ActivateReminderExtension);
    end;

    var
        RecordHasBeenRead: Boolean;
}