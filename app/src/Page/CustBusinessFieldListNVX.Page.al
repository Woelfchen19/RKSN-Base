page 50062 CustBusinessFieldListNVX
{
    Caption = 'Customer Business Field List', comment = 'DEA="Debitor Geschäftsfelder Übersicht"';
    PageType = List;
    SourceTable = CustomerBusinessFieldNVX;
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Controls1)
            {
                field(CustomerNo; Rec."Customer No.")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Customer No. field.', Comment = 'DEA="Debitornr."';
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                }
                field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reminder Terms Code field.';
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = 'DEA="Zlg.-Bedingungscode"';
                    ApplicationArea = All;
                }
                field("Preferred BankAccount Code"; Rec."Preferred BankAccount Code")
                {
                    ToolTip = 'Specifies the value of the Preferred Bank Account Code field.', Comment = 'DEA="Bevorzugter Bankkontocode"';
                    ApplicationArea = All;
                }
                field(Sort; Sort)
                {
                    ApplicationArea = All;
                    ToolTip = 'Sorting', comment = 'DEA="Sortierung"';
                }
            }
        }
    }

    actions
    {
    }
}