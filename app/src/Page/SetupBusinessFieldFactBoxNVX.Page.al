page 50031 SetupBusinessFieldFactBoxNVX
{
    Caption = 'Businessfields', comment = 'DEA="Geschäftsfelder"';

    Editable = false;
    PageType = ListPart;
    SourceTable = SetupBusinessFieldNVX;
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
                    ToolTip = 'Specifies the value of the Customer No. field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                    ApplicationArea = All;

                    trigger OnDrillDown()
                    begin
                        Page.RunModal(PAGE::SetupBusinessFieldCardNVX, Rec);
                    end;
                }
                field(Dimension5Name; Rec.Dimension5Name)
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.', Comment = 'DEA="Name"';
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()
    begin
        SetRange(Rec."Dimension Value Type", Rec."Dimension Value Type"::Standard);
    end;
}