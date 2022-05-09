pageextension 50032 "FixedAssetSetupNVX" extends "Fixed Asset Setup"
{
    layout
    {
        addlast(Content)
        {
            group("Purchase VAT as ExpenseNVX")
            {
                Caption = 'VAT as Expense', comment = 'DEA="VST als Aufwand"';
                field("VAT as Expense Jnl Templ Name NVX"; FixedAssetSetupNVX."VAT as Expense Jnl Templ Name")
                {
                    ApplicationArea = All;
                    Caption = 'VAT as Expense Journal Template Name', comment = 'DEA="VST als Aufwand Buch.-Blattvorlagenname"';
                    TableRelation = "FA Journal Template".Name;
                    trigger OnValidate()
                    begin
                        FixedAssetSetupNVX.Modify();
                    end;
                }
                field("VAT as Expense Jnl Batch Name NVX"; FixedAssetSetupNVX."VAT as Expense Jnl Batch Name")
                {
                    ApplicationArea = All;
                    Caption = 'VAT as Expense Journal Batch Name', comment = 'DEA="VST als Aufwand Buch.-Blattname"';
                    TableRelation = "FA Journal Batch".Name;
                    trigger OnValidate()
                    begin
                        FixedAssetSetupNVX.Modify();
                    end;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        FixedAssetSetupNVX.Reset();
        if not FixedAssetSetupNVX.Get() then begin
            FixedAssetSetupNVX.Init();
            FixedAssetSetupNVX.Insert();
        end;
    end;

    var
        FixedAssetSetupNVX: Record FixedAssetSetupNVX;
}