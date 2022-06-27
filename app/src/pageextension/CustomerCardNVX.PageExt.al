pageextension 50002 "CustomerCardNVX" extends "Customer Card"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text): Boolean;
            var
                RKSMgt: Codeunit AllocationMgtNVX;
                NewGBPG: Code[20];
                FilterOptionNVX: Enum FilterOptionNVX;
            begin
                NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::Customer);
                if (NewGBPG <> '') then
                    Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
            end;
        }
        modify("Customer Posting Group")
        {
            Editable = CustomerPostingGroupEditable;
        }
        addbefore(Control149)
        {
            part(Dimension5ValuesNVX; CustomerBusinessFieldFBNVX)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Customer No." = Field("No.");
                Visible = ShowCustBusinessFieldFactBox;
            }
        }
    }

    trigger OnOpenPage()
    begin
        Initialize();
    end;

    trigger OnAfterGetCurrRecord()
    begin
        CustomerPostingGroupEditable := SetCustomerPostingGroupEditable();
    end;

    local procedure Initialize()
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
    begin
        ShowCustBusinessFieldFactBox := AppMgt.ShowCustBusinessFieldFactBox();

        if Rec."No." <> '' then begin
            CustomerBusinessField.Reset();
            CustomerBusinessField.SetRange("Customer No.", Rec."No.");
            CustomerBusinessField.InsertSetupBusinessField(Rec."No.");
            AppMgt.SetActiveAndStateCustomerBusinessLines(Rec."No.");
        end;
    end;

    local procedure SetCustomerPostingGroupEditable(): Boolean
    var
        UserSetup: Record "User Setup";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        CustLedgerEntry.SetCurrentKey("Customer No.");
        CustLedgerEntry.SetRange("Customer No.", Rec."No.");
        if CustLedgerEntry.IsEmpty then
            exit(true)
        else
            exit(UserSetup.EditCustomerPostingGroupNVX);
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        ShowCustBusinessFieldFactBox: Boolean;
        CustomerPostingGroupEditable: Boolean;
}