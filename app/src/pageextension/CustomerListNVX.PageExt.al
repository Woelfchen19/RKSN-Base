pageextension 50070 "CustomerListNVX" extends "Customer List"
{
    layout
    {
        addbefore("Power BI Report FactBox")
        {
            part(Dimension5ValuesNVX; CustBusinessFieldFactBoxNVX)
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Customer No." = Field("No.");
                Visible = ShowCustBusinessFieldFactBox;
            }
        }
    }

    Trigger OnOpenPage()
    var
        AppMgt: Codeunit AppMgtNVX;
    begin
        ShowCustBusinessFieldFactBox := AppMgt.ShowCustBusinessFieldFactBox();
    end;

    var
        ShowCustBusinessFieldFactBox: Boolean;
}