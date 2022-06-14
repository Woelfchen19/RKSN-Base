tableextension 50014 "GenJnlLineNVX" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; VATPostingTypeNVX; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50001; AllocCodeNVX; Code[10])
        {
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002; AllocationPercentNVX; Decimal)
        {
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
            DataClassification = CustomerContent;
        }
        field(50003; StartDateNVX; Date)
        {
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
            DataClassification = CustomerContent;
        }
        field(50004; ShortcutDimension1NameNVX; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            CaptionClass = '1337,1';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50005; AssociatedNVX; Code[10])
        {
            CalcFormula = lookup("Dimension Value".AssociatedNVX where("Global Dimension No." = const(2), Code = field("Shortcut Dimension 2 Code")));
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            Editable = false;
            FieldClass = FlowField;
            TableRelation = SetupAssociatedNVX;
        }
        field(50006; ShortcutDimension3CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            CaptionClass = '1,2,3';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50007; FixedGBPGNVX; Code[20])
        {
            Caption = 'FixedGBPG', comment = 'DEA="FixedGBPG"';
            DataClassification = CustomerContent;
        }
        field(50008; ShortcutDimension4CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            CaptionClass = '1,2,4';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
        }
        field(50009; ApplyDocumentNoNVX; Code[35])
        {
            Caption = 'Apply Document No.', comment = 'DEA="Ausziff.Beleg"';
            DataClassification = CustomerContent;

            trigger OnValidate()
            var
                AppMgt: Codeunit AppMgtNVX;
            begin
                AppMgt.OnValidateApplyDocumentNo(Rec);
            end;
        }
        field(50010; ShortcutDimension5CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            CaptionClass = '1,2,5';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        }
        field(50011; GenBusPostingGroupDescNVX; Text[100])
        {
            CalcFormula = lookup("Gen. Business Posting Group".Description where(Code = field("Gen. Bus. Posting Group")));
            Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Geschäftsbuchungsgruppe Beschreibung"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(50012; ShortcutDimension6CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
            CaptionClass = '1,2,6';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
        }
        field(50013; DoNotSplitNVX; Boolean)
        {
            Caption = 'Do Not Split', comment = 'DEA="Nicht aufsplitten"';
            DataClassification = CustomerContent;
        }

        field(50014; ShortcutDimension7CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 7 Code', comment = 'DEA="Shortcutdimensionscode 7"';
            CaptionClass = '1,2,7';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
        }
        field(50015; IsRetrospectPostingNVX; Boolean)
        {
            Caption = 'IsRetrospectPosting', comment = 'DEA="Ist eine Retrobuchung"';
            DataClassification = CustomerContent;
        }
        field(50016; ShortcutDimension8CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            CaptionClass = '1,2,8';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
        }
        field(50017; ShortcutDimension9CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code', comment = 'DEA="Shortcutdimensionscode 9"';
            CaptionClass = '1,2,9';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(9));
        }
        field(50018; ShortcutDimension10CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="Shortcutdimensionscode 10"';
            CaptionClass = '1,2,10';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(10));

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(10, ShortcutDimension10CodeNVX);
            end;
        }
        field(50020; SalesTransactionNoNVX; Integer)
        {
            Caption = 'Sales Transaction No.', comment = 'DEA="VERKAUF Transaktionsnummer"';
            DataClassification = CustomerContent;
        }
        field(50021; SalesSourceEntryNVX; Boolean)
        {
            Caption = 'Sales Source Entry', comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
            DataClassification = CustomerContent;
        }
        field(50022; SalesRetrospectEntryNVX; Boolean)
        {
            Caption = 'Sales Restrospect Entry', comment = 'DEA="NACHGELAGERT Modul Verkauf"';
            DataClassification = CustomerContent;
        }
    }
}