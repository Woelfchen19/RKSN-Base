page 50039 "AssignmentDepartmentCardNVX"
{
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = AssignmentDepartmentNVX;

    Caption = 'Assignment Department Card', comment = 'DEA="Zuordnung KST Karte"';

    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = 'DEA="Shortcutdimensionscode 5"';
                    ApplicationArea = All;
                    Editable = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = 'DEA="Shortcutdimensionscode 1"';
                    ApplicationArea = All;
                }
            }
        }
    }
}