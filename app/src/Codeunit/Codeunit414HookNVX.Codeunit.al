codeunit 50001 Codeunit414HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure HandleVATNVX(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; LinesWereModified: Boolean)
    var
        SalesLineNVX: Record SalesLineNVX;
    begin
        SalesLineNVX.HandleVATDifferenceNVX(SalesHeader);
    end;
}
