codeunit 50014 "AppEventHookNVX"
{
    [EventSubscriber(ObjectType::Page, Page::"Sales Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Sales Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Purchase Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Cash Receipt Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityCashReceiptJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Cash Receipt Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPaymentJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
   )

    begin
        SetDimensionsVisibility(Page::"Payment Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesOrderSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
   )

    begin
        SetDimensionsVisibility(Page::"Payment Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesInvoiceSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
   )
    begin
        SetDimensionsVisibility(Page::"Payment Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    local procedure SetDimensionsVisibility(
        PageID: Integer;
         var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean; var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(PageID);

        AppMgt.GetFieldsPropertyVisibleEditableBySetup(Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible,
            Dimension1Editable, Dimension2Editable, Dimension3Editable, Dimension4Editable, Dimension5Editable,
            Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable);
    end;
}