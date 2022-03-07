pageextension 50037 FAJournalNVX extends "Fixed Asset Journal"
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
                        if not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                            FAJnlLineNVX.Init();
                            FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                            FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                            FAJnlLineNVX."Line No." := Rec."Line No.";
                            FAJnlLineNVX."Allocation Code" := AllocationCodeVar;
                            FAJnlLineNVX.Insert();
                        end else begin
                            FAJnlLineNVX."Allocation Code" := AllocationCodeVar;
                            FAJnlLineNVX.Modify();
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
        if not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
            FAJnlLineNVX.Init();
            FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            FAJnlLineNVX."Line No." := Rec."Line No.";
            FAJnlLineNVX.Insert();
            Clear(AllocationCodeVar);
        end else
            AllocationCodeVar := FAJnlLineNVX."Allocation Code";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(AllocationCodeVar);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    begin
        if AllocationCodeVar <> '' then begin
            FAJnlLineNVX.Init();
            FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            FAJnlLineNVX."Line No." := Rec."Line No.";
            FAJnlLineNVX."Allocation Code" := AllocationCodeVar;
            FAJnlLineNVX.Insert();
        end;
        exit(true);
    end;

    var
        FAJnlLineNVX: Record FAJnlLineNVX;
        AllocationCodeVar: Code[10];

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(var FAJnlLine: Record "FA Journal Line")
    begin
    end;
}