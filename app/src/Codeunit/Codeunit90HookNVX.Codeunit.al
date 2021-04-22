// codeunit 50010 Codeunit90HookNVX
// {
//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchInvHeaderInsert', '', false, false)]
//     local procedure TransferRecToPstdAccompaniedTableInvoice(PurchInvHeader: Record "Purch. Inv. Header"; PurchHeader: Record "Purchase Header")
//     var
//         DocInfo: Record DocInfoNVX;
//         PstdDocInfo: Record PstdDocInfoNVX;
//     begin
//         IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
//             PstdDocInfo.Init();
//             PstdDocInfo.TransferFields(DocInfo);
//             PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::Invoice;
//             PstdDocInfo."Document No." := PurchInvHeader."No.";
//             PstdDocInfo.Insert();
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchCrMemoHeaderInsert', '', false, false)]
//     local procedure TransferRecToPstdAccompaniedTableCrMemo(PurchCrMemoHdr: Record "Purch. Cr. Memo Hdr."; PurchHeader: Record "Purchase Header")
//     var
//         DocInfo: Record DocInfoNVX;
//         PstdDocInfo: Record PstdDocInfoNVX;
//     begin
//         IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
//             PstdDocInfo.Init();
//             PstdDocInfo.TransferFields(DocInfo);
//             PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::"Credit Memo";
//             PstdDocInfo."Document No." := PurchCrMemoHdr."No.";
//             PstdDocInfo.Insert();
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPurchRcptHeaderInsert', '', false, false)]
//     local procedure TransferRecToPstdAccompaniedTableShip(PurchRcptHeader: Record "Purch. Rcpt. Header"; PurchaseHeader: Record "Purchase Header")
//     var
//         DocInfo: Record DocInfoNVX;
//         PstdDocInfo: Record PstdDocInfoNVX;
//     begin
//         IF DocInfo.get(DocInfo.Department::Purchase,PurchaseHeader."Document Type",PurchaseHeader."No.") then begin
//             PstdDocInfo.Init();
//             PstdDocInfo.TransferFields(DocInfo);
//             PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::Shipment;
//             PstdDocInfo."Document No." := PurchRcptHeader."No.";
//             PstdDocInfo.Insert();
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterReturnShptHeaderInsert', '', false, false)]
//     local procedure TransferRecToPstdAccompaniedTableReturn(ReturnShptHeader: Record "Return Shipment Header"; PurchHeader: Record "Purchase Header")
//     var
//         DocInfo: Record DocInfoNVX;
//         PstdDocInfo: Record PstdDocInfoNVX;
//     begin
//         IF DocInfo.get(DocInfo.Department::Purchase,PurchHeader."Document Type",PurchHeader."No.") then begin
//             PstdDocInfo.Init();
//             PstdDocInfo.TransferFields(DocInfo);
//             PstdDocInfo."Document Type" := PstdDocInfo."Document Type"::"Return Receipt";
//             PstdDocInfo."Document No." := ReturnShptHeader."No.";
//             PstdDocInfo.Insert();
//         end;
//     end;

//     [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnAfterPostPurchaseDoc', '', false, false)]
//     local procedure InsertRecInAccompaniedLedgerTable(VAR PurchaseHeader : Record "Purchase Header";PurchInvHdrNo : Code[20];PurchCrMemoHdrNo : Code[20])
//     var
//         PstdDocInfo: Record PstdDocInfoNVX;
//         GLEntryNVX: Record GLEntryNVX;
//         GLEntry: Record "G/L Entry";
//     begin
//         case true of

//             (PurchInvHdrNo <> ''):
//             begin
//                 IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::Invoice, PurchInvHdrNo) then begin
//                     GLEntry.SetRange("Document Type",GLEntry."Document Type"::Invoice);
//                     GLEntry.SetRange("Document No.",PurchInvHdrNo);
//                     IF GLEntry.FindSet then repeat

//                         If not GLEntryNVX.get(GLEntry."Entry No.") then begin
//                             GLEntryNVX.Init();
//                             GLEntryNVX."Entry No." := GLEntry."Entry No.";
//                             // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
//                             // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
//                             GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
//                             GLEntryNVX.Insert();
//                         end else begin
//                             // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
//                             // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
//                             GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
//                             GLEntryNVX.Modify();
//                         end;

//                     until GLEntry.Next() = 0;
//                 end;
//             end;

//             (PurchCrMemoHdrNo <> ''):
//             begin
//                 IF PstdDocInfo.get(PstdDocInfo.Department::Sales, PstdDocInfo."Document Type"::"Credit Memo", PurchCrMemoHdrNo) then begin
//                     GLEntry.SetRange("Document Type",GLEntry."Document Type"::"Credit Memo");
//                     GLEntry.SetRange("Document No.",PurchCrMemoHdrNo);
//                     IF GLEntry.FindSet() then repeat

//                         If not GLEntryNVX.get(GLEntry."Entry No.") then begin
//                             GLEntryNVX.Init();
//                             GLEntryNVX."Entry No." := GLEntry."Entry No.";
//                             // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
//                             // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
//                             GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
//                             GLEntryNVX.Insert();
//                         end else begin
//                             // GLEntryNVX."SShortcut Dimension 1 Code" := PstdDocInfo."Shortcut Dimension 1 Code";
//                             // GLEntryNVX."SShortcut Dimension 3 Code" := PstdDocInfo."Shortcut Dimension 3 Code";
//                             GLEntryNVX."Interim Gen.Bus.Posting Group" := PstdDocInfo."Interim Gen.Bus.Posting Group";
//                             GLEntryNVX.Modify();
//                         end;

//                     until GLEntry.Next() = 0;                    
//                 end;
//             end;
            
//         end; //of case
//     end;
// }