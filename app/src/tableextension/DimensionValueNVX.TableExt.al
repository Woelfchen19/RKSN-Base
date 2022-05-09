tableextension 50012 "DimensionValueNVX" extends "Dimension Value"
{
    fields
    {
        field(50000; ShortcutDimension5CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
        }
        field(50001; AssociatedNVX; Boolean)
        {
            Caption = 'Assosiated', comment = 'DEA="zugehörig"';
            DataClassification = CustomerContent;
        }
    }
}