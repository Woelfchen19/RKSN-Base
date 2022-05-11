page 50031 SetupBusinessFieldFactBoxNVX
{
    Caption = 'Businessfields', comment = 'DEA="Geschäftsfelder"';

    Editable = false;
    PageType = ListPart;
    SourceTable = SetupBusinessFieldNVX;
    SourceTableTemporary = true;
    SourceTableView = SORTING(sort);
    UsageCategory = Administration;
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
                    begin
                        Page.RunModal(PAGE::SetupBusinessFieldCardNVX, Rec);
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
                action(OpenPage)
                {
                    ApplicationArea = Basic, Suite;
                    Caption = 'Customer Business Fields Card', comment = 'DEA="Debitoren Geschäftsfelder"';
                    image = Card;
                    RunObject = Page CustomerBusinessFieldsCardNVX;
                    RunPageLink = "Customer No." = FIELD("Customer No.");
                    ToolTip = '';

                    // trigger OnAction()
                    // begin
                    //     Page.RunModal(PAGE::SetupBusinessFieldCardNVX, Rec);
                    // end;
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