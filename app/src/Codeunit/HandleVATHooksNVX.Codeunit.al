codeunit 50001 "HandleVATHooksNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Sales Document", 'OnAfterReleaseSalesDoc', '', true, true)]
    local procedure HandleVATNVXReleaseSalesDocument(var SalesHeader: Record "Sales Header"; PreviewMode: Boolean; LinesWereModified: Boolean)
    var
        SalesLineNVX: Record SalesLineNVX;
    begin
        SalesLineNVX.HandleVATDifferenceNVX(SalesHeader);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Release Purchase Document", 'OnAfterReleasePurchaseDoc', '', true, true)]
    local procedure HandleVATNVXReleasePurchaseDocument(var PurchaseHeader: Record "Purchase Header"; PreviewMode: Boolean; LinesWereModified: Boolean)
    var
        PurchaseLineNVX: Record PurchaseLineNVX;
    begin
        PurchaseLineNVX.HandleVATDifferenceNVX(PurchaseHeader);
    end;
}
