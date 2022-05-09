pageextension 50034 "GeneralJournalBatchesNVX" extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field(NoDimDistributionNVX; NoDimDistribution)
            {
                ApplicationArea = All;
                Caption = 'No dimensional distribution', comment = 'DEA="dim.Verteilungsprozess wiederk. deaktiviert"';

                trigger OnValidate();
                begin
                    SetComplementaryFields();
                end;
            }
            field(ShortcutDimension5CodeNVX; ShortcutDimension5Code)
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';

                trigger OnValidate();
                begin
                    SetComplementaryFields();
                end;
            }
        }
    }

    var
        GenJournalBatchNVX: Record GenJournalBatchNVX;
        NoDimDistribution: Boolean;
        ShortcutDimension5Code: Code[20];

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

    local procedure ClearGlobalVariables()
    begin
        Clear(GenJournalBatchNVX);
        NoDimDistribution := false;
        ShortcutDimension5Code := '';
    end;

    local procedure SetComplementaryFields()
    begin
        if (NoDimDistribution = GenJournalBatchNVX."No Dim Distribution") and
            (ShortcutDimension5Code = GenJournalBatchNVX.ShortcutDimension5CodeNVX)
        then
            exit;

        GenJournalBatchNVX."No Dim Distribution" := NoDimDistribution;
        GenJournalBatchNVX.ShortcutDimension5CodeNVX := ShortcutDimension5Code;
        GenJournalBatchNVX.Modify();
    end;

    local procedure SetGlobalVariables()
    begin
        NoDimDistribution := GenJournalBatchNVX."No Dim Distribution";
        ShortcutDimension5Code := GenJournalBatchNVX.ShortcutDimension5CodeNVX;
    end;
}