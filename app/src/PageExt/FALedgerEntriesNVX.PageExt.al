pageextension 50031 FALedgerEntriesNVX extends "FA Ledger Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; ShortcutDims[3])
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = 'DEA="Zeigt den Shortcutdimensionscode 3 an."';
                Editable = false;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                CaptionClass = '1,2,3';
            }
        }
        addlast(Control1)
        {
            field("Allocation CodeNVX"; FALedgerEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
        }
    }

    var
        FALedgerEntryNVX: Record FALedgerEntryNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[8] of Code[20];

    trigger OnAfterGetRecord();
    begin
        if not FALedgerEntryNVX.Get("Entry No.") then
            FALedgerEntryNVX.Init();
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);            
    end;
}