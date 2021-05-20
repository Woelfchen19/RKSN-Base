pageextension 50010 VATPostingSetupCardNVX extends "VAT Posting Setup Card"
{
    layout
    {
        addlast(General)
        {
            field(PurchaseVATasExpenseNVX; PurchaseVATasExpense)
            {
                ApplicationArea = All;
                Caption = 'Purchase VAT as Expense', comment = 'DEA="VST als Aufwand"';
                trigger OnValidate()
                begin
                    IF not VATPostingSetupNVX.Get(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") then begin
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
        IF not VATPostingSetupNVX.Get(Rec."VAT Bus. Posting Group",Rec."VAT Prod. Posting Group") then begin
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
        If PurchaseVATasExpense then begin
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