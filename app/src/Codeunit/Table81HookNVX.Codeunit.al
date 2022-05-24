codeunit 50021 Table81HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        GenJnlLineNVX: Record GenJnlLineNVX;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then
            GenJnlLineNVX.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertAllocationCodeInAccompaniedTable(var Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        GenJnlLineNVX: Record GenJnlLineNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if Rec."Account Type" = Rec."Account Type"::"Fixed Asset" then
            if FixedAssetNVX.Get(Rec."Account No.") and (FixedAssetNVX."Allocation Code" <> '') then begin
                GenJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
                GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                GenJnlLineNVX.Modify();

                AllocationCode.Get(FixedAssetNVX."Allocation Code");
                if Rec."Shortcut Dimension 2 Code" = '' then begin
                    Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                    Rec.Modify();
                end else
                    if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                        Error(WrongDimErr);
            end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure InsertAllocationCode(var Rec: Record "Gen. Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        GenJnlLineNVX: Record GenJnlLineNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugeordneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        //Get or check Dim2
        if not FixedAssetNVX.Get(Rec."Account No.") then
            exit;
        if AllocationCode.Get(FixedAssetNVX."Allocation Code") then begin
            if Rec."Shortcut Dimension 2 Code" = '' then begin
                Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                if Rec.Modify() then; //in case rec is not inserted yet
            end else
                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);

            if Rec."Line No." = 0 then
                exit; //Rec isn't inserted yet and part of the primary key is missing

            GenJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
            GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
            GenJnlLineNVX.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDim(var Rec: Record "Gen. Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAsset: Record "Fixed Asset";
        GenJnlLineNVX: Record GenJnlLineNVX;
        WrongDim2Err: Label 'Profitcenter and Allocation code must match the configuration in the specified Fixed Asset.',
                    comment = 'DEA="Ihre Angaben zur Erfassungszeile sind zur Anlagenkarte, betreffend Profitcenter bzw. Verteilungscode, nicht identisch. Überprüfen Sie gegebenenfalls ihre Stammdaten!"';
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if ((Rec."Account Type" in [Rec."Account Type"::"Fixed Asset", Rec."Account Type"::"G/L Account"]) and (Rec."Account No." <> ''))
        or ((Rec."Bal. Account Type" in [Rec."Bal. Account Type"::"Fixed Asset", Rec."Bal. Account Type"::"G/L Account"]) and (Rec."Bal. Account No." <> '')) then begin

            if GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") and (GenJnlLineNVX."Allocation Code" <> '') then begin
                AllocationCode.Get(GenJnlLineNVX."Allocation Code");
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

    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account Type', false, false)]
    local procedure RecurringJournalCheckAccountType(var Rec: Record "Gen. Journal Line")
    var
        GenJournalBatchNVX: Record GenJournalBatchNVX;
    begin      
        IF not (Rec."Account Type" in [Rec."Account Type"::Vendor, Rec."Account Type"::Customer, Rec."Account Type"::"Bank Account", Rec."Account Type"::"G/L Account"]) then begin
            GenJournalBatchNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name");
            GenJournalBatchNVX.TestField("No Dim Distribution");
        end;
    end;
}