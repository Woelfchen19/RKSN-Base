codeunit 50020 Table5621HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteAccompaniedRecord(var Rec: Record "FA Journal Line"; RunTrigger: Boolean)
    var
        FAJnlLineNVX: Record FAJnlLineNVX;
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then
            FAJnlLineNVX.Delete(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterInsertEvent', '', false, false)]
    local procedure InsertAllocationCodeInAccompaniedTable(var Rec: Record "FA Journal Line"; RunTrigger: Boolean)
    var
        AllocationCode: Record AllocationCodeNVX;
        FAJnlLineNVX: Record FAJnlLineNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if not RunTrigger then
            exit;
        if Rec.IsTemporary then
            exit;
        if FixedAssetNVX.Get(Rec."FA No.") and (FixedAssetNVX."Allocation Code" <> '') then begin
            FAJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
            FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
            FAJnlLineNVX.Modify();

            AllocationCode.Get(FixedAssetNVX."Allocation Code");
            if Rec."Shortcut Dimension 2 Code" = '' then begin
                Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                Rec.Modify();
            end else
                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                Error(WrongDimErr);
            end;
    end;

    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterValidateEvent', 'FA No.', false, false)]
    local procedure InsertAllocationCode(var Rec: Record "FA Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FAJnlLineNVX: Record FAJnlLineNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugeordneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if FixedAssetNVX.Get(Rec."FA No.") and (FixedAssetNVX."Allocation Code" <> '') then begin

            //Get or check Dim2
            AllocationCode.Get(FixedAssetNVX."Allocation Code");
            if Rec."Shortcut Dimension 2 Code" = '' then begin
                Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                if Rec.Modify() then; //in case rec is not inserted yet
            end else
                if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                    Error(WrongDimErr);

            if Rec."Line No." = 0 then
                exit; //Rec isn't inserted yet and part of the primary key is missing                    

            FAJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
            FAJnlLineNVX."Allocation Code" := FixedAssetNVX."Allocation Code";
            FAJnlLineNVX.Modify();
        end;
    end;


    [EventSubscriber(ObjectType::Table, Database::"FA Journal Line", 'OnAfterValidateEvent', 'Shortcut Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDim(var Rec: Record "FA Journal Line")
    var
        AllocationCode: Record AllocationCodeNVX;
        FAJnlLineNVX: Record FAJnlLineNVX;
        FixedAsset: Record "Fixed Asset";
        WrongDim2Err: Label 'Profitcenter and Allocation code must match the configuration in the specified Fixed Asset.',
                    comment = 'DEA="Ihre Angaben zur Erfassungszeile sind zur Anlagenkarte, betreffend Profitcenter bzw. Verteilungscode, nicht identisch. Überprüfen Sie gegebenenfalls ihre Stammdaten!"';
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
    begin
        if FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") and (FAJnlLineNVX."Allocation Code" <> '') then begin
            AllocationCode.Get(FAJnlLineNVX."Allocation Code");
            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                Error(WrongDimErr);
        end;

        if FixedAsset.Get(Rec."FA No.") and (FixedAsset."Global Dimension 2 Code" <> Rec."Shortcut Dimension 2 Code") then
            Error(WrongDim2Err);
    end;
}