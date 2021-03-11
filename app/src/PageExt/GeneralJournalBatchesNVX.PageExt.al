pageextension 50040 GeneralJournalBatchesNVX extends "General Journal Batches"
{
    layout
    {
        addlast(Control1)
        {
            field(NoDimDistribution; GenJournalBatchNVX."No Dim Distribution")
            {
                Caption = 'No dimensional distribution', comment = 'DEA="dim.Verteilungsprozess wiederk. deaktiviert"';
                ApplicationArea = All;
                trigger OnValidate();
                begin
                    IF GenJournalBatchNVX.Modify() then;

                    IF not GenJournalBatchNVX.Get(Rec."Journal Template Name", Rec.Name) then begin
                        GenJournalBatchNVX."Journal Template Name" := Rec."Journal Template Name";
                        GenJournalBatchNVX.Name := Rec.Name;
                        GenJournalBatchNVX.Insert();
                    end;
                end;
            }
        }
    }

    var
        GenJournalBatchNVX: Record GenJournalBatchNVX;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        GenJournalBatchNVX.Init();
    end;

    trigger OnAfterGetRecord();
    begin
        If not GenJournalBatchNVX.Get(Rec."Journal Template Name", Rec.Name) then begin
            GenJournalBatchNVX.Init();
            GenJournalBatchNVX."Journal Template Name" := Rec."Journal Template Name";
            GenJournalBatchNVX.Name := Rec.Name;
            GenJournalBatchNVX.Insert()
        end;
    end;
}