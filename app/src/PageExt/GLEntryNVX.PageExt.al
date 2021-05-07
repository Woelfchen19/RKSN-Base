pageextension 50005 "GLEntryNVX" extends "General Ledger Entries"
{
    layout
    {
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
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
            }
            field("Sales Shortcut Dimension 3 CodeNVX"; GLEntryNVX."Sales Shortcut Dimension 3")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1338,3'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            }
            field("Purchase Shortcut Dimension 1 CodeNVX"; GLEntryNVX."Purchase Shortcut Dimension 1")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
            }
            field("Purchase Shortcut Dimension 3 CodeNVX"; GLEntryNVX."Purchase Shortcut Dimension 3")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            }
            field("Interim Gen.Bus.Posting GroupNVX"; GLEntryNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group".Code;
            }
            field("Allocation CodeNVX"; GLEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting TypeNVX"; GLEntryNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            }
            field("Deactivate dimensional distributionNVX"; GLEntryNVX."Deactivate dimensional distr")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Deactivate dimensional distribution', comment = 'DEA="Verteilung deaktiviert"';
            }
            field("Sales Transaction No.NVX"; "Sales Transaction No.NVX")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Sales Transaction No.', comment = 'DEA="VERKAUF Transaktionsnummer"';
            }
            field("Sales Source EntryNVX"; "Sales Source EntryNVX")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Sales Source Entry', comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
            }
            field("Sales Retrospect EntryNVX"; "Sales Retrospect EntryNVX")
            {
                ApplicationArea = All;
                Caption = 'Sales Restrospect Entry', comment = 'DEA="NACHGELAGERT Modul Verkauf"';
            }
            field("Transaction No.NVX"; Rec."Transaction No.")
            {
                ApplicationArea = All;
            }
        }
    }
    var
        GLEntryNVX: Record GLEntryNVX;

    trigger OnAfterGetRecord();
    begin
        IF not GLEntryNVX.get("Entry No.") then
            GLEntryNVX.Init();
    end;
}