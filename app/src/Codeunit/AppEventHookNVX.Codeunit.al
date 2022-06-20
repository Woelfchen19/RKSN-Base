codeunit 50014 "AppEventHookNVX"
{
    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityGeneralJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"General Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityItemJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Item Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purchase Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Cash Receipt Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityCashReceiptJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Cash Receipt Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Payment Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPaymentJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Payment Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Recurring General Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityRecurringGeneralJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Recurring General Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesOrderSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Order Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Invoice SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesInvoiceSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Invoice Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseOrderSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purchase Order Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purch. Invoice SubForm", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchInvoiceSubForm(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purch. Invoice Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesQuoteSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Quote Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Cr. Memo Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesCrMemoSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Cr. Memo Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseQuoteSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purchase Quote Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purch. Cr. Memo Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchCrMemoSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purch. Cr. Memo Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Shpt. Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedSalesShptSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Sales Shpt. Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Invoice Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedSalesInvoiceSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Sales Invoice Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Sales Cr. Memo Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedSalesCrMemoSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Sales Cr. Memo Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Purchase Rcpt. Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedPurchaseRcptSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Purchase Rcpt. Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Purch. Invoice Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedPurchInvoiceSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Purch. Invoice Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Posted Purch. Cr. Memo Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPostedPurchCrMemoSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Posted Purch. Cr. Memo Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Standard Sales Code Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityStandardSalesCodeSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Standard Sales Code Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Standard Purchase Code Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityStandardPurchaseCodeSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Standard Purchase Code Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Sales Order Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityBlanketSalesOrderSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Blanket Sales Order Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Blanket Purchase Order Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityBlanketPurchaseOrderSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Blanket Purchase Order Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Order Archive Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesOrderArchiveSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Order Archive Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Quote Archive Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesQuoteArchiveSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Sales Quote Archive Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Quote Archive Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseQuoteArchiveSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purchase Quote Archive Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Order Archive Subform", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseOrderArchiveSubform(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"Purchase Order Archive Subform", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Sales Lines", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilitySalesLines(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
         var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Sales Lines", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Requisition Lines", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityRequisitionLines(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
         var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Requisition Lines", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Purchase Lines", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityPurchaseLines(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
         var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Purchase Lines", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    [EventSubscriber(ObjectType::Page, Page::"Item Journal Lines", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityItemJournalLines(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
         var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean
    )
    begin
        SetDimensionsVisibility(Page::"Item Journal Lines", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
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

    [EventSubscriber(ObjectType::Table, Database::"Cust. Ledger Entry", 'OnBeforeModifyEvent', '', true, true)]
    local procedure OnBeforeModifyEvent(var Rec: Record "Cust. Ledger Entry"; var xRec: Record "Cust. Ledger Entry"; RunTrigger: Boolean)
    var
        ChangeLogMgtDimension: Codeunit ChangeLogMgtDimensionNVX;
        RecRef: RecordRef;
    begin
        RecRef.GetTable(Rec);
        ChangeLogMgtDimension.LogModification(RecRef);
        RecRef.Close();
    end;
}