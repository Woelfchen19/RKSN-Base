page 50030 "AssignmentDepartmentListNVX"
{
    ApplicationArea = All;
    Caption = 'Assignment Departments', comment = 'DEA="Zuordnung KST"';
    CardPageId = AssignmentDepartmentCardNVX;
    Editable = false;
    PageType = List;
    ShowFilter = false;
    SourceTable = AssignmentDepartmentNVX;
    UsageCategory = Administration;
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
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
