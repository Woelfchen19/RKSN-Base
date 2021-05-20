codeunit 50011 SkipTypeChecksNVX
{

    //Sales

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforeOnRun', '', false, false)]
    local procedure SetSkipTypeCheckSalesShipment(VAR SkipTypeCheck : Boolean)
    begin
        SkipTypeCheck := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforeCheckSalesShptLine', '', false, false)]
    local procedure SkipTypeCheckSalesShipment(SalesShipmentLine: Record "Sales Shipment Line"; VAR SkipTestFields : Boolean;VAR  SkipUndoPosting : Boolean)
    var
        AlreadyReversedErr: Label 'This shipment has already been reversed', comment = 'DEA="Diese Lieferung wurde bereits storniert."';
        AlreadyInvoicedErr: Label 'This shipment has already been invoiced. Undo Shipment can be applied only to posted, but not invoiced shipments.', comment = 'DEA="Dieser Warenausgang wurde bereits fakturiert. ''Warenausgang stornieren'' kann nur auf gebuchte, aber nicht auf fakturierte Warenausgänge angewendet werden."';
    begin
        IF SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then begin
            SkipTestFields := true;
            SkipUndoPosting := true;
            IF SalesShipmentLine.Correction THEN
                ERROR(AlreadyReversedErr);
            IF SalesShipmentLine."Qty. Shipped Not Invoiced" <> SalesShipmentLine.Quantity THEN
                ERROR(AlreadyInvoicedErr);
            SalesShipmentLine.TESTFIELD("Drop Shipment",FALSE);
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Sales Shipment Line", 'OnBeforePostItemJnlLine', '', false, false)]
    local procedure SkipPostItemJnlSalesShipment(VAR SalesShipmentLine : Record "Sales Shipment Line";VAR IsHandled : Boolean)
    begin
        IF SalesShipmentLine.Type = SalesShipmentLine.Type::"G/L Account" then //no other types allowed anyway
            IsHandled := true;
    end;



    //Purchase

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeOnRun', '', false, false)]
    local procedure SetSkipTypeCheckPurchaseReceipt(VAR SkipTypeCheck : Boolean)
    begin
        SkipTypeCheck := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforeCheckPurchRcptLine', '', false, false)]
    local procedure SkipTypeCheckPurchaseReceipt(VAR PurchRcptLine : Record "Purch. Rcpt. Line"; VAR IsHandled : Boolean)
    var
        AlreadyReversedErr: Label 'This shipment has already been reversed', comment = 'DEA="Diese Lieferung wurde bereits storniert."';
        AlreadyInvoicedErr: Label 'This receipt has already been invoiced. Undo Receipt can be applied only to posted, but not invoiced receipts.', comment = 'DEA="Dieser Wareneingang wurde bereits fakturiert. ''Wareneingang stornieren'' kann nur auf gebuchte, aber nicht auf fakturierte Wareneingänge angewendet werden."';
    begin
        IF PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then begin
            IF PurchRcptLine.Correction THEN
                ERROR(AlreadyReversedErr);
            IF PurchRcptLine."Qty. Rcd. Not Invoiced" <> PurchRcptLine.Quantity THEN
                ERROR(AlreadyInvoicedErr);
            PurchRcptLine.TESTFIELD("Prod. Order No.",'');
            PurchRcptLine.TESTFIELD("Sales Order No.",'');
            PurchRcptLine.TESTFIELD("Sales Order Line No.",0);
        end;
        IsHandled := true;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Undo Purchase Receipt Line", 'OnBeforePostItemJnlLine', '', false, false)]
    local procedure SkipPostItemJnlPurchaseReceipt(VAR PurchRcptLine : Record "Purch. Rcpt. Line";VAR IsHandled : Boolean)
    begin
        IF PurchRcptLine.Type = PurchRcptLine.Type::"G/L Account" then //no other types allowed anyway
            IsHandled := true;
    end;
}