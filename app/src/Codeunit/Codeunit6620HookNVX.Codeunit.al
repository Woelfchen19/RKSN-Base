codeunit 50013 Codeunit6620HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocWithHeader', '', false, false)]
    local procedure CopyDocInfoSales(FromDocType: Option; FromDocNo: Code[20]; VAR ToSalesHeader: Record "Sales Header")
    var
        // DocInfo: Record DocInfoNVX;
        // NewDocInfo: Record DocInfoNVX;
        // PstdDocInfo: Record PstdDocInfoNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
        NewSalesHeaderNVX: Record SalesHeaderNVX;
        SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;
        SalesCrMemoHeaderNVX: Record SalesCrMemoHeaderNVX;
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        SalesDocType: Option Quote, "Blanket Order", Order, Invoice, "Return Order", "Credit Memo", "Posted Shipment", "Posted Invoice", "Posted Return Receipt", "Posted Credit Memo", "Arch. Quote", "Arch. Order", "Arch. Blanket Order", "Arch. Return Order";
    begin
        CASE FromDocType OF
        SalesDocType::Quote,
        SalesDocType::"Blanket Order",
        SalesDocType::Order,
        SalesDocType::Invoice,
        SalesDocType::"Return Order",
        SalesDocType::"Credit Memo" :
        BEGIN
            IF SalesHeaderNVX.get(CopyDocMgt.SalesHeaderDocType(FromDocType), FromDocNo) then begin
                NewSalesHeaderNVX.Init();
                NewSalesHeaderNVX.TransferFields(SalesHeaderNVX);
                NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                NewSalesHeaderNVX.Insert();
            end;
        END;
        // SalesDocType::"Posted Shipment" :
        // BEGIN
        //     IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::Shipment, FromDocNo) then begin
        //         NewDocInfo.Init();
        //         NewDocInfo.TransferFields(PstdDocInfo);
        //         NewDocInfo."Document Type" := ToSalesHeader."Document Type";
        //         NewDocInfo."Document No." := ToSalesHeader."No.";
        //         NewDocInfo.Insert();
        //     end;
        // END;
        SalesDocType::"Posted Invoice" :
        BEGIN
            IF SalesInvoiceHeaderNVX.get(FromDocNo) then begin
                NewSalesHeaderNVX.Init();
                NewSalesHeaderNVX.TransferFields(SalesInvoiceHeaderNVX);
                NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                NewSalesHeaderNVX.Insert();
            end;
        END;
        // SalesDocType::"Posted Return Receipt" :
        // BEGIN
        //     IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::"Return Receipt", FromDocNo) then begin
        //         NewDocInfo.Init();
        //         NewDocInfo.TransferFields(PstdDocInfo);
        //         NewDocInfo."Document Type" := ToSalesHeader."Document Type";
        //         NewDocInfo."Document No." := ToSalesHeader."No.";
        //         NewDocInfo.Insert();
        //     end;
        // END;
        SalesDocType::"Posted Credit Memo" :
        BEGIN
            IF SalesCrMemoHeaderNVX.get(FromDocNo) then begin
                NewSalesHeaderNVX.Init();
                NewSalesHeaderNVX.TransferFields(SalesCrMemoHeaderNVX);
                NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                NewSalesHeaderNVX.Insert();
            end;
        END;

        END;
    end;


    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"copy document Mgt.", 'OnAfterCopyPurchaseDocument', '', false, false)]
    // local procedure CopyDocInfoPurchase(FromDocumentType: Option; FromDocumentNo: Code[20]; VAR ToPurchaseHeader: Record "Purchase Header"; IncludeHeader: Boolean)
    // var
    //     // DocInfo: Record DocInfoNVX;
    //     // NewDocInfo: Record DocInfoNVX;
    //     // PstdDocInfo: Record PstdDocInfoNVX;
    //     PurchaseHeaderNVX: Record PurchaseHeaderNVX;
    //     NewPurchaseHeaderNVX: Record PurchaseHeaderNVX;

    //     CopyDocMgt: Codeunit "Copy Document Mgt.";
    //     PurchDocType: Option Quote, "Blanket Order", Order, Invoice, "Return Order", "Credit Memo", "Posted Receipt", "Posted Invoice", "Posted Return Shipment", "Posted Credit Memo", "Arch. Quote", "Arch. Order", "Arch. Blanket Order", "Arch. Return Order";
    // begin
    //     CASE FromDocumentType OF
    //     PurchDocType::Quote,
    //     PurchDocType::"Blanket Order",
    //     PurchDocType::Order,
    //     PurchDocType::Invoice,
    //     PurchDocType::"Return Order",
    //     PurchDocType::"Credit Memo" :
    //     BEGIN
    //         IF DocInfo.get(DocInfo.Department::Purchase, CopyDocMgt.PurchHeaderDocType(FromDocumentType), FromDocumentNo) then begin
    //             NewDocInfo.Init();
    //             NewDocInfo.TransferFields(DocInfo);
    //             NewDocInfo."Document Type" := ToPurchaseHeader."Document Type";
    //             NewDocInfo."Document No." := ToPurchaseHeader."No.";
    //             NewDocInfo.Insert();
    //         end;
    //     END;
    //     PurchDocType::"Posted Receipt" :
    //     BEGIN
    //         IF PstdDocInfo.get(PstdDocInfo.Department::Purchase, PstdDocInfo."Document Type"::Shipment, FromDocumentNo) then begin
    //             NewDocInfo.Init();
    //             NewDocInfo.TransferFields(PstdDocInfo);
    //             NewDocInfo."Document Type" := ToPurchaseHeader."Document Type";
    //             NewDocInfo."Document No." := ToPurchaseHeader."No.";
    //             NewDocInfo.Insert();
    //         end;
    //     END;
    //     PurchDocType::"Posted Invoice" :
    //     BEGIN
    //         IF PstdDocInfo.get(PstdDocInfo.Department::Purchase, PstdDocInfo."Document Type"::Invoice, FromDocumentNo) then begin
    //             NewDocInfo.Init();
    //             NewDocInfo.TransferFields(PstdDocInfo);
    //             NewDocInfo."Document Type" := ToPurchaseHeader."Document Type";
    //             NewDocInfo."Document No." := ToPurchaseHeader."No.";
    //             NewDocInfo.Insert();
    //         end;
    //     END;
    //     PurchDocType::"Posted Return Shipment" :
    //     BEGIN
    //         IF PstdDocInfo.get(PstdDocInfo.Department::Purchase, PstdDocInfo."Document Type"::"Return Receipt", FromDocumentNo) then begin
    //             NewDocInfo.Init();
    //             NewDocInfo.TransferFields(PstdDocInfo);
    //             NewDocInfo."Document Type" := ToPurchaseHeader."Document Type";
    //             NewDocInfo."Document No." := ToPurchaseHeader."No.";
    //             NewDocInfo.Insert();
    //         end;
    //     END;
    //     PurchDocType::"Posted Credit Memo" :
    //     BEGIN
    //         IF PstdDocInfo.get(PstdDocInfo.Department::Purchase, PstdDocInfo."Document Type"::"Credit Memo", FromDocumentNo) then begin
    //             NewDocInfo.Init();
    //             NewDocInfo.TransferFields(PstdDocInfo);
    //             NewDocInfo."Document Type" := ToPurchaseHeader."Document Type";
    //             NewDocInfo."Document No." := ToPurchaseHeader."No.";
    //             NewDocInfo.Insert();
    //         end;
    //     END;

    //     END;
    // end;
}