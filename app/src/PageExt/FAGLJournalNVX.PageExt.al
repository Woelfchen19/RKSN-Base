pageextension 50035 FAGLJournalNVX extends "Fixed Asset G/L Journal"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation Code";GenJnlLineNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                begin
                    IF not GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
                        GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
                        GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
                        GenJnlLineNVX."Line No." := Rec."Line No.";
                        GenJnlLineNVX.Insert();
                    end else
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