tableextension 50015 "SalesHeaderNVX" extends "Sales Header"
{
    fields
    {
        field(50000; "ShortcutDimension5CodeNVX"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensioncode 5"';
            DataClassification = CustomerContent;

            trigger OnLookup()
            begin
                if AppMgt.OnLookupShortcutDimension5Code(Rec.ShortcutDimension5CodeNVX) then
                    AppMgt.OnAfterLookupshortcutDimension5Code(Rec, xRec, Rec.ShortcutDimension5CodeNVX);
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