codeunit 50009 "SkipTypeChecksNVX"
{
    //Sales
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforeOnRun', '', false, false)]
    local procedure SetSkipTypeCheckSalesShipment(var SkipTypeCheck: Boolean)
    begin
        SkipTypeCheck := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforeCheckSalesShptLine', '', false, false)]
    local procedure SkipTypeCheckSalesShipment(SalesShipmentLine: Record "Sales Shipment Line"; var SkipTestFields: Boolean; var SkipUndoPosting: Boolean)
    var
        AlreadyInvoicedErr: Label 'This shipment has already been invoiced. Undo Shipment can be applied only to posted, but not invoiced shipments.', comment = 'DEA="Dieser Warenausgang wurde bereits fakturiert. ''Warenausgang stornieren'' kann nur auf gebuchte, aber nicht auf fakturierte Warenausgänge angewendet werden."';
        AlreadyReversedErr: Label 'This shipment has already been reversed', comment = 'DEA="Diese Lieferung wurde bereits storniert."';
    begin
        if SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then begin
            SkipTestFields := true;
            SkipUndoPosting := true;
            if SalesShipmentLine.Correction then
                Error(AlreadyReversedErr);
            if SalesShipmentLine."Qty. Shipped Not Invoiced" <> SalesShipmentLine.Quantity then
                Error(AlreadyInvoicedErr);
            SalesShipmentLine.TestField("Drop Shipment", false);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforePostItemJnlLine', '', false, false)]
    local procedure SkipPostItemJnlSalesShipment(var SalesShipmentLine: Record "Sales Shipment Line"; var IsHandled: Boolean)
    begin
        if SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then //no other types allowed anyway
            IsHandled := true;
    end;

    //Purchase
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeOnRun', '', false, false)]
    local procedure SetSkipTypeCheckPurchaseReceipt(var SkipTypeCheck: Boolean)
    begin
        SkipTypeCheck := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCheckPurchRcptLine', '', false, false)]
    local procedure SkipTypeCheckPurchaseReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean)
    var
        AlreadyInvoicedErr: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.', comment = 'DEA="Dieser Wareneingang wurde bereits fakturiert. ''Wareneingang stornieren'' kann nur auf gebuchte, aber nicht auf fakturierte Wareneingänge angewendet werden."';
        AlreadyReversedErr: Label 'This shipment has already been reversed', comment = 'DEA="Diese Lieferung wurde bereits storniert."';
    begin
        if PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then begin
            if PurchRcptLine.Correction then
                Error(AlreadyReversedErr);
            if PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity then
                Error(AlreadyInvoicedErr);
            PurchRcptLine.TestField("Prod. Order No.", '');
            PurchRcptLine.TestField("Sales Order No.", '');
            PurchRcptLine.TestField("Sales Order Line No.", 0);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforePostItemJnlLine', '', false, false)]
    local procedure SkipPostItemJnlPurchaseReceipt(var PurchRcptLine: Record "Purch. Rcpt. Line"; var IsHandled: Boolean)
    begin
        if PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then //no other types allowed anyway
            IsHandled := true;
    end;
}