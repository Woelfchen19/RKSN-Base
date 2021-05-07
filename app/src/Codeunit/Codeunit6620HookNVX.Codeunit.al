codeunit 50013 "Codeunit6620HookNVX"
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocWithHeader', '', false, false)]
    local procedure CopyDocInfoSales(FromDocType: Option; FromDocNo: Code[20]; VAR ToSalesHeader: Record "Sales Header")
    var
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
        
            IF SalesHeaderNVX.get(CopyDocMgt.SalesHeaderDocType(FromDocType), FromDocNo) then begin
                If not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type",ToSalesHeader."No.") then begin
                    NewSalesHeaderNVX.Init();
                    NewSalesHeaderNVX.TransferFields(SalesHeaderNVX);
                    NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                    NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                    NewSalesHeaderNVX.Insert();
                end;
            end;
        

        SalesDocType::"Posted Invoice" :
        
            IF SalesInvoiceHeaderNVX.get(FromDocNo) then begin
                If not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type",ToSalesHeader."No.") then begin
                    NewSalesHeaderNVX.Init();
                    NewSalesHeaderNVX.TransferFields(SalesInvoiceHeaderNVX);
                    NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                    NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                    NewSalesHeaderNVX.Insert();
                end;
            end;

        SalesDocType::"Posted Credit Memo" :
        
            IF SalesCrMemoHeaderNVX.get(FromDocNo) then begin
                If not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type",ToSalesHeader."No.") then begin
                    NewSalesHeaderNVX.Init();
                    NewSalesHeaderNVX.TransferFields(SalesCrMemoHeaderNVX);
                    NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                    NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                    NewSalesHeaderNVX.Insert();
                end;
            end;
        

        END;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesLineOnBeforeCheckVATBusGroup', '', false, false)]
    local procedure SkipVatBusGroupCheck(VAR CheckVATBusGroup : Boolean)
    begin
        CheckVATBusGroup := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesDocForInvoiceCancelling', '', false, false)]
    local procedure CopyTransactionNoToCreditMemo(VAR ToSalesHeader : Record "Sales Header";FromDocNo : Code[20])
    var
        SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
    begin
        IF not SalesInvoiceHeaderNVX.Get(FromDocNo) then
            exit;
        
        If ToSalesHeader."Document Type" <> ToSalesHeader."Document Type"::"Credit Memo" then
            exit;

        If not SalesHeaderNVX.Get(ToSalesHeader."Document Type",ToSalesHeader."No.") then begin
            SalesHeaderNVX.Init();
            SalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
            SalesHeaderNVX."No." := ToSalesHeader."No.";
            SalesHeaderNVX."Transaction No." := SalesInvoiceHeaderNVX."Transaction No.";
            SalesHeaderNVX.DoNotSplit := true;
            SalesHeaderNVX.Insert();
        end else begin
            SalesHeaderNVX."Transaction No." := SalesInvoiceHeaderNVX."Transaction No.";
            SalesHeaderNVX.DoNotSplit := true;
            SalesHeaderNVX.Modify();
        end;
    end;
}