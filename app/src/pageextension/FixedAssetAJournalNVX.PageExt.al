pageextension 50030 "FixedAssetAJournalNVX" extends "Fixed Asset Journal"
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
                        SetComplementaryFields();

                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 1 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            if Rec."Line No." > 0 then
                                Rec.Modify();
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;


                    if FixedAssetNVX.Get(Rec."FA No.") and (FixedAssetNVX."Allocation Code" <> AllocationCodeVar) then
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
                    DistrFAJnlLine: Record DistrFAJnlLineNVX;
                    PreviewFADimDistrPage: Page PreviewFADimDistrNVX;
                begin
                    OnPreviewDimDistributionNVX(Rec);
                    DistrFAJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    DistrFAJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    PreviewFADimDistrPage.SetRecord(DistrFAJnlLine);
                    PreviewFADimDistrPage.SetTableView(DistrFAJnlLine);
                    PreviewFADimDistrPage.Run();
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FAJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
        SetGlobalVariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        FAJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
        SetComplementaryFields();
        exit(true);
    end;

    var
        FAJnlLineNVX: Record FAJnlLineNVX;
        AllocationCodeVar: Code[10];

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := FAJnlLineNVX."Allocation Code";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(FAJnlLineNVX);
        Clear(AllocationCodeVar);
    end;

    local procedure SetComplementaryFields()
    begin
        if (AllocationCodeVar = FAJnlLineNVX."Allocation Code") then
            exit;

        FAJnlLineNVX."Allocation Code" := AllocationCodeVar;
        FAJnlLineNVX.Modify();
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(var FAJnlLine: Record "FA Journal Line")
    begin
    end;
}