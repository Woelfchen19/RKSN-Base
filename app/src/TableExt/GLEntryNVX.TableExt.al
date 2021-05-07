tableextension 50000 "GLEntryNVX" extends "G/L Entry"
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
        field(50001; "Sales Transaction No.NVX"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Transaction No.', comment = 'DEA="VERKAUF Transaktionsnummer"';
        }
        field(50002; "Sales Source EntryNVX"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Source Entry', comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
        }
        field(50003; "Sales Retrospect EntryNVX"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Restrospect Entry', comment = 'DEA="NACHGELAGERT Modul Verkauf"';
        }
    }
}