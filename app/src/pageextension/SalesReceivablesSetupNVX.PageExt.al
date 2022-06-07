pageextension 50068 "SalesReceivablesSetupNVX" extends "Sales & Receivables Setup"
{
    layout
    {
        addlast(General)
        {
            field(CustomerPostingGroupNVX; CustomerPostingGroup)
            {
                ApplicationArea = All;
                Caption = 'Customer Posting Group', comment = 'DEA="Debitorenbuchungsgruppe"';
                TableRelation = "Customer Posting Group";

                trigger OnValidate()
                begin
                    SalesReceivablesSetup."Customer Posting Group" := CustomerPostingGroup;
                    SalesReceivablesSetup.Modify();
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        if not SalesReceivablesSetup.Get() then begin
            SalesReceivablesSetup.init();
            SalesReceivablesSetup.Insert();
        end else
            CustomerPostingGroup := SalesReceivablesSetup."Customer Posting Group";
    end;

    var
        SalesReceivablesSetup: record SalesReceivablesSetupNVX;
        CustomerPostingGroup: Code[20];
}