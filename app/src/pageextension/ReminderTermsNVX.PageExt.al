pageextension 50062 "ReminderTermsNVX" extends "Reminder Terms"
{
    layout
    {
        addlast(Control1)
        {
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                ApplicationArea = All;
            }
        }
    }
}