pageextension 50046 "SalesJournalNVX" extends "Sales Journal"
{
    layout
    {
        addlast(Control1)
        {
            field(AllocCodeNVX; Rec.AllocCodeNVX)
            {
                ToolTip = 'Specifies the value of the Allocation Code field.', Comment = 'DEA="Verteilungscode"';
                ApplicationArea = All;
                TableRelation = AllocationCodeNVX.Code;

                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    AppMgt: Codeunit AppMgtNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!',
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    if Rec.AllocCodeNVX <> '' then
                        if Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(Rec.AllocCodeNVX);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            if Rec."Line No." > 0 then begin
                                AppMgt.InsertAllocationDimValue(AllocationCode);
                                AppMgt.ModifyDimensionSetEntry(Rec, AllocationCode.Code);
                                Rec.Modify();
                            end;
                        end else begin
                            AllocationCode.Get(Rec.AllocCodeNVX);
                            if Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;

                end;
            }

            field(FixedGBPGNVX; Rec.FixedGBPGNVX)
            {
                ToolTip = 'Specifies the value of the FixedGBPG field.', Comment = 'DEA="FixedGBPG"';
                ApplicationArea = All;
            }
            field(AssociatedNVX; Rec.AssociatedNVX)
            {
                ToolTip = 'Specifies the value of the Assosiated field.', Comment = 'DEA="Zugehörig"';
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

    [IntegrationEvent(false, false)]
    local procedure OnPreviewDimDistributionNVX(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}