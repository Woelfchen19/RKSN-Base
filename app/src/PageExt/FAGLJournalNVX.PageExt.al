pageextension 50029 FAGLJournalNVX extends "Fixed Asset G/L Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; AllocationCodeVar)
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    FixedAssetNVX: Record FixedAssetNVX;
                    WrongDim2Err: Label 'Profitcenter and Allocation code must match the configuration in the specified Fixed Asset.',
                        comment = 'DEA="Ihre Angaben zur Erfassungszeile sind zur Anlagenkarte, betreffend Profitcenter bzw. Verteilungscode, nicht identisch. Überprüfen Sie gegebenenfalls ihre Stammdaten!"';
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                        comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin

                    if Rec."Line No." > 0 then
                        if not GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                            GenJnlLineNVX.Init();
                            GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                            GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                            GenJnlLineNVX."Line No." := Rec."Line No.";
                            GenJnlLineNVX."Allocation Code" := AllocationCodeVar;
                            GenJnlLineNVX.Insert();
                        end else begin
                            GenJnlLineNVX."Allocation Code" := AllocationCodeVar;
                            GenJnlLineNVX.Modify();
                        end;


                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            if Rec."Line No." > 0 then
                                Rec.Modify();
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;

                    if (Rec."Account Type" = Rec."Account Type"::"Fixed Asset") and (Rec."Account No." <> '') then
                        if FixedAssetNVX.Get(Rec."Account No.") and (FixedAssetNVX."Allocation Code" <> AllocationCodeVar) then
                            Error(WrongDim2Err);

                    if (Rec."Bal. Account Type" = Rec."Bal. Account Type"::"Fixed Asset") and (Rec."Bal. Account No." <> '') then
                        if FixedAssetNVX.Get(Rec."Bal. Account No.") and (FixedAssetNVX."Allocation Code" <> AllocationCodeVar) then
                            Error(WrongDim2Err);
                end;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(PreviewDimDistributionNVX)
            {
                ApplicationArea = All;
                Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    DistrGenJnlLine: Record DistrGenJnlLineNVX;
                    PreviewDimDistrPage: Page PreviewDimDistrNVX;
                begin
                    OnPreviewDimDistributionNVX(Rec);
                    DistrGenJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    DistrGenJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    PreviewDimDistrPage.SetRecord(DistrGenJnlLine);
                    PreviewDimDistrPage.SetTableView(DistrGenJnlLine);
                    PreviewDimDistrPage.Run();
                end;
            }
        }
    }


    trigger OnAfterGetRecord()
    begin
        if not GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
            GenJnlLineNVX.Init();
            GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            GenJnlLineNVX."Line No." := Rec."Line No.";
            GenJnlLineNVX.Insert();
            Clear(AllocationCodeVar);
        end else
            AllocationCodeVar := GenJnlLineNVX."Allocation Code";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(AllocationCodeVar);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if AllocationCodeVar <> '' then begin
            GenJnlLineNVX.Init();
            GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            GenJnlLineNVX."Line No." := Rec."Line No.";
            GenJnlLineNVX."Allocation Code" := AllocationCodeVar;
            GenJnlLineNVX.Insert();
        end;
        exit(true);
    end;

    var
        GenJnlLineNVX: Record GenJnlLineNVX;
        AllocationCodeVar: Code[10];

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}