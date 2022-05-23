codeunit 50006 "GLAccountSetHiddenFilterNVX"
{
    [EventSubscriber(ObjectType::Page, Page::"Chart of Accounts", 'OnOpenPageEvent', '', true, true)]
    local procedure SetHiddenFilterChartofAccounts(var Rec: Record "G/L Account")
    begin
        Rec.SetRange(HiddenNVX, false);
    end;

    [EventSubscriber(ObjectType::Page, Page::"G/L Account List", 'OnOpenPageEvent', '', true, true)]
    local procedure SetHiddenFilterGLAccountList(var Rec: Record "G/L Account")
    begin
        Rec.SetRange(HiddenNVX, false);
    end;
}