codeunit 50026 Codeunit415HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"release purchase document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure HandleVATNVX(var PurchaseHeader: Record "Purchase Header"; PreviewMode: boolean; LinesWereModified: boolean)
    var
        PurchaseLineNVX: record PurchaseLineNVX;
    begin
        PurchaseLineNVX.HandleVATDifferenceNVX(PurchaseHeader);
    end;
}
