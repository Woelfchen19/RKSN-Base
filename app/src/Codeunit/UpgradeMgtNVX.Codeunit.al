codeunit 50024 "UpgradeMgtNVX"
{
    Subtype = Upgrade;

    trigger OnUpgradePerDatabase()
    begin
    end;

    trigger OnUpgradePerCompany()
    begin
        InsertSetupPropertyForField();
        InitializeDimensionCustomer();
        InsertSetupReminderExtension();
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        WebSiteUriIBANTxt: Label 'https://www.smart-rechner.de/iban_pruefen/rechner.php';

    local procedure InsertSetupPropertyForField()
    begin
        AppMgt.InsertSetupPropertyForField();
    end;

    local procedure InitializeDimensionCustomer()
    begin
        AppMgt.InitializeDimensionCustomer();
    end;

    local procedure InsertSetupReminderExtension()
    var
        SetupReminderExtension: Record SetupReminderExtensionNVX;
    begin
        if not SetupReminderExtension.Get() then begin
            SetupReminderExtension.Init();
            SetupReminderExtension.ActivateBusinessFilterInPages := true;
            SetupReminderExtension.WebSiteIBAN := Copystr(WebSiteUriIBANTxt, 1, 50);
            SetupReminderExtension.Insert();
        end;
    end;
}