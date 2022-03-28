codeunit 50002 Codeunit415HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure HandleVATNVX(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; LinesWereModified: Boolean)
    var
        PurchaseLineNVX: Record PurchaseLineNVX;
    begin
        PurchaseLineNVX.HandleVATDifferenceNVX(PurchaseHeader);
    end;
}
