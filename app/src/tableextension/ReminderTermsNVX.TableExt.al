tableextension 50013 "ReminderTermsNVX" extends "Reminder Terms"
{
    fields
    {
        field(50000; "ShortcutDimension5CodeNVX"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensioncode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));
            CaptionClass = '1,2,5';

            trigger OnValidate()
            begin
                AppMgt.OnValidateShortcutDimension(Rec);
            end;

            trigger OnLookup()
            begin
                AppMgt.OnLookupShortcutDimension5Code(Rec.ShortcutDimension5CodeNVX);
            end;
        }
    }
    var
        AppMgt: Codeunit AppMgtNVX;
}