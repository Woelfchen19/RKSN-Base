codeunit 50005 SalesPostHookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestGBPG', '', false, false)]
    local procedure SkipGBPGTestfield(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterCheckMandatoryFields', '', true, true)]
    local procedure OnAfterCheckMandatoryFields(var SalesHeader: Record "Sales Header"; CommitIsSuppressed: Boolean)
    var
        UserSetup: Record "User Setup";
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        AppMgt: Codeunit AppMgtNVX;
        UserSetupErr: Label 'User %1 has no permission für this Businessfield! Please contact your Systemadministrator.', comment = 'DEA="Benutzer %1 hat keine Berechtigung für dieses Geschäftsfeld! Bitte wenden Sie sich an Ihren Systemadministrator."';
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        SalesHeader.TestField(ShortcutDimension5CodeNVX);
        if CustomerBusinessField.Get(SalesHeader."Sell-to Customer No.", SalesHeader.ShortcutDimension5CodeNVX) then begin
            CustomerBusinessField.TestField("Shortcut Dimension 9 Code");
            CustomerBusinessField.TestField("Payment Terms Code");
            CustomerBusinessField.TestField("Payment Method Code");
        end else
            Error(UserSetupErr, UserSetup."User ID");
    end;
}