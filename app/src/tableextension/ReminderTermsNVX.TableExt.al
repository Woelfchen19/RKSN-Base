tableextension 50013 "ReminderTermsNVX" extends "Reminder Terms"
{
    fields
    {
        field(50000; "ShortcutDimension5CodeNVX"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensioncode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));

            trigger OnValidate()
            begin
                AppMgt.OnValidateShortcutDimension(Rec);
            end;

            trigger OnLookup()
            begin
                Rec.ShortcutDimension5CodeNVX := AppMgt.OnLookupShortcutDimension5Code();
            end;
        }
    }
    var
        AppMgt: Codeunit AppMgtNVX;
}