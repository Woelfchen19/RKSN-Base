page 50030 "AssignmentDepartmentListNVX"
{

    ApplicationArea = All;
    Caption = 'Assignment Department List', comment = 'DEA="Zuordnung KST Übersicht"';
    PageType = List;
    SourceTable = AssignmentDepartmentNVX;
    UsageCategory = Lists;
    ShowFilter = false;
    Editable = false;
    CardPageId = AssignmentDepartmentCardNVX;

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
