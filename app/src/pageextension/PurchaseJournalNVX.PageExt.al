pageextension 50059 PurchaseJournalNVX extends "Purchase Journal"
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
                    AppMgt: Codeunit AppMgtNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Rec."Line No." > 0 then
                        SetComplementaryFields();

                    if AllocationCodeVar <> '' then
                        if Rec."Shortcut Dimension 1 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 1 Code", AllocationCode."Shortcut Dimension 1 Code");
                            if Rec."Line No." > 0 then begin
                                AppMgt.InsertDimValue(AllocationCode);
                                AppMgt.ModifyDimensionSetEntry(Rec, AllocationCode.Code);
                                Rec.Modify();
                            end;
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            if Rec."Shortcut Dimension 1 Code" <> AllocationCode."Shortcut Dimension 1 Code" then
                                Error(WrongDimErr);
                        end;
                end;
            }
            field(testfixedGBPGNVX; GenJnlLineNVX.FixedGBPG)
            {
                ApplicationArea = All;
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
                PromotedCategory = Process;
                PromotedIsBig = true;
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

    var
        GenJnlLineNVX: Record GenJnlLineNVX;
        AllocationCodeVar: Code[10];

    trigger OnAfterGetRecord()
    begin
        GenJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
        SetGlobalVariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GenJnlLineNVX.GetDefinition(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.");
        SetComplementaryFields();
        exit(true)
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(GenJnlLineNVX);
        Clear(AllocationCodeVar);
    end;

    local procedure SetComplementaryFields()
    begin
        if (AllocationCodeVar = GenJnlLineNVX."Allocation Code") then
            exit;

        GenJnlLineNVX."Allocation Code" := AllocationCodeVar;
        GenJnlLineNVX.Modify();
    end;

    local procedure SetGlobalVariables()
    begin
        AllocationCodeVar := GenJnlLineNVX."Allocation Code";
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}