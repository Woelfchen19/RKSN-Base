pageextension 50056 "GeneralLedgerSetupNVX" extends "General Ledger Setup"
{
    layout
    {
        addafter("Shortcut Dimension 8 Code")
        {
            field(ShortcutDimension9CodeNVX; Rec.ShortcutDimension9CodeNVX)
            {
                ApplicationArea = Dimensions;
                Importance = Additional;
                ToolTip = 'Specifies the code for Shortcut Dimension 9, whose dimension values you can then enter directly on journals and sales or purchase lines.';
            }
            field(ShortcutDimension10CodeNVX; Rec.ShortcutDimension10CodeNVX)
            {
                ApplicationArea = Dimensions;
                Importance = Additional;
                ToolTip = 'Specifies the code for Shortcut Dimension 10, whose dimension values you can then enter directly on journals and sales or purchase lines.';
            }
        }
    }
}