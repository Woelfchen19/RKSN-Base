pageextension 50049 "VATPostingSetupNVX" extends "VAT Posting Setup"
{
    layout
    {
        addlast(Control1)
        {
            field(PurchaseVATasExpenseNVX; PurchaseVATasExpense)
            {
                ApplicationArea = All;
                Caption = 'Purchase VAT as Expense', comment = 'DEA="VST als Aufwand"';
                trigger OnValidate()
                begin
                    SetComplementaryFields();
                end;
            }
        }
    }

    var
        VATPostingSetupNVX: Record VATPostingSetupNVX;
        PurchaseVATasExpense: Boolean;


    trigger OnAfterGetRecord()
    begin
        VATPostingSetupNVX.GetDefinition(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group");
        SetGlobalVariables();
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        ClearGlobalVariables();
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        VATPostingSetupNVX.GetDefinition(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group");
        SetComplementaryFields();
        exit(true)
    end;

    trigger OnDeleteRecord(): Boolean
    begin
        ClearGlobalVariables();
        exit(true);
    end;

    local procedure SetGlobalVariables()
    begin
        PurchaseVATasExpense := VATPostingSetupNVX."Purchase VAT as Expense";
    end;

    local procedure ClearGlobalVariables()
    begin
        Clear(VATPostingSetupNVX);
        Clear(PurchaseVATasExpense);
    end;

    local procedure SetComplementaryFields()
    begin
        if (PurchaseVATasExpense = VATPostingSetupNVX."Purchase VAT as Expense") then
            exit;

        VATPostingSetupNVX."Purchase VAT as Expense" := PurchaseVATasExpense;
        VATPostingSetupNVX.Modify();
    end;
}