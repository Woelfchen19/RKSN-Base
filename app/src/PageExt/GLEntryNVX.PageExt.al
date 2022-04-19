pageextension 50040 GLEntryNVX extends "General Ledger Entries"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; ShortcutDims[3])
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = 'DEA="Shortcutdimensionscode 3"';
                Editable = false;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                CaptionClass = '1,2,3';
            }
        }
        addlast(Control1)
        {
            field("Shortcut Dimension 8 Code NVX"; "Shortcut Dimension 8 Code NVX")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the code for the shortcut dimension that is linked to the record or entry for analysis purposes.', comment = 'DEA="Gibt den Code für die Shortcut Dimension an, die für Analysezwecke mit dem Datensatz oder Posten verknüpft ist."';
            }
            field("Sales Shortcut Dimension 1 CodeNVX"; GLEntryNVX."Sales Shortcut Dimension 1")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1338,1'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = 'DEA="Shortcutdimensionscode 1"';
            }
            field("Sales Shortcut Dimension 3 CodeNVX"; GLEntryNVX."Sales Shortcut Dimension 3")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1338,3'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = 'DEA="Shortcutdimensionscode 3"';
            }
            field("Purchase Shortcut Dimension 1 CodeNVX"; GLEntryNVX."Purchase Shortcut Dimension 1")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = 'DEA="Shortcutdimensionscode 1"';
            }
            field("Purchase Shortcut Dimension 3 CodeNVX"; GLEntryNVX."Purchase Shortcut Dimension 3")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = 'DEA="Shortcutdimensionscode 3"';
            }
            field("Interim Gen.Bus.Posting GroupNVX"; GLEntryNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group".Code;
                ToolTip = 'Specifies the value of the Interim Gen. Bus. Posting Group field.', Comment = 'DEA="Interim Steuerschlüssel"';
            }
            field("Allocation CodeNVX"; GLEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                ToolTip = 'Specifies the value of the Allocation Code field.', Comment = 'DEA="Verteilungscode"';
            }
            field("VAT Posting TypeNVX"; GLEntryNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
                TableRelation = VATPostingTypeNVX.Code;
                ToolTip = 'Specifies the value of the VAT Posting Type field.', Comment = 'DEA="USt.-Buchungsart"';
            }
            field("Deactivate dimensional distributionNVX"; GLEntryNVX."Deactivate dimensional distr")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Deactivate dimensional distribution', comment = 'DEA="Verteilung deaktiviert"';
                ToolTip = 'Specifies the value of the Deactivate dimensional distribution field.', Comment = 'DEA="Verteilung deaktiviert"';
            }
            field("Sales Transaction No.NVX"; "Sales Transaction No.NVX")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Sales Transaction No.', comment = 'DEA="VERKAUF Transaktionsnummer"';
                ToolTip = 'Specifies the value of the Sales Transaction No. field.', Comment = 'DEA="VERKAUF Transaktionsnummer"';
            }
            field("Sales Source EntryNVX"; "Sales Source EntryNVX")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Sales Source Entry', comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
                ToolTip = 'Specifies the value of the Sales Source Entry field.', Comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
            }
            field("Sales Retrospect EntryNVX"; "Sales Retrospect EntryNVX")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Sales Restrospect Entry', comment = 'DEA="NACHGELAGERT Modul Verkauf"';
                ToolTip = 'Specifies the value of the Sales Restrospect Entry field.', Comment = 'DEA="NACHGELAGERT Modul Verkauf"';
            }
            field("Transaction No.NVX"; Rec."Transaction No.")
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Transaction No. field.';
            }
            field("FA as ExpenseNVX"; GLEntryNVX."FA as Expense")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Fixed Asset as Expense', comment = 'DEA="Anlage als Aufwand"';
                ToolTip = 'Specifies the value of the Fixed Asset as Expense field.', Comment = 'DEA="Anlage als Aufwand"';
            }
            field("FA Transaction No.NVX"; GLEntryNVX."FA Transaction No.")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Fixed Asset Transaction No.', comment = 'DEA="ANLAGE Transaktionsnummer"';
                ToolTip = 'Specifies the value of the Fixed Asset Transaction No. field.', Comment = 'DEA="ANLAGE Transaktionsnummer"';
            }
            field("G/L Account as ExpenseNVX"; GLEntryNVX."G/L Account as Expense")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'G/L Account as Expense', comment = 'DEA="Sachkonto als Aufwand"';
                TableRelation = "G/L Account"."No.";
                ToolTip = 'Specifies the value of the G/L Account as Expense field.', Comment = 'DEA="Sachkonto als Aufwand"';
            }
        }
    }

    var
        GLEntryNVX: Record GLEntryNVX;
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[10] of Code[20];

    trigger OnAfterGetRecord();
    begin
        if not GLEntryNVX.Get("Entry No.") then
            GLEntryNVX.Init();
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;
}