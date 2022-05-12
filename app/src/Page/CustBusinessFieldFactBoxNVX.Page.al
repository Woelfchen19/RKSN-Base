page 50031 CustBusinessFieldFactBoxNVX
{
    Caption = 'Businessfields FactBox', comment = 'DEA="Geschäftsfelder FactBox"';

    Editable = false;
    PageType = ListPart;
    SourceTable = CustomerBusinessFieldNVX;
    SourceTableTemporary = true;
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
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
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
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.', Comment = 'DEA="Name"';
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            Group(Functions)
            {
                Caption = 'Functions', comment = 'DEA="Funktionen"';
                Visible = false;
                action(OpenPage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Business Fields Card', comment = 'DEA="Debitoren Geschäftsfelder"';
                    image = Card;
                    RunObject = Page CustBusinessFieldsCardNVX;
                    RunPageLink = "Customer No." = FIELD("Customer No.");
                    ToolTip = '';
                }
            }
        }
    }

    trigger OnFindRecord(Which: Text): Boolean
    begin
        AppMgt.GetTemoraryBusinessLines(CustomerNo, Rec);
        exit(Find(which));
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        CustomerNo: Code[20];

    procedure SetCustomerNo(Value: Code[20])
    begin
        CustomerNo := value;
    end;
}