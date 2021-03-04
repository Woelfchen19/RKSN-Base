pageextension 50037 FAJournal extends "Fixed Asset Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; FAJnlLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    If FAJnlLineNVX."Allocation Code" <> '' then
                        If Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(FAJnlLineNVX."Allocation Code");
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            Rec.Modify();
                        end else begin
                            AllocationCode.Get(FAJnlLineNVX."Allocation Code");
                            IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;
                    FAJnlLineNVX.Modify();
                end;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(PreviewDimDistribution)
            {
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
                    OnPreviewDimDistribution(Rec);
                    DistrFAJnlLine.SetRange("Journal Template Name", Rec."Journal Template Name");
                    DistrFAJnlLine.SetRange("Journal Batch Name", Rec."Journal Batch Name");
                    PreviewFADimDistrPage.SetRecord(DistrFAJnlLine);
                    PreviewFADimDistrPage.SetTableView(DistrFAJnlLine);
                    PreviewFADimDistrPage.Run();
                end;
            }
        }
    }

    var
        FAJnlLineNVX: Record FAJnlLineNVX;

    trigger OnAfterGetRecord()
    begin
        IF not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
            FAJnlLineNVX.Init();
            FAJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            FAJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            FAJnlLineNVX."Line No." := Rec."Line No.";
            FAJnlLineNVX.Insert();
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistribution(var FAJnlLine: Record "FA Journal Line")
    begin
    end;
}