pageextension 50034 GeneralJournalBatchesNVX extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field(NoDimDistributionNVX; NoDimDistribution)
            {
                Caption = 'No dimensional distribution', comment = 'DEA="dim.Verteilungsprozess wiederk. deaktiviert"';
                ApplicationArea = All;
                trigger OnValidate();
                begin
                    If Rec.Name <> '' then
                        SetComplementaryFields();
                end;
            }
        }
    }

    var
        GenJournalBatchNVX: Record GenJournalBatchNVX;
        NoDimDistribution: Boolean;

    trigger OnAfterGetRecord();
    begin
        GenJournalBatchNVX.GetDefinition(Rec."Journal Template Name", Rec.Name);
        SetGlobalVariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        GenJournalBatchNVX.GetDefinition(Rec."Journal Template Name", Rec.Name);
        SetComplementaryFields();
        exit(true);
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure SetGlobalVariables()
    begin
        NoDimDistribution := GenJournalBatchNVX."No Dim Distribution";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(GenJournalBatchNVX);
        Clear(NoDimDistribution);
    end;

    local procedure SetComplementaryFields()
    begin
        if (NoDimDistribution = GenJournalBatchNVX."No Dim Distribution") then
            exit;

        GenJournalBatchNVX."No Dim Distribution" := NoDimDistribution;
        GenJournalBatchNVX.Modify();
    end;
}