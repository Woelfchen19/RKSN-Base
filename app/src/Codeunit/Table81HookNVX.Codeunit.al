codeunit 50018 "Table81HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        GenJnlLineNVX: Record GenJnlLineNVX;
    begin
        If not RunTrigger then
            exit;
        IF Rec.IsTemporary then
            exit;
        IF GenJnlLineNVX.Get(Rec."Journal Template Name",Rec."Journal Batch Name",Rec."Line No.") then
            GenJnlLineNVX.Delete();
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertAllocationCodeInAccompaniedTable(VAR Rec: Record "Gen. Journal Line"; RunTrigger: Boolean)
    var
        FixedAssetNVX: Record FixedAssetNVX;
        GenJnlLineNVX: Record GenJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        If not RunTrigger then
            exit;
        IF Rec.IsTemporary then
            exit;
        If Rec."Account Type" = Rec."Account Type"::"Fixed Asset" then
            IF FixedAssetNVX.Get(Rec."Account No.") AND (FixedAssetNVX."Allocation Code" <> '') then
                IF not GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                    GenJnlLineNVX.Init();
                    GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                    GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                    GenJnlLineNVX."Line No." := Rec."Line No.";
                    GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                    GenJnlLineNVX.Insert();

                    AllocationCode.Get(FixedAssetNVX."Allocation Code");
                    IF Rec."Shortcut Dimension 2 Code" = '' then begin
                        Rec.Validate("Shortcut Dimension 2 Code",AllocationCode."Shortcut Dimension 2 Code");
                        Rec.Modify();
                    end else
                        if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                            Error(WrongDimErr);
                end else begin
                    GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                    GenJnlLineNVX.Modify();
                end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Account No.', false, false)]
    local procedure InsertAllocationCode(VAR Rec: Record "Gen. Journal Line")
    var
        FixedAssetNVX: Record FixedAssetNVX;
        GenJnlLineNVX: Record GenJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugeordneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin

        // IF FixedAssetNVX.Get(Rec."Account No.") AND (FixedAssetNVX."Allocation Code" <> '') then
        //     GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";

        //Get or check Dim2
        IF AllocationCode.Get(FixedAssetNVX."Allocation Code") then begin

            IF Rec."Shortcut Dimension 2 Code" = '' then begin
                Rec.Validate("Shortcut Dimension 2 Code",AllocationCode."Shortcut Dimension 2 Code");
                IF Rec.Modify() then; //in case rec is not inserted yet

            end else

                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);

            IF Rec."Line No." = 0 then
                exit; //Rec isn't inserted yet and part of the primary key is missing

            IF GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                GenJnlLineNVX.Modify();
            end else begin
                GenJnlLineNVX.Init();
                GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                GenJnlLineNVX."Line No." := Rec."Line No.";
                GenJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                GenJnlLineNVX.Insert();
            end;

        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"Gen. Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDim(VAR Rec : Record "Gen. Journal Line")
    var
        GenJnlLineNVX: Record GenJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!', 
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        IF ((Rec."Account Type" in [Rec."Account Type"::"Fixed Asset",Rec."Account Type"::"G/L Account"]) AND (Rec."Account No." <> '')) 
        OR ((Rec."Bal. Account Type" in [Rec."Bal. Account Type"::"Fixed Asset",Rec."Bal. Account Type"::"G/L Account"]) AND (Rec."Account No." <> '')) then 
            
            IF GenJnlLineNVX.Get(Rec."Journal Template Name",Rec."Journal Batch Name",Rec."Line No.") AND (GenJnlLineNVX."Allocation Code" <> '') then begin
                AllocationCode.Get(GenJnlLineNVX."Allocation Code");
                IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);
            end;
    end;
    
}