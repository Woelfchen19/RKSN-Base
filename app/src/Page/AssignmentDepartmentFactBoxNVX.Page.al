page 50040 "AssignmentDepartmentFactBoxNVX"
{
    Caption = 'Assignment Department', comment = 'DEA="Zuordnung KST"';
    Editable = false;
    PageType = ListPart;
    SourceTable = AssignmentDepartmentNVX;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                {
                    ApplicationArea = All;
                    Editable = false;
                    Visible = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}