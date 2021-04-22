pageextension 50036 "GeneralJournalNVX" extends "General Journal"
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
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!', 
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    IF Rec."Line No." > 0 then
                        IF not GenJnlLineNVX.Get(Rec."Journal Template Name", Rec."Journal Batch Name", Rec."Line No.") then begin
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
        AllocationCodeVar: Code[10];

    trigger OnAfterGetRecord()
    begin
        IF not GenJnlLineNVX.Get(Rec."Journal Template Name",Rec."Journal Batch Name",Rec."Line No.") then begin
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
        If AllocationCodeVar <> '' then begin
            GenJnlLineNVX.Init();
            GenJnlLineNVX."Journal Template Name" := Rec."Journal Template Name";
            GenJnlLineNVX."Journal Batch Name" := Rec."Journal Batch Name";
            GenJnlLineNVX."Line No." := Rec."Line No.";
            GenJnlLineNVX."Allocation Code" := AllocationCodeVar;
            GenJnlLineNVX.Insert();
        end;
        exit(true);
    end;

    [IntegrationEvent(false,false)]
    local procedure OnPreviewDimDistributionNVX(var GenJnlLine: Record "Gen. Journal Line")
    begin
    end;
}