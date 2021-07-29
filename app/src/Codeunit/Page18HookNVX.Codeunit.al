codeunit 50024 Page18HookNVX
{
    [EventSubscriber(ObjectType::Page, Page::"G/L Account List", 'OnOpenPageEvent', '', true, true)]
    local procedure SetHiddenFilter(var Rec: Record "G/L Account")
    begin
        rec.setrange("hidden NVX", false);
    end;
}