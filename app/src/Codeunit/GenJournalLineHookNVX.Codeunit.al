codeunit 50021 GenJournalLineHookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDim(var Rec: Record "Gen. Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAsset: Record "Fixed Asset";
        WrongDim2Err: Label 'Profitcenter and Allocation code must match the configuration in the specified Fixed Asset.',
                    comment = 'DEA="Ihre Angaben zur Erfassungszeile sind zur Anlagenkarte, betreffend Profitcenter bzw. Verteilungscode, nicht identisch. Überprüfen Sie gegebenenfalls ihre Stammdaten!"';
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if ((Rec."Account Type" in [Rec."Account Type"::"Fixed Asset", Rec."Account Type"::"G/L Account"]) and (Rec."Account No." <> '')) or
            ((Rec."Bal. Account Type" in [Rec."Bal. Account Type"::"Fixed Asset", Rec."Bal. Account Type"::"G/L Account"]) and
            (Rec."Bal. Account No." <> ''))
        then begin
            if Rec.AllocCodeNVX <> '' then begin
                AllocationCode.Get(Rec.AllocCodeNVX);
                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);
            end;

            if (Rec."Account Type" = Rec."Account Type"::"Fixed Asset") and (Rec."Account No." <> '') then
                if FixedAsset.Get(Rec."Account No.") and (FixedAsset."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code") then
                    Error(WrongDim2Err);

            if (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Fixed Asset") and (Rec."Bal. Account No." <> '') then
                if FixedAsset.Get(Rec."Bal. Account No.") and (FixedAsset."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code") then
                    Error(WrongDim2Err);
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure InsertAllocationCode(var Rec: Record "Gen. Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        // AppMgt: Codeunit AppMgtNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: Array[10] of Code[20];
        // ShortcutDimension9CodeNVX: Code[20];
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugeordneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
        case Rec."Account Type" of
            Rec."Account Type"::"Fixed Asset":
                begin
                    if not FixedAssetNVX.Get(Rec."Account No.") then
                        exit;

                    if AllocationCode.Get(FixedAssetNVX."Allocation Code") then
                        if Rec."Shortcut Dimension 2 Code" = '' then begin
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            if Rec.Modify() then;
                        end else
                            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                end;
            Rec."Account Type"::Customer:
                if ShortcutDimCode[5] <> '' then
                    if Rec."Account No." <> '' then begin
                        //ToDo ??
                        ;
                        ;
                        // Rec.ShortcutDimension5CodeNVX := AppMgt.GetCustomerBusinessDimension9(Rec."Account No.", ShortcutDimCode[5]);
                        // if Rec.ShortcutDimension5CodeNVX <> ShortcutDimCode[5] then
                        //     DimMgt.ValidateShortcutDimValues(9, ShortcutDimension9CodeNVX, Rec."Dimension Set ID");
                    end
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertAllocationCodeInAccompaniedTable(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        AppMgt: Codeunit AppMgtNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDimCode: Array[10] of Code[20];
        OldDimensionSetID: Integer;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
        WrongDim10Err: Label 'Length is not ok!', comment = 'DEA="Länge des Feldes nicht OK!"';
    begin
        if not RunTrigger then
            exit;

        if Rec.IsTemporary then
            exit;

        if Rec."Account Type" = Rec."Account Type"::"Fixed Asset" then
            if FixedAssetNVX.Get(Rec."Account No.") and (FixedAssetNVX."Allocation Code" <> '') then begin
                AllocationCode.Get(FixedAssetNVX."Allocation Code");
                if Rec."Shortcut Dimension 2 Code" = '' then begin
                    Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                    Rec.Modify();
                end else
                    if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                        Error(WrongDimErr);
            end;

        if not AppMgt.GetActivatedReminderExtensionSetup() then
            exit;

        OldDimensionSetID := Rec."Dimension Set ID";
        AppMgt.ValidateShortcutDimCodes(Rec);
        if OldDimensionSetID <> Rec."Dimension Set ID" then begin
            //ToDo
            //Change the lenght Field "Primary Key" Table Alloc
            if StrLen(Rec.ShortcutDimension10CodeNVX) > 10 then
                Error(WrongDim10Err);

            DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);
            Rec.AllocCodeNVX := ShortcutDimCode[10];
            Rec.Modify();
        end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterCopyGenJnlLineFromSalesHeaderPayment', '', true, true)]
    local procedure OnAfterCopyGenJnlLineFromSalesHeaderPayment(SalesHeader: Record "Sales Header"; var GenJournalLine: Record "Gen. Journal Line")
    var
        PaymentMethod: Record "Payment Method";
        PaymentTerms: Record "Payment Terms";
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.GetPaymentTermsCode(SalesHeader."Bill-to Customer No.", SalesHeader.ShortcutDimension5CodeNVX, GenJournalLine."Payment Terms Code");
        AppMgt.GetPaymentMethodCodeCustomer(SalesHeader."Bill-to Customer No.", SalesHeader.ShortcutDimension5CodeNVX, GenJournalLine."Payment Method Code");
        if PaymentTerms.Get(GenJournalLine."Payment Terms Code") then begin
            GenJournalLine."Due Date" := CalcDate(PaymentTerms."Due Date Calculation", SalesHeader."Document Date");
            GenJournalLine."Pmt. Discount Date" := CalcDate(PaymentTerms."Discount Date Calculation", SalesHeader."Document Date");
        end;
        if PaymentMethod.Get(GenJournalLine."Payment Method Code") then
            GenJournalLine.Validate("Payment Discount %", PaymentTerms."Discount %");
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 1 Code', false, false)]
    local procedure OnAfterValidateShortcutDimension1CodeEvent(var Rec: Record "Gen. Journal Line")
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.SetBusinessFieldNVX(Rec);
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Dimension Set ID', true, true)]
    local procedure OnAfterValidateEvent_DimensionSetID(var Rec: Record "Gen. Journal Line"; var xRec: Record "Gen. Journal Line"; CurrFieldNo: Integer)
    begin
        Message(format(Rec."Dimension Set ID"));
    end;
}