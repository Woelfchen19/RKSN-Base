tableextension 50008 "GenerLedgerSetupNVX" extends "General Ledger Setup"
{
    fields
    {
        field(50001; ShortcutDimension9CodeNVX; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 9 Code', comment = 'DEA="ShortcutDimensioncode 9"';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                UpdateDimValueGlobalDimNo(xRec.ShortcutDimension9CodeNVX, ShortcutDimension9CodeNVX, 9);
            end;
        }
        field(50002; ShortcutDimension10CodeNVX; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="ShortcutDimensioncode 10"';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                UpdateDimValueGlobalDimNo(xRec.ShortcutDimension10CodeNVX, ShortcutDimension10CodeNVX, 10);
            end;
        }
    }
}