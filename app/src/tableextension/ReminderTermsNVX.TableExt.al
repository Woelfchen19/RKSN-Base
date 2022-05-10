tableextension 50013 ReminderTermsNVX extends "Reminder Terms"
{
    fields
    {
        field(50000; ShortcutDimension5CodeNVX; Code[20])
        {
            Caption = 'Reminder Term - Businessfield', comment = 'DEA="Mahncode Geschäftsfeld"';
            DataClassification = CustomerContent;

            trigger OnLookup()
            var
                AppMgt: Codeunit AppMgtNVX;
            begin
                ShortcutDimension5CodeNVX := AppMgt.OnLookupByBusinessFieldDimension(ShortcutDimension5CodeNVX, 5);
            end;
        }
    }
}