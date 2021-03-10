pageextension 50037 FAJournal extends "Fixed Asset Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code"; AllocationCodeVar)
            {
                ApplicationArea = All;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                        comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin

                    If Rec."Line No." > 0 then
                        IF not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
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


                    If AllocationCodeVar <> '' then
                        If Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            If Rec."Line No." > 0 then
                                Rec.Modify();
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;
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



    trigger OnAfterGetRecord()
    begin
        IF not FAJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
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
        If AllocationCodeVar <> '' then begin
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
        AllocationCodeVar: Code[20];
        FAJnlLineNVX: Record FAJnlLineNVX;

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistribution(var FAJnlLine: Record "FA Journal Line")
    begin
    end;
}