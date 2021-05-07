codeunit 50009 "Codeunit80HookNVX"
{
    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesInvHeaderInsert', '', false, false)]
    // local procedure TransferRecToPstdAccompaniedTableInvoice(SalesInvHeader: Record "Sales Invoice Header"; SalesHeader: Record "Sales Header")
    // var
    //     SalesHeaderNVX: Record SalesHeaderNVX;
    //     SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;
    // begin
    //     IF SalesHeaderNVX.get(SalesHeader."Document Type", SalesHeader."No.") then begin
    //         SalesInvoiceHeaderNVX.Init();
    //         SalesInvoiceHeaderNVX.TransferFields(SalesHeaderNVX);
    //         SalesInvoiceHeaderNVX."No." := SalesInvHeader."No.";
    //         SalesInvoiceHeaderNVX.Insert();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterSalesCrMemoHeaderInsert', '', false, false)]
    // local procedure TransferRecToPstdAccompaniedTableCrMemo(SalesCrMemoHeader: Record "Sales Cr.Memo Header"; SalesHeader: Record "Sales Header")
    // var
    //     SalesHeaderNVX: Record SalesHeaderNVX;
    //     SalesCrMemoHeaderNVX: Record SalesCrMemoHeaderNVX;
    // begin
    //     IF SalesHeaderNVX.get(SalesHeader."Document Type", SalesHeader."No.") then begin
    //         SalesCrMemoHeaderNVX.Init();
    //         SalesCrMemoHeaderNVX.TransferFields(SalesHeaderNVX);
    //         SalesCrMemoHeaderNVX."No." := SalesCrMemoHeader."No.";
    //         SalesCrMemoHeaderNVX.Insert();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeSalesShptHeaderInsert', '', false, false)]
    // local procedure TransferRecToPstdAccompaniedTableShip(SalesShptHeader: Record "Sales Shipment Header"; SalesHeader: Record "Sales Header")
    // var
    //     SalesHeaderNVX: Record SalesHeaderNVX;
    //     PstdDocInfo: Record PstdDocInfoNVX;
    // begin
    //     IF DocInfo.get(DocInfo.Department::Sales, SalesHeader."Document Type", SalesHeader."No.") then begin
    //         PstdDocInfo.Init();
    //         PstdDocInfo.TransferFields(DocInfo);
    //         PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::Shipment;
    //         PstdDocInfo."Document No." := SalesShptHeader."No.";
    //         PstdDocInfo.Insert();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeReturnRcptHeaderInsert', '', false, false)]
    // local procedure TransferRecToPstdAccompaniedTableReturn(ReturnRcptHeader: Record "Return Receipt Header"; SalesHeader: Record "Sales Header")
    // var
    //     SalesHeaderNVX: Record SalesHeaderNVX;
    //     PstdDocInfo: Record PstdDocInfoNVX;
    // begin
    //     IF DocInfo.get(DocInfo.Department::Sales, SalesHeader."Document Type", SalesHeader."No.") then begin
    //         PstdDocInfo.Init();
    //         PstdDocInfo.TransferFields(DocInfo);
    //         PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::"Return Receipt";
    //         PstdDocInfo."Document No." := ReturnRcptHeader."No.";
    //         PstdDocInfo.Insert();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostInvPostBuffer', '', false, false)]
    // local procedure InsertRecInAccompaniedLedgerTable(VAR SalesHeader : Record "Sales Header"; GLEntryNo : Integer)
    // var
    //     DocInfo: Record DocInfoNVX;
    //     GLEntryNVX: Record GLEntryNVX;
    // begin
    //     IF DocInfo.get(DocInfo.Department::Sales, SalesHeader."Document Type", SalesHeader."No.") then begin
    //         GLEntryNVX.Init();
    //         GLEntryNVX."Entry No." := GLEntryNo;
    //         GLEntryNVX."SShortcut Dimension 1 Code" := DocInfo."Shortcut Dimension 1 Code";
    //         GLEntryNVX."SShortcut Dimension 3 Code" := DocInfo."Shortcut Dimension 3 Code";
    //         GLEntryNVX."Interim Gen.Bus.Posting Group" := DocInfo."Interim Gen.Bus.Posting Group";
    //         GLEntryNVX.Insert();
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnAfterPostSalesDoc', '', false, false)]
    // local procedure InsertRecInAccompaniedLedgerTable(VAR SalesHeader : Record "Sales Header";SalesInvHdrNo : Code[20];SalesCrMemoHdrNo : Code[20])
    // var
    //     PstdDocInfo: Record PstdDocInfoNVX;
    //     GLEntryNVX: Record GLEntryNVX;
    //     GLEntry: Record "G/L Entry";
    // begin
    //     case true of

    //         (SalesInvHdrNo <> ''):
    //         begin
    //             IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::Invoice, SalesInvHdrNo) then begin
    //                 GLEntry.SetRange("Document Type",GLEntry."Document Type"::Invoice);
    //                 GLEntry.SetRange("Document No.",SalesInvHdrNo);
    //                 IF GLEntry.FindSet then repeat

    //                     If not GLEntryNVX.get(GLEntry."Entry No.") then begin
    //                         GLEntryNVX.Init();
    //                         GLEntryNVX."Entry No." := GLEntry."Entry No.";
    //                         // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
    //                         // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
    //                         GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
    //                         GLEntryNVX.Insert();
    //                     end else begin
    //                         // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
    //                         // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
    //                         GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
    //                         GLEntryNVX.Modify();
    //                     end;

    //                 until GLEntry.Next() = 0;
    //             end;
    //         end;

    //         (SalesCrMemoHdrNo <> ''):
    //         begin
    //             IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::"Credit Memo", SalesCrMemoHdrNo) then begin
    //                 GLEntry.SetRange("Document Type",GLEntry."Document Type"::"Credit Memo");
    //                 GLEntry.SetRange("Document No.",SalesCrMemoHdrNo);
    //                 IF GLEntry.FindSet() then repeat

    //                     If not GLEntryNVX.get(GLEntry."Entry No.") then begin
    //                         GLEntryNVX.Init();
    //                         GLEntryNVX."Entry No." := GLEntry."Entry No.";
    //                         // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
    //                         // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
    //                         GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
    //                         GLEntryNVX.Insert();
    //                     end else begin
    //                         // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
    //                         // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
    //                         GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
    //                         GLEntryNVX.Modify();
    //                     end;

    //                 until GLEntry.Next() = 0;                    
    //             end;
    //         end;
            
    //     end; //of case
    // end;


    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforeTestGBPG', '', false, false)]
    local procedure SkipGBPGTestfield(var IsHandled: Boolean)
    begin
        IsHandled := true;
    end;
}