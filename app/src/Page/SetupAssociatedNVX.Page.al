page 50036 "SetupAssociatedNVX"
{
    ApplicationArea = All;
    Caption = 'Setup Associated', comment = 'DEA="Einrichtung Zugehörigkeit"';
    PageType = List;
    SourceTable = SetupAssociatedNVX;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Control)
            {
                field("Code"; Rec."Code")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Code field.', Comment = 'DEA="Code"';
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Description field.', Comment = 'DEA="Beschreibung"';
                }
            }
        }
    }
}