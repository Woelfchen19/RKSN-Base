page 50039 "AssignmentDepartmentCardNVX"
{
    Caption = 'Assignment Department Card', comment = 'DEA="Zuordnung KST Karte"';
    PageType = Card;
    SourceTable = AssignmentDepartmentNVX;
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.', Comment = 'DEA="Shortcutdimensionscode 5"';
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = 'DEA="Shortcutdimensionscode 1"';
                }
            }
        }
    }
}