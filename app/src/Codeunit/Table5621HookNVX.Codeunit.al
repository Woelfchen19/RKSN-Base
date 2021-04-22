codeunit 50022 "Table5621HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteAccompaniedRecord(VAR Rec: Record "FA Journal Line"; RunTrigger: Boolean)
    var
        FAJnlLineNVX: Record FAJnlLineNVX;
    begin
        If not RunTrigger then
            exit;
        IF Rec.IsTemporary then
            exit;
        IF FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then
            FAJnlLineNVX.Delete(true);
    end;


    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertAllocationCodeInAccompaniedTable(VAR Rec: Record "FA Journal Line"; RunTrigger: Boolean)
    var
        FixedAssetNVX: Record FixedAssetNVX;
        FAJnlLineNVX: Record FAJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        If not RunTrigger then
            exit;
        IF Rec.IsTemporary then
            exit;
        // If Rec."Account Type" = Rec."Account Type"::"Fixed Asset" then
        IF FixedAssetNVX.Get(Rec."FA No.") AND (FixedAssetNVX."Allocation Code" <> '') then
            IF not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                FAJnlLineNVX.Init();
                FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                FAJnlLineNVX."Line No." := Rec."Line No.";
                FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                FAJnlLineNVX.Insert();

                AllocationCode.Get(FixedAssetNVX."Allocation Code");
                IF Rec."Shortcut Dimension 2 Code" = '' then begin
                    Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                    Rec.Modify();
                end else 
                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                        Error(WrongDimErr);
            end else begin
                FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                FAJnlLineNVX.Modify();
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterValidateEvent', 'FA No.', false, false)]
    local procedure InsertAllocationCode(VAR Rec: Record "FA Journal Line")
    var
        FixedAssetNVX: Record FixedAssetNVX;
        FAJnlLineNVX: Record FAJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugeordneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        IF FixedAssetNVX.Get(Rec."FA No.") AND (FixedAssetNVX."Allocation Code" <> '') then begin

            //Get or check Dim2
            AllocationCode.Get(FixedAssetNVX."Allocation Code");
            IF Rec."Shortcut Dimension 2 Code" = '' then begin
                Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                if Rec.Modify() then; //in case rec is not inserted yet
            end else 
            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);

            IF Rec."Line No." = 0 then
                exit; //Rec isn't inserted yet and part of the primary key is missing                    

            IF FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                FAJnlLineNVX.Modify();
            end else begin
                FAJnlLineNVX.Init();
                FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                FAJnlLineNVX."Line No." := Rec."Line No.";
                FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
                FAJnlLineNVX.Insert();
            end;
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDim(VAR Rec: Record "FA Journal Line")
    var
        FAJnlLineNVX: Record FAJnlLineNVX;
        AllocationCode: Record AllocationCodeNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        // IF ((Rec."Account Type" in [Rec."Account Type"::"Fixed Asset",Rec."Account Type"::"G/L Account"]) AND (Rec."Account No." <> '')) 
        // OR ((Rec."Bal. Account Type" in [Rec."Bal. Account Type"::"Fixed Asset",Rec."Bal. Account Type"::"G/L Account"]) AND (Rec."Account No." <> '')) then 

        IF FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") AND (FAJnlLineNVX."Allocation Code" <> '') then begin
            AllocationCode.Get(FAJnlLineNVX."Allocation Code");
            IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                Error(WrongDimErr);
        end;
    end;

}