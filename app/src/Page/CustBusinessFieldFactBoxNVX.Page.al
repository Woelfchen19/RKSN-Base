page 50031 "CustBusinessFieldFactBoxNVX"
{
    Caption = 'Businessfields FactBox', comment = 'DEA="Geschäftsfelder FactBox"';

    Editable = false;
    PageType = ListPart;
    SourceTable = CustomerBusinessFieldNVX;
    SourceTableView = SORTING(sort) WHERE(Active = const(true));

    layout
    {
        area(content)
        {
            repeater(Control1)
            {
                ShowCaption = false;
                field("Customer No."; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';

                    trigger OnDrillDown()
                    var
                        CustomerBusinessField: Record CustomerBusinessFieldNVX;
                    begin
                        CustomerBusinessField := Rec;
                        if Rec."Shortcut Dimension 5 Code" = UpperCase(Format(DimShortcutBusinessFieldNVX::All)) then begin
                            CustomerBusinessField.Reset();
                            CustomerBusinessField.SetRange("Customer No.", Rec."Customer No.");
                            Page.RunModal(PAGE::CustBusinessFieldsCardNVX, CustomerBusinessField);
                        end else
                            Page.RunModal(PAGE::CustBusinessFieldCardNVX, CustomerBusinessField);
                    end;
                }
                field(Dimension5Name; Rec.Dimension5Name)
                {
                    ApplicationArea = All;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.', Comment = 'DEA="Name"';
                }
                field(StatusCustBusinessFields; Rec.State)
                {
                    Caption = 'State', comment = 'DEA="Status"';
                    StyleExpr = StyleTxt;
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        Rec.SetFilter("Shortcut Dimension 5 Code", UserSetup.BusinessFieldFilterNVX);
    end;

    trigger OnAfterGetRecord()
    var
    begin
        StyleTxt := SetStyle();
    end;

    var
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
        StyleTxt: Text;
}