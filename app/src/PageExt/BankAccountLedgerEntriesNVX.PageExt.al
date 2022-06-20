pageextension 50000 BankAccountLedgerEntriesNVX extends "Bank Account Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Allocation CodeNVX"; BankAccountLedgerEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
        }
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
    }

    trigger OnAfterGetRecord()
    begin
        if not BankAccountLedgerEntryNVX.Get("Entry No.") then
            BankAccountLedgerEntryNVX.Init();
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;

    var
        BankAccountLedgerEntryNVX: Record BankAccountLedgerEntryNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[8] of Code[20];
}