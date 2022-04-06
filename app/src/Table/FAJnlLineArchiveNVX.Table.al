table 50012 FAJnlLineArchiveNVX
{
    Caption = 'FA Journal Line Archive', comment = 'DEA="Anlagen Buch.-Blattzeilenarchiv"';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name', comment = 'DEA="Buch.-Blattvorlagenname"';
            TableRelation = "FA Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', comment = 'DEA="Buch.-Blattname"';
            TableRelation = "FA Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(4; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code', comment = 'DEA="AfA Buchcode"';
            TableRelation = "Depreciation Book";
        }
        field(5; "FA Posting Type"; Option)
        {
            Caption = 'FA Posting Type', comment = 'DEA="Anlagenbuchungsart"';
            OptionCaption = 'Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,Salvage Value', comment = 'DEA="Anschaffungskosten,Normal-AfA,Erhöhte AfA,Zuschreibung,Sonder-AfA,Benutzerdef. AfA,Verkauf,Wartung,Restwert"';
            OptionMembers = "Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance,"Salvage Value";
        }
        field(6; "FA No."; Code[20])
        {
            Caption = 'FA No.', comment = 'DEA="Anlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(7; "FA Posting Date"; Date)
        {
            Caption = 'FA Posting Date', comment = 'DEA="Anlagedatum"';
        }
        field(8; "Posting Date"; Date)
        {
            Caption = 'Posting Date', comment = 'DEA="Buchungsdatum"';
        }
        field(9; "Document Type"; Option)
        {
            Caption = 'Document Type', comment = 'DEA="Belegart"';
            OptionCaption = ' ,,Invoice,Credit Memo', comment = 'DEA=" ,,Rechnung,Gutschrift"';
            OptionMembers = " ",,Invoice,"Credit Memo";
        }
        field(10; "Document Date"; Date)
        {
            Caption = 'Document Date', comment = 'DEA="Belegdatum"';
        }
        field(11; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'DEA="Belegnr."';
        }
        field(12; "External Document No."; Code[35])
        {
            Caption = 'External Document No.', comment = 'DEA="Externe Belegnummer"';
        }
        field(13; Description; Text[100])
        {
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
        field(14; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'DEA="Betrag"';
        }
        field(15; "Debit Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Debit Amount', comment = 'DEA="Sollbetrag"';
        }
        field(16; "Credit Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Credit Amount', comment = 'DEA="Habenbetrag"';
        }
        field(17; "Salvage Value"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Salvage Value', comment = 'DEA="Restwert"';
        }
        field(18; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'DEA="Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(19; Correction; Boolean)
        {
            Caption = 'Correction', comment = 'DEA="Storno"';
        }
        field(20; "No. of Depreciation Days"; Integer)
        {
            BlankZero = true;
            Caption = 'No. of Depreciation Days', comment = 'DEA="Anzahl AfA-Tage"';
        }
        field(21; "Depr. until FA Posting Date"; Boolean)
        {
            Caption = 'Depr. until FA Posting Date', comment = 'DEA="AfA bis Anlagedatum"';
        }
        field(22; "Depr. Acquisition Cost"; Boolean)
        {
            Caption = 'Depr. Acquisition Cost', comment = 'DEA="Rückw. AfA-Korr. b. Anschaff."';
        }
        field(24; "FA Posting Group"; Code[20])
        {
            Caption = 'FA Posting Group', comment = 'DEA="Anlagenbuchungsgruppe"';
            TableRelation = "FA Posting Group";
        }
        field(26; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code', comment = 'DEA="Wartungscode"';
            TableRelation = Maintenance;
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
        }
        field(30; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.', comment = 'DEA="Versicherungsnr."';
            TableRelation = Insurance;
        }
        field(31; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.', comment = 'DEA="Plananlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(32; "Use Duplication List"; Boolean)
        {
            Caption = 'Use Duplication List', comment = 'DEA="Kopiervorgang aktivieren"';
        }
        field(33; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book', comment = 'DEA="In AfA-Buch kopieren"';
            TableRelation = "Depreciation Book";
        }
        field(34; "FA Reclassification Entry"; Boolean)
        {
            Caption = 'FA Reclassification Entry', comment = 'DEA="Anlagenumbuchungsposten"';
        }
        field(35; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.', comment = 'DEA="Anlagenstornoposten Lfd. Nr."';
            TableRelation = "FA Ledger Entry";
        }
        field(36; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code', comment = 'DEA="Ursachencode"';
            TableRelation = "Reason Code";
        }
        field(37; "Source Code"; Code[10])
        {
            Caption = 'Source Code', comment = 'DEA="Herkunftscode"';
            TableRelation = "Source Code";
        }
        field(38; "Recurring Method"; Option)
        {
            Caption = 'Recurring Method', comment = 'DEA="Wiederholungsart"';
            OptionCaption = ' ,F Fixed,V Variable', comment = 'DEA=" ,F Fest,V Variabel"';
            OptionMembers = " ","F Fixed","V Variable";
        }
        field(39; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency', comment = 'DEA="Wiederholungsrate"';
        }
        field(41; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date', comment = 'DEA="Ablaufdatum"';
        }
        field(42; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry', comment = 'DEA="Indexierungsbuchung"';
        }
        field(43; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series', comment = 'DEA="Buchungsnr.-Serie"';
            TableRelation = "No. Series";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID', comment = 'DEA="Dimensionssatz-ID"';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(50000; "VAT Posting Type"; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50001; "Allocation Code"; Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002; "Allocation %"; Decimal)
        {
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
            DataClassification = CustomerContent;
        }
        field(50003; "Start Date"; Date)
        {
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
            DataClassification = CustomerContent;
        }
        field(50004; "Shortcut Dimension 1 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
        field(50005; "Shortcut Dimension 2 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 2 Name', comment = 'DEA="Shortcutdimensionsname 2"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(2), Code = field("Shortcut Dimension 2 Code")));
            CaptionClass = '1337,2';
        }
        field(50006; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
        }
        field(50007; "Shortcut Dimension 3 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 3 Name', comment = 'DEA="Shortcutdimensionsname 3"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(3), Code = field("Shortcut Dimension 3 Code")));
            CaptionClass = '1337,3';
        }
        field(50008; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            CaptionClass = '1,2,4';
        }
        field(50009; "Shortcut Dimension 4 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 4 Name', comment = 'DEA="Shortcutdimensionsname 4"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(4), Code = field("Shortcut Dimension 4 Code")));
            CaptionClass = '1337,4';
        }
        field(50010; "Shortcut Dimension 5 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            CaptionClass = '1,2,5';
        }
        field(50011; "Shortcut Dimension 5 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 5 Name', comment = 'DEA="Shortcutdimensionsname 5"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(5), Code = field("Shortcut Dimension 5 Code")));
            CaptionClass = '1337,5';
        }
        field(50012; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            CaptionClass = '1,2,6';
        }
        field(50013; "Shortcut Dimension 6 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 6 Name', comment = 'DEA="Shortcutdimensionsname 6"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(6), Code = field("Shortcut Dimension 6 Code")));
            CaptionClass = '1337,6';
        }
        field(50014; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 7 Code', comment = 'DEA="Shortcutdimensionscode 7"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            CaptionClass = '1,2,7';
        }
        field(50015; "Shortcut Dimension 7 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 7 Name', comment = 'DEA="Shortcutdimensionsname 7"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(7), Code = field("Shortcut Dimension 7 Code")));
            CaptionClass = '1337,7';
        }
        field(50016; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            CaptionClass = '1,2,8';
        }
        field(50017; "Shortcut Dimension 8 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 8 Name', comment = 'DEA="Shortcutdimensionsname 8"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(8), Code = field("Shortcut Dimension 8 Code")));
            CaptionClass = '1337,8';
        }
        field(60000; "Posting GUID"; Guid)
        {
            Caption = 'Posting GUID', comment = 'DEA="Buchungs-GUID"';
            DataClassification = CustomerContent;
        }
        field(60001; "Posting Type"; Option)
        {
            Caption = 'Posting Type', comment = 'DEA="Buchungsart"';
            DataClassification = CustomerContent;
            OptionMembers = OG,Distributed,Temp;
        }
    }

    keys
    {
        key(Key1; "Posting GUID", "Posting Type", "Line No.")
        {
            Clustered = true;
        }
    }
}

