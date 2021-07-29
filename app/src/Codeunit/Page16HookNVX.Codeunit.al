codeunit 50023 Page16HookNVX
{
    [EventSubscriber(ObjectType::Page, Page::"Chart of Accounts", 'OnOpenPageEvent', '', true, true)]
    local procedure SetHiddenFilter(var Rec: Record "G/L Account")
    begin
        rec.setrange("hidden NVX", false);
    end;
}