codeunit 50031 "ReminderManagementNVX"
{
    SingleInstance = true;

    procedure Initialize()
    begin
        SetupReminderExtensionRead := false;
        SetupChangeLogRead := false;
    end;

    procedure GetSetupReminderExtension(var SetupReminderExtension: Record "ReminderExtensionSetupNVX")
    begin
        if not SetupReminderExtensionRead then
            SetupReminderExtension.Get();
        SetupReminderExtensionRead := true;
    end;

    procedure GetActiveChangeLogEntryDim(): Boolean
    var
        SetupReminderExtension: Record "ReminderExtensionSetupNVX";
    begin
        if not SetupChangeLogRead then begin
            GetSetupReminderExtension(SetupReminderExtension);
            SetupChangeLogRead := true;
        END;
        exit(SetupReminderExtension.ActiveChangeLogEntryDim);
    end;

    procedure GetWrongDimensionLbl(): Text
    var
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        exit(WrongDimErr);
    end;

    procedure GetPermissionErrorLbl(): Text
    var
        NotAllowedErr: Label 'You have no permission for this Ledger entry!',
                    comment = 'DEA="Sie sind zum gefundenen offenen Posten nicht berechtigt. Der offene Posten kann nicht angezeigt werden!"';
    begin
        exit(NotAllowedErr);
    end;

    var
        SetupReminderExtensionRead: Boolean;
        SetupChangeLogRead: Boolean;
}