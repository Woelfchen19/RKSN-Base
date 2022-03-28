codeunit 50004 Codeunit6620HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesDocWithHeader', '', false, false)]
    local procedure CopyDocInfoSales(FromDocType: Option; FromDocNo: Code[20]; var ToSalesHeader: Record "Sales Header")
    var
        SalesCrMemoHeaderNVX: Record SalesCrMemoHeaderNVX;
        NewSalesHeaderNVX: Record SalesHeaderNVX;
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;
        CopyDocMgt: Codeunit "Copy Document Mgt.";
        SalesDocType: Option Quote,"Blanket Order",Order,Invoice,"Return Order","Credit Memo","Posted Shipment","Posted Invoice","Posted Return Receipt","Posted Credit Memo","Arch. Quote","Arch. Order","Arch. Blanket Order","Arch. Return Order";
    begin
        case FromDocType of
            SalesDocType::Quote,
        SalesDocType::"Blanket Order",
        SalesDocType::Order,
        SalesDocType::Invoice,
        SalesDocType::"Return Order",
        SalesDocType::"Credit Memo":

                if SalesHeaderNVX.Get(CopyDocMgt.SalesHeaderDocType(FromDocType), FromDocNo) then
                    if not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type", ToSalesHeader."No.") then begin
                        NewSalesHeaderNVX.Init();
                        NewSalesHeaderNVX.TransferFields(SalesHeaderNVX);
                        NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                        NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                        NewSalesHeaderNVX.Insert();
                    end;


            SalesDocType::"Posted Invoice":

                if SalesInvoiceHeaderNVX.Get(FromDocNo) then
                    if not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type", ToSalesHeader."No.") then begin
                        NewSalesHeaderNVX.Init();
                        NewSalesHeaderNVX.TransferFields(SalesInvoiceHeaderNVX);
                        NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                        NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                        NewSalesHeaderNVX.Insert();
                    end;


            SalesDocType::"Posted Credit Memo":

                if SalesCrMemoHeaderNVX.Get(FromDocNo) then
                    if not NewSalesHeaderNVX.Get(ToSalesHeader."Document Type", ToSalesHeader."No.") then begin
                        NewSalesHeaderNVX.Init();
                        NewSalesHeaderNVX.TransferFields(SalesCrMemoHeaderNVX);
                        NewSalesHeaderNVX."Document Type" := ToSalesHeader."Document Type";
                        NewSalesHeaderNVX."No." := ToSalesHeader."No.";
                        NewSalesHeaderNVX.Insert();
                    end;
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnCopySalesLineOnBeforeCheckVATBusGroup', '', false, false)]
    local procedure SkipVatBusGroupCheck(var CheckVATBusGroup: Boolean)
    begin
        CheckVATBusGroup := false;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Copy Document Mgt.", 'OnBeforeCopySalesDocForInvoiceCancelling', '', false, false)]
    local procedure CopyTransactionNoToCreditMemo(var ToSalesHeader: Record "Sales Header"; FromDocNo: Code[20])
    var
        SalesHeaderNVX: Record SalesHeaderNVX;
        SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;
    begin
        if not SalesInvoiceHeaderNVX.Get(FromDocNo) then
            exit;

        if ToSalesHeader."Document Type" <> ToSalesHeader."Document Type"::"Credit Memo" then
            exit;

        if not SalesHeaderNVX.Get(ToSalesHeader."Document Type", ToSalesHeader."No.") then begin
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