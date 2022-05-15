tableextension 50012 "DimensionValueNVX" extends "Dimension Value"
{
    fields
    {
        field(50000; ShortcutDimension1CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(50001; ShortcutDimension2CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            CaptionClass = '1,2,2';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(50002; ShortcutDimension5CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
        }
        field(50003; VATPostingTypeNVX; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
            TableRelation = VATPostingTypeNVX.Code;
        }
        field(50004; VATPostingTypeDescNVX; Text[50])
        {
            CalcFormula = lookup(VATPostingTypeNVX.Description where(Code = field(VATPostingTypeDescNVX)));
            Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; AssociatedNVX; Code[10])
        {
            Caption = 'Assosiated', comment = 'DEA="zugehörig"';
            DataClassification = CustomerContent;
        }
    }
}