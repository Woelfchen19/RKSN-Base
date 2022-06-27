page 50031 CustomerBusinessFieldFBNVX
{
    Caption = 'Activ Businessfields', comment = 'DEA="Aktive Geschäftsfelder"';

    Editable = false;
    PageType = ListPart;
    SourceTable = CustomerBusinessFieldNVX;
    SourceTableView = SORTING(sort);
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
                    ShowCaption = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';

                    // trigger OnDrillDown()
                    // var
                    //     CustomerBusinessField: Record CustomerBusinessFieldNVX;
                    //     CustomerBusinessFieldCard: Page CustomerBusinessFieldCardNVX;
                    //     CustomerBusinessFieldsCard: page CustomerBusinessFieldsCardNVX;
                    // begin
                    //     CustomerBusinessField.Reset();
                    //     CustomerBusinessField.SetRange("Customer No.", Rec."Customer No.");

                    //     if Rec."Shortcut Dimension 5 Code" = UpperCase(Format(DimShortcutBusinessFieldNVX::All)) then begin
                    //         CustomerBusinessFieldsCard.SetTableView(CustomerBusinessField);
                    //         CustomerBusinessFieldsCard.RunModal();
                    //     end else begin
                    //         CustomerBusinessField.SetRange("Shortcut Dimension 5 Code", Rec."Shortcut Dimension 5 Code");
                    //         CustomerBusinessFieldsCard.SetTableView(CustomerBusinessField);
                    //         CustomerBusinessFieldCard.RunModal();
                    //     end;
                    // end;
                    trigger OnDrillDown()
                    var
                        CustomerBusinessField: Record CustomerBusinessFieldNVX;
                    begin
                        CustomerBusinessField := Rec;
                        if Rec."Shortcut Dimension 5 Code" = UpperCase(Format(DimShortcutBusinessFieldNVX::All)) then begin
                            CustomerBusinessField.Reset();
                            CustomerBusinessField.SetRange("Customer No.", Rec."Customer No.");
                            Page.RunModal(PAGE::CustomerBusinessFieldsCardNVX, CustomerBusinessField);
                        end else
                            Page.RunModal(PAGE::"CustomerBusinessFieldCardNVX", CustomerBusinessField);
                    end;
                }
                field(Dimension5Name; Rec.ShortcutdimensionCode5Name)
                {
                    ApplicationArea = All;
                    ShowCaption = false;
                    StyleExpr = StyleTxt;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.', Comment = 'DEA="Name"';
                }
                field(StatusCustBusinessFields; Rec.State)
                {
                    ApplicationArea = All;
                    Caption = 'State', comment = 'DEA="Status"';
                    StyleExpr = StyleTxt;
                    Visible = false;
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