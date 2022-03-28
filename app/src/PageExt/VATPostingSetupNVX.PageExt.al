pageextension 50049 VATPostingSetupNVX extends "VAT Posting Setup"
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
                    if not VATPostingSetupNVX.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then begin
                        VATPostingSetupNVX.Init();
                        VATPostingSetupNVX."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";
                        VATPostingSetupNVX."VAT Prod. Posting Group" := Rec."VAT Prod. Posting Group";
                        VATPostingSetupNVX."Purchase VAT as Expense" := PurchaseVATasExpense;
                        VATPostingSetupNVX.Insert();
                    end else begin
                        VATPostingSetupNVX."Purchase VAT as Expense" := PurchaseVATasExpense;
                        VATPostingSetupNVX.Modify();
                    end;
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        if not VATPostingSetupNVX.Get(Rec."VAT Bus. Posting Group", Rec."VAT Prod. Posting Group") then begin
            VATPostingSetupNVX.Init();
            VATPostingSetupNVX."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";
            VATPostingSetupNVX."VAT Prod. Posting Group" := Rec."VAT Prod. Posting Group";
            VATPostingSetupNVX.Insert();
            Clear(PurchaseVATasExpense);
        end else
            PurchaseVATasExpense := VATPostingSetupNVX."Purchase VAT as Expense";
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        Clear(PurchaseVATasExpense);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    begin
        if PurchaseVATasExpense then begin
            VATPostingSetupNVX.Init();
            VATPostingSetupNVX."VAT Bus. Posting Group" := Rec."VAT Bus. Posting Group";
            VATPostingSetupNVX."VAT Prod. Posting Group" := Rec."VAT Prod. Posting Group";
            VATPostingSetupNVX."Purchase VAT as Expense" := PurchaseVATasExpense;
            VATPostingSetupNVX.Insert();
        end;
        exit(true);
    end;
    
    var
        VATPostingSetupNVX: Record VATPostingSetupNVX;
        PurchaseVATasExpense: Boolean;
}