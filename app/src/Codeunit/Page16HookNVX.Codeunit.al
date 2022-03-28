codeunit 50006 Page16HookNVX
{
    [EventSubscriber(ObjectType::Page, Page::"Chart of Accounts", 'OnOpenPageEvent', '', true, true)]
    local procedure SetHiddenFilter(var Rec: Record "G/L Account")
    begin
        Rec.SetRange("Hidden NVX", false);
    end;
}