pageextension 50005 GLEntryNVX extends "General Ledger Entries"
{
    layout
    {
        addlast(Control1)
        {
            field("Shortcut Dimension 8 Code NVX"; "Shortcut Dimension 8 Code NVX")
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the code for the shortcut dimension that is linked to the record or entry for analysis purposes.', comment = 'DEA="Gibt den Code für die Shortcut Dimension an, die für Analysezwecke mit dem Datensatz oder Posten verknüpft ist."';
            }
            field("SShortcut Dimension 1 Code"; GLEntryNVX."SShortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1338,1'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
            }
            field("SShortcut Dimension 3 Code"; GLEntryNVX."SShortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1338,3'; //= Sales + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            }
            field("PShortcut Dimension 1 Code"; GLEntryNVX."PShortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
            }
            field("PShortcut Dimension 3 Code"; GLEntryNVX."PShortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3'; //= Purchase + Dim Name
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
            }
            field("Interim Gen.Bus.Posting Group"; GLEntryNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group".Code;
            }
            field("Allocation Code"; GLEntryNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }                        
            field("VAT Posting Type"; GLEntryNVX."VAT Posting Type")
            {
                ApplicationArea = All;
                Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
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