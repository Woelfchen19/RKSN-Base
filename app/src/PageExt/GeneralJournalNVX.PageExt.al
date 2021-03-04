pageextension 50036 GeneralJournalNVX extends "General Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code";GenJnlLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!', 
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin       
                    If GenJnlLineNVX."Allocation Code" <> '' then
                        If Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(GenJnlLineNVX."Allocation Code");
                            Rec.Validate("Shortcut Dimension 2 Code",AllocationCode."Shortcut Dimension 2 Code");
                            Rec.Modify();
                        end else begin
                            AllocationCode.Get(GenJnlLineNVX."Allocation Code");
                            IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;
                    GenJnlLineNVX.Modify();
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
                trigger OnAction();
                var
                    DistrGenJnlLine: Record DistrGenJnlLineNVX;
                    PreviewDimDistrPage: Page PreviewDimDistrNVX;
                begin
                    OnPreviewDimDistribution(Rec);
                    DistrGenJnlLine.SetRange("Journal Template Name",Rec."Journal Template Name");
                    DistrGenJnlLine.SetRange("Journal Batch Name",Rec."Journal Batch Name");
                    PreviewDimDistrPage.SetRecord(DistrGenJnlLine);
                    PreviewDimDistrPage.SetTableView(DistrGenJnlLine);
                    PreviewDimDistrPage.Run();
                end;
            }
        }
    }

    var
        GenJnlLineNVX: Record GenJnlLineNVX;

    trigger OnAfterGetRecord()
    begin
        IF not GenJnlLineNVX.Get(Rec."Journal Template Name",Rec."Journal Batch Name",Rec."Line No.") then begin
            GenJnlLineNVX.Init();
            GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            GenJnlLineNVX."Line No." := Rec."Line No.";
            GenJnlLineNVX.Insert();
        end;
    end;

    [IntegrationEvent(false,false)]
    local procedure OnPreviewDimDistribution(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}