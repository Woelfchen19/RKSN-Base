codeunit 50024 "UpgradeMgtNVX"
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    begin
    end;

    trigger OnUpgradePerCompany()
    begin
        Upgrade();
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        WebSiteUriIBANTxt: Label 'https://www.smart-rechner.de/iban_pruefen/rechner.php';

    procedure Upgrade()

    begin
        InsertSetupPropertyForField();
        InitializeDimensionCustomer();
        InsertSetupReminderExtension();
        InsertSetupBusinessFieldsForCustomer();
        InsertReminderControlSetup();
    end;

    local procedure InitializeDimensionCustomer()
    begin
        AppMgt.InitializeDimensionCustomer();
    end;

    local procedure InsertSetupPropertyForField()
    begin
        AppMgt.InsertSetupPropertyForField();
    end;

    local procedure InsertSetupReminderExtension()
    var
        SetupReminderExtension: Record "ReminderExtensionSetupNVX";
    begin
        if not SetupReminderExtension.Get() then begin
            SetupReminderExtension.Init();
            SetupReminderExtension.ActivateReminderExtension := true;
            SetupReminderExtension.WebSiteIBAN := Copystr(WebSiteUriIBANTxt, 1, 50);
            SetupReminderExtension.Insert();
        end;
    end;

    local procedure InsertSetupBusinessFieldsForCustomer()
    begin
        AppMgt.InsertSetupBusinessFieldsForCustomer();
    end;

    local procedure InsertReminderControlSetup()
    var
        ReminderControlSetup: Record ReminderControlSetupNVX;
    begin
        if ReminderControlSetup.IsEmpty() then begin
            ReminderControlSetup.Init();
            ReminderControlSetup.ReminderSetupExtension := ReminderControlSetup.ReminderSetupExtension::BusinessField;
            ReminderControlSetup.Insert();
            ReminderControlSetup.Init();
            ReminderControlSetup.ReminderSetupExtension := ReminderControlSetup.ReminderSetupExtension::PC;
            ReminderControlSetup.Insert();
        end;
    end;
}