page 50062 "CustBusinessFieldListNVX"
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
                field(Active; Rec.Active)
                {
                    ToolTip = 'Specifies the value of the Active field.', Comment = 'DEA="Aktiv"';
                    ApplicationArea = All;
                }
                field("Creation Date"; Rec."Creation Date")
                {
                    ToolTip = 'Specifies the value of the Creation Date field.', Comment = 'DEA="Errichtungsdatum"';
                    ApplicationArea = All;
                }
                field("Created By User"; Rec."Created By User")
                {
                    ToolTip = 'Specifies the value of the Created By User field.', Comment = 'DEA="Erstellt von Benutzer"';
                    ApplicationArea = All;
                }
                field("Last Modified Date"; Rec."Last Modified Date")
                {
                    ToolTip = 'Specifies the value of the Last Modified Date field.', Comment = 'DEA="Datum der letzten Änderung"';
                    ApplicationArea = All;
                }
                field("Last Modified By User"; Rec."Last Modified By User")
                {
                    ToolTip = 'Specifies the value of the Last Modified By User field.', Comment = 'DEA="Zuletzt geändert von Benutzer"';
                    ApplicationArea = All;
                }
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
                field(Dimension5Name; Rec.Dimension5Name)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                    ShowMandatory = true;
                }
                field("Reminder Terms Code"; Rec."Reminder Terms Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Reminder Terms Code field.';
                    ShowMandatory = true;
                }
                field("Payment Terms Code"; Rec."Payment Terms Code")
                {
                    ToolTip = 'Specifies the value of the Payment Terms Code field.', Comment = 'DEA="Zlg.-Bedingungscode"';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Preferred BankAccount Code"; Rec."Preferred BankAccount Code")
                {
                    ToolTip = 'Specifies the value of the Preferred Bank Account Code field.', Comment = 'DEA="Bevorzugter Bankkontocode"';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Payment Method Code"; Rec."Payment Method Code")
                {
                    ToolTip = 'Specifies the value of the Payment Method Code field.', Comment = 'DEA="Zahlungsformcode"';
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field(State; Rec.State)
                {
                    ToolTip = 'Specifies the value of the State field.', Comment = 'DEA="Status"';
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}