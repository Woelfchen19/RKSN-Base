tableextension 50000 GLEntryNVX extends "G/L Entry"
{
    fields
    {
        field(50000; "Shortcut Dimension 8 Code NVX"; Code[20])
        {
            CaptionClass = '1,4,8';
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            FieldClass = FlowField;
            CalcFormula = Lookup ("Dimension Set Entry"."Dimension Value Code" WHERE ("Dimension Set ID" = FIELD ("Dimension Set ID"), "Dimension Code" = CONST ('ARTIKEL.DIM')));
            Editable = false;
        }
    }
}