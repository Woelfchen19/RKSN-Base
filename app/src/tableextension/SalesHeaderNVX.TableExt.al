tableextension 50015 "SalesHeaderNVX" extends "Sales Header"
{
    fields
    {
        field(50000; "ShortcutDimension5CodeNVX"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensioncode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5), Blocked = const(false));
        }
    }
}