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

        addbefore(Control149)
        {
            part(Dimension5ValuesNVX; CustBusinessFieldFactBoxNVX)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Customer No." = Field("No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        Initialize(UserID);
    end;

    // trigger OnAfterGetCurrRecord()
    // begin
    //     CurrPage.Dimension5ValuesNVX.Page.SetCustomerNo(Rec."No.");
    // end;

    local procedure Initialize(_UserID: Text)
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        if UserSetup.Get(_UserId) then
            if Rec."No." <> '' then begin
                CustomerBusinessField.Reset();
                CustomerBusinessField.SetRange("Customer No.", Rec."No.");
                if CustomerBusinessField.IsEmpty() then
                    CustomerBusinessField.InsertSetupBusinessField(Rec."No.", _UserID);
                AppMgt.SetActiveAndStateCustomerBusinessLines(Rec."No.", _UserID);
            end;
    end;

    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        UserSetup: Record "User Setup";
}
