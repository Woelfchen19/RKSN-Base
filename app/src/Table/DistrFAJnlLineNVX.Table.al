table 50022 "DistrFAJnlLineNVX"
{
    Caption = 'FA Journal Line', comment = 'DEA="Anlagen Buch.-Blattzeile"';

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Template Name', comment = 'DEA="Buch.-Blattvorlagenname"';
            TableRelation = "FA Journal Template";
        }
        field(2; "Journal Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Journal Batch Name', comment = 'DEA="Buch.-Blattname"';
            TableRelation = "FA Journal Batch".Name WHERE ("Journal Template Name" = FIELD ("Journal Template Name"));
        }
        field(3; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(4; "Depreciation Book Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Book Code', comment = 'DEA="AfA Buchcode"';
            TableRelation = "Depreciation Book";
        }
        field(5; "FA Posting Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'FA Posting Type', comment = 'DEA="Anlagenbuchungsart"';
            OptionCaption = 'Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance,Salvage Value', comment = 'DEA="Anschaffungskosten,Normal-AfA,Erhöhte AfA,Zuschreibung,Sonder-AfA,Benutzerdef. AfA,Verkauf,Wartung,Restwert"';
            OptionMembers = "Acquisition Cost", Depreciation, "Write-Down", Appreciation, "Custom 1", "Custom 2", Disposal, Maintenance, "Salvage Value";
        }
        field(6; "FA No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA No.', comment = 'DEA="Anlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(7; "FA Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FA Posting Date', comment = 'DEA="Anlagedatum"';
        }
        field(8; "Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Date', comment = 'DEA="Buchungsdatum"';
        }
        field(9; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type', comment = 'DEA="Belegart"';
            OptionCaption = ' ,,Invoice,Credit Memo', comment = 'DEA=" ,,Rechnung,Gutschrift"';
            OptionMembers = " ", , Invoice, "Credit Memo";
        }
        field(10; "Document Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Date', comment = 'DEA="Belegdatum"';
        }
        field(11; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.', comment = 'DEA="Belegnr."';
        }
        field(12; "External Document No."; Code[35])
        {
            DataClassification = CustomerContent;
            Caption = 'External Document No.', comment = 'DEA="Externe Belegnummer"';
        }
        field(13; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
        field(14; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'DEA="Betrag"';
        }
        field(15; "Debit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Debit Amount', comment = 'DEA="Sollbetrag"';
        }
        field(16; "Credit Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Credit Amount', comment = 'DEA="Habenbetrag"';
        }
        field(17; "Salvage Value"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Salvage Value', comment = 'DEA="Restwert"';
        }
        field(18; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity', comment = 'DEA="Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(19; Correction; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Correction', comment = 'DEA="Storno"';
        }
        field(20; "No. of Depreciation Days"; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'No. of Depreciation Days', comment = 'DEA="Anzahl AfA-Tage"';
        }
        field(21; "Depr. until FA Posting Date"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Depr. until FA Posting Date', comment = 'DEA="AfA bis Anlagedatum"';
        }
        field(22; "Depr. Acquisition Cost"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Depr. Acquisition Cost', comment = 'DEA="Rückw. AfA-Korr. b. Anschaff."';
        }
        field(24; "FA Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'FA Posting Group', comment = 'DEA="Anlagenbuchungsgruppe"';
            TableRelation = "FA Posting Group";
        }
        field(26; "Maintenance Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Maintenance Code', comment = 'DEA="Wartungscode"';
            TableRelation = Maintenance;
        }
        field(27; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            // CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (1));
        }
        field(28; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            // CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (2));
        }
        field(30; "Insurance No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance No.', comment = 'DEA="Versicherungsnr."';
            TableRelation = Insurance;
        }
        field(31; "Budgeted FA No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Budgeted FA No.', comment = 'DEA="Plananlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(32; "Use Duplication List"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Duplication List', comment = 'DEA="Kopiervorgang aktivieren"';
        }
        field(33; "Duplicate in Depreciation Book"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Duplicate in Depreciation Book', comment = 'DEA="In AfA-Buch kopieren"';
            TableRelation = "Depreciation Book";
        }
        field(34; "FA Reclassification Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'FA Reclassification Entry', comment = 'DEA="Anlagenumbuchungsposten"';
        }
        field(35; "FA Error Entry No."; Integer)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'FA Error Entry No.', comment = 'DEA="Anlagenstornoposten Lfd. Nr."';
            TableRelation = "FA Ledger Entry";
        }
        field(36; "Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Reason Code', comment = 'DEA="Ursachencode"';
            TableRelation = "Reason Code";
        }
        field(37; "Source Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Source Code', comment = 'DEA="Herkunftscode"';
            TableRelation = "Source Code";
        }
        field(38; "Recurring Method"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Recurring Method', comment = 'DEA="Wiederholungsart"';
            OptionCaption = ' ,F Fixed,V Variable', comment = 'DEA=" ,F Fest,V Variabel"';
            OptionMembers = " ", "F Fixed", "V Variable";
        }
        field(39; "Recurring Frequency"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Recurring Frequency', comment = 'DEA="Wiederholungsrate"';
        }
        field(41; "Expiration Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Expiration Date', comment = 'DEA="Ablaufdatum"';
        }
        field(42; "Index Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Index Entry', comment = 'DEA="Indexierungsbuchung"';
        }
        field(43; "Posting No. Series"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting No. Series', comment = 'DEA="Buchungsnr.-Serie"';
            TableRelation = "No. Series";
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
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
            CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (1), Code = field ("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
    }

    keys
    {
        key(Key1; "Journal Template Name", "Journal Batch Name", "Line No.")
        {
            Clustered = true;
        }
    }
}

