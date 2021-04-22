codeunit 50016 "Codeunit414HookNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"release sales document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure HandleVATNVX(var SalesHeader: Record "Sales Header"; PreviewMode: boolean; LinesWereModified: boolean)
    var
        SalesLineNVX: record SalesLineNVX;
    begin
        SalesLineNVX.HandleVATDifferenceNVX(SalesHeader);
    end;
}
