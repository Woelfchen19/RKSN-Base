codeunit 50010 Codeunit90HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvHeaderInsert', '', false, false)]
    local procedure TransferRecToPstdAccompaniedTableInvoice(PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
    var
        DocInfo: Record DocInfoNVX;
        PstdDocInfo: Record PstdDocInfoNVX;
    begin
        IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
            PstdDocInfo.Init();
            PstdDocInfo.TransferFields(DocInfo);
            PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::Invoice;
            PstdDocInfo."Document No." := PurchInvHeader."No.";
            PstdDocInfo.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoHeaderInsert', '', false, false)]
    local procedure TransferRecToPstdAccompaniedTableCrMemo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header")
    var
        DocInfo: Record DocInfoNVX;
        PstdDocInfo: Record PstdDocInfoNVX;
    begin
        IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
            PstdDocInfo.Init();
            PstdDocInfo.TransferFields(DocInfo);
            PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::"Credit Memo";
            PstdDocInfo."Document No." := PurchCrMemoHdr."No.";
            PstdDocInfo.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', false, false)]
    local procedure TransferRecToPstdAccompaniedTableShip(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchaseHeader: Record "Purchase Header")
    var
        DocInfo: Record DocInfoNVX;
        PstdDocInfo: Record PstdDocInfoNVX;
    begin
        IF DocInfo.get(DocInfo.Department::Purchase,PurchaseHeader."Document Type",PurchaseHeader."No.") then begin
            PstdDocInfo.Init();
            PstdDocInfo.TransferFields(DocInfo);
            PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::Shipment;
            PstdDocInfo."Document No." := PurchRcptHeader."No.";
            PstdDocInfo.Insert();
        end;
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterReturnShptHeaderInsert', '', false, false)]
    local procedure TransferRecToPstdAccompaniedTableReturn(ReturnShptHeader: Record "Return Shipment Header"; PurchHeader: Record "Purchase Header")
    var
        DocInfo: Record DocInfoNVX;
        PstdDocInfo: Record PstdDocInfoNVX;
    begin
        IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
            PstdDocInfo.Init();
            PstdDocInfo.TransferFields(DocInfo);
            PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::"Return Receipt";
            PstdDocInfo."Document No." := ReturnShptHeader."No.";
            PstdDocInfo.Insert();
        end;
    end;

    //TODO Posted Doc Info in GL Entry mitnehmen --> siehe cu80 hook InsertRecInAccompaniedLedgerTable
}