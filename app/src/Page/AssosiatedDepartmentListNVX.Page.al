page 50030 "AssosiatedDepartmentListNVX"
{

    ApplicationArea = All;
    Caption = 'Assosiated Department Card', comment = 'DEA="Zugehörig KST Karte"';
    PageType = List;
    SourceTable = AssosiatedDepartmentNVX;
    UsageCategory = Lists;

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
                    Enabled = false;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
