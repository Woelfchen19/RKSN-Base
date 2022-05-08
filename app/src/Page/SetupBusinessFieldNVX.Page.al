page 50062 "SetupBusinessFieldNVX"
{
    Caption = 'Setup Business Fields', comment = 'DEA="Einrichtung Geschäftsfelder"';
    PageType = List;
    SourceTable = SetupBusinessFieldNVX;
    UsageCategory = Administration;
    DelayedInsert = true;

    layout
    {
        area(Content)
        {
            repeater(Controls1)
            {
                field(CustomerNo; Rec.CustomerNo)
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