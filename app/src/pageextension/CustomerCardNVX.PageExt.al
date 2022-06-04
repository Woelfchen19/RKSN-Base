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
            Editable = false;
        }
        addbefore(Control149)
        {
            part(Dimension5ValuesNVX; CustBusinessFieldFactBoxNVX)
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

    local procedure Initialize()
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        ShowCustBusinessFieldFactBox := AppMgt.ShowCustBusinessFieldFactBox();

        if Rec."No." <> '' then begin
            CustomerBusinessField.Reset();
            CustomerBusinessField.SetRange("Customer No.", Rec."No.");
            CustomerBusinessField.InsertSetupBusinessField(Rec."No.", true);
            AppMgt.SetActiveAndStateCustomerBusinessLines(Rec."No.");
        end;
    end;

    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        UserSetup: Record "User Setup";
        ShowCustBusinessFieldFactBox: Boolean;
}