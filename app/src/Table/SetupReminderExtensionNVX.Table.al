table 50006 "SetupReminderExtensionNVX"
{
    Caption = 'Setup Reminder Extension', comment = 'DEA="Einrichtung Erweiterung Mahnung"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
            DataClassification = CustomerContent;
        }
        field(2; ActivateBusinessFilterInPages; Boolean)
        {
            Caption = 'Active Filter BusinessFields for Pages', comment = 'DEA="Filter Geschäftsfelder für Pages aktivieren"';
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
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

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
}