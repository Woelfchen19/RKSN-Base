page 50029 "SetupPropertyForFieldsNVX"
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = SetupPropertyForFieldsNVX;
    DelayedInsert = true;
    Caption = 'Setup Properties from Fields (visible,editable)', comment = 'DEA="Einrichtung Eigenschaften der Felder (visible,editable)"';

    layout
    {
        area(Content)
        {
            repeater(Control1)
            {
                field("Object Type"; Rec."Object Type")
                {
                    ToolTip = 'Specifies the value of the Object Type field.';
                    ApplicationArea = All;
                    Visible = false;
                }
                field("Object ID"; Rec."Object ID")
                {
                    ToolTip = 'Specifies the value of the Object ID field.';
                    ApplicationArea = All;
                }
                field("Object Name"; Rec."Object Name")
                {
                    ToolTip = 'Specifies the value of the Object Name field.';
                    ApplicationArea = All;
                }
                field(Dimension; Rec.Dimension)
                {
                    ToolTip = 'Specifies the value of the Dimension field.', Comment = 'DEA="Dimension"';
                    ApplicationArea = All;
                }
                field(IsVisible; Rec.IsVisible)
                {
                    ToolTip = 'Specifies the value of the Visible field.', Comment = 'DEA="Visible"';
                    ApplicationArea = All;
                }
                field(IsEnabled; Rec.IsEditable)
                {
                    ToolTip = 'Specifies the value of the Enabled field.', Comment = 'DEA="Enabled"';
                    ApplicationArea = All;
                }
            }
        }
    }
}