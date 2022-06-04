tableextension 50015 "SalesHeaderNVX" extends "Sales Header"
{
    fields
    {
        field(50000; "ShortcutDimension5CodeNVX"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensioncode 5"';

            trigger OnLookup()
            var
                DimensionShortcutDimension5Code: Code[20];
            begin
                DimensionShortcutDimension5Code := AppMgt.OnLookupShortcutDimension5Code();
                AppMgt.OnAfterLookupshortcutDimension5Code(Rec, xRec, DimensionShortcutDimension5Code);
            end;

            trigger OnValidate()
            var
                AppMgt: Codeunit AppMgtNVX;
            begin
                AppMgt.OnValidateShortcutDimension(Rec);
            end;
        }
    }
    var
        AppMgt: Codeunit AppMgtNVX;
}