table 50018 "GenJnlLineArchiveNVX"
{
    Caption = 'Gen. Journal Line Archive', comment = 'DEA="Sicherung dim.Verteilungen Modul Fibu"';
    Permissions = tabledata "Sales Invoice Header" = r,
                  tabledata "Data Exch. Field" = rimd;

    fields
    {
        field(1; "Journal Template Name"; Code[10])
        {
            Caption = 'Journal Template Name', comment = 'DEA="Buch.-Blattvorlagenname"';
            TableRelation = "Gen. Journal Template";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(3; "Account Type"; Option)
        {
            Caption = 'Account Type', comment = 'DEA="Kontoart"';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee', comment = 'DEA="Sachkonto,Debitor,Kreditor,Bankkonto,Anlage,IC-Partner,Mitarbeiter"';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(4; "Account No."; Code[20])
        {
            Caption = 'Account No.', comment = 'DEA="Kontonr."';
            TableRelation = if ("Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                          Blocked = const(false))
            else
            if ("Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Account Type" = const(Employee)) Employee;
        }
        field(5; "Posting Date"; Date)
        {
            Caption = 'Posting Date', comment = 'DEA="Buchungsdatum"';
            ClosingDates = true;
        }
        field(6; "Document Type"; Option)
        {
            Caption = 'Document Type', comment = 'DEA="Belegart"';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', comment = 'DEA=" ,Zahlung,Rechnung,Gutschrift,Zinsrechnung,Mahnung,Erstattung"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(7; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'DEA="Belegnr."';
        }
        field(8; Description; Text[100])
        {
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
        field(10; "VAT %"; Decimal)
        {
            Caption = 'VAT %', comment = 'DEA="MwSt. %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(11; "Bal. Account No."; Code[20])
        {
            Caption = 'Bal. Account No.', comment = 'DEA="Gegenkontonr."';
            TableRelation = if ("Bal. Account Type" = const("G/L Account")) "G/L Account" where("Account Type" = const(Posting),
                                                                                               Blocked = const(false))
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const("Bank Account")) "Bank Account"
            else
            if ("Bal. Account Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Bal. Account Type" = const("IC Partner")) "IC Partner"
            else
            if ("Bal. Account Type" = const(Employee)) Employee;
        }
        field(12; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code', comment = 'DEA="Währungscode"';
            TableRelation = Currency;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'DEA="Betrag"';
        }
        field(14; "Debit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Debit Amount', comment = 'DEA="Sollbetrag"';
        }
        field(15; "Credit Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Credit Amount', comment = 'DEA="Habenbetrag"';
        }
        field(16; "Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount (LCY)', comment = 'DEA="Betrag (MW)"';
        }
        field(17; "Balance (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Balance (LCY)', comment = 'DEA="Saldo (MW)"';
            Editable = false;
        }
        field(18; "Currency Factor"; Decimal)
        {
            Caption = 'Currency Factor', comment = 'DEA="Währungsfaktor"';
            DecimalPlaces = 0 : 15;
            Editable = false;
            MinValue = 0;
        }
        field(19; "Sales/Purch. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Sales/Purch. (LCY)', comment = 'DEA="Verkauf/Einkauf (MW)"';
        }
        field(20; "Profit (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Profit (LCY)', comment = 'DEA="DB (MW)"';
        }
        field(21; "Inv. Discount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Inv. Discount (LCY)', comment = 'DEA="Rechnungsrabatt (MW)"';
        }
        field(22; "Bill-to/Pay-to No."; Code[20])
        {
            Caption = 'Bill-to/Pay-to No.', comment = 'DEA="Rech. an/Zahlung an Nr."';
            Editable = false;
            TableRelation = if ("Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor;
        }
        field(23; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group', comment = 'DEA="Buchungsgruppe"';
            Editable = false;
            TableRelation = if ("Account Type" = const(Customer)) "Customer Posting Group"
            else
            if ("Account Type" = const(Vendor)) "Vendor Posting Group"
            else
            if ("Account Type" = const("Fixed Asset")) "FA Posting Group";
        }
        field(24; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(25; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));
        }
        field(26; "Salespers./Purch. Code"; Code[20])
        {
            Caption = 'Salespers./Purch. Code', comment = 'DEA="Verk.-/Einkäufercode"';
            TableRelation = "Salesperson/Purchaser";
        }
        field(29; "Source Code"; Code[10])
        {
            Caption = 'Source Code', comment = 'DEA="Herkunftscode"';
            Editable = false;
            TableRelation = "Source Code";
        }
        field(30; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry', comment = 'DEA="Systembuchung"';
            Editable = false;
        }
        field(34; "On Hold"; Code[3])
        {
            Caption = 'On Hold', comment = 'DEA="Abwarten"';
        }
        field(35; "Applies-to Doc. Type"; Option)
        {
            Caption = 'Applies-to Doc. Type', comment = 'DEA="Ausgleich mit Belegart"';
            OptionCaption = ' ,Payment,Invoice,Credit Memo,Finance Charge Memo,Reminder,Refund', comment = 'DEA=" ,Zahlung,Rechnung,Gutschrift,Zinsrechnung,Mahnung,Erstattung"';
            OptionMembers = " ",Payment,Invoice,"Credit Memo","Finance Charge Memo",Reminder,Refund;
        }
        field(36; "Applies-to Doc. No."; Code[20])
        {
            Caption = 'Applies-to Doc. No.', comment = 'DEA="Ausgleich mit Belegnr."';
        }
        field(38; "Due Date"; Date)
        {
            Caption = 'Due Date', comment = 'DEA="Fälligkeitsdatum"';
        }
        field(39; "Pmt. Discount Date"; Date)
        {
            Caption = 'Pmt. Discount Date', comment = 'DEA="Skontodatum"';
        }
        field(40; "Payment Discount %"; Decimal)
        {
            Caption = 'Payment Discount %', comment = 'DEA="Skonto %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(42; "Job No."; Code[20])
        {
            Caption = 'Job No.', comment = 'DEA="Projektnr."';
            TableRelation = Job;
        }
        field(43; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'DEA="Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(44; "VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Amount', comment = 'DEA="MwSt.-Betrag"';
        }
        field(45; "VAT Posting"; Option)
        {
            Caption = 'VAT Posting', comment = 'DEA="MwSt.-Buchung"';
            Editable = false;
            OptionCaption = 'Automatic VAT Entry,Manual VAT Entry', comment = 'DEA="Automatische MwSt.-Buch.,Manuelle MwSt.-Buch."';
            OptionMembers = "Automatic VAT Entry","Manual VAT Entry";
        }
        field(47; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'DEA="Zlg.-Bedingungscode"';
            TableRelation = "Payment Terms";
        }
        field(48; "Applies-to ID"; Code[50])
        {
            Caption = 'Applies-to ID', comment = 'DEA="Ausgleichs-ID"';
        }
        field(50; "Business Unit Code"; Code[20])
        {
            Caption = 'Business Unit Code', comment = 'DEA="Konzernmandantencode"';
            TableRelation = "Business Unit";
        }
        field(51; "Journal Batch Name"; Code[10])
        {
            Caption = 'Journal Batch Name', comment = 'DEA="Buch.-Blattname"';
            TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = field("Journal Template Name"));
        }
        field(52; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code', comment = 'DEA="Ursachencode"';
            TableRelation = "Reason Code";
        }
        field(53; "Recurring Method"; Option)
        {
            BlankZero = true;
            Caption = 'Recurring Method', comment = 'DEA="Wiederholungsart"';
            OptionCaption = ' ,F  Fixed,V  Variable,B  Balance,RF Reversing Fixed,RV Reversing Variable,RB Reversing Balance', comment = 'DEA=" ,F  Fix,V  Variabel,A  Ausgleich,UF Umgekehrt Fix,UV Umgekehrt Variabel,UA Umgekehrt Ausgleich"';
            OptionMembers = " ","F  Fixed","V  Variable","B  Balance","RF Reversing Fixed","RV Reversing Variable","RB Reversing Balance";
        }
        field(54; "Expiration Date"; Date)
        {
            Caption = 'Expiration Date', comment = 'DEA="Ablaufdatum"';
        }
        field(55; "Recurring Frequency"; DateFormula)
        {
            Caption = 'Recurring Frequency', comment = 'DEA="Wiederholungsrate"';
        }
        field(56; "Allocated Amt. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = sum("Gen. Jnl. Allocation".Amount where("Journal Template Name" = field("Journal Template Name"),
                                                                   "Journal Batch Name" = field("Journal Batch Name"),
                                                                   "Journal Line No." = field("Line No.")));
            Caption = 'Allocated Amt. (LCY)', comment = 'DEA="Zugeordneter Betrag (MW)"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(57; "Gen. Posting Type"; Option)
        {
            Caption = 'Gen. Posting Type', comment = 'DEA="Buchungsart"';
            OptionCaption = ' ,Purchase,Sale,Settlement', comment = 'DEA=" ,Einkauf,Verkauf,Ausgleich"';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(58; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Geschäftsbuchungsgruppe"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(59; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', comment = 'DEA="Produktbuchungsgruppe"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(60; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type', comment = 'DEA="MwSt.-Berechnungsart"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(61; "EU 3-Party Trade"; Boolean)
        {
            Caption = 'EU 3-Party Trade', comment = 'DEA="EU-Dreiecksgeschäft"';
            Editable = false;
        }
        field(62; "Allow Application"; Boolean)
        {
            Caption = 'Allow Application', comment = 'DEA="Ausgleich zulassen"';
            InitValue = true;
        }
        field(63; "Bal. Account Type"; Option)
        {
            Caption = 'Bal. Account Type', comment = 'DEA="Gegenkontoart"';
            OptionCaption = 'G/L Account,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee', comment = 'DEA="Sachkonto,Debitor,Kreditor,Bankkonto,Anlage,IC-Partner,Mitarbeiter"';
            OptionMembers = "G/L Account",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(64; "Bal. Gen. Posting Type"; Option)
        {
            Caption = 'Bal. Gen. Posting Type', comment = 'DEA="Gegenkonto Buchungsart"';
            OptionCaption = ' ,Purchase,Sale,Settlement';
            OptionMembers = " ",Purchase,Sale,Settlement;
        }
        field(65; "Bal. Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Bal. Gen. Bus. Posting Group', comment = 'DEA="Gegenkonto Geschäftsbuchungsgr"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(66; "Bal. Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Bal. Gen. Prod. Posting Group', comment = 'DEA="Gegenkonto Produktbuchungsgr."';
            TableRelation = "Gen. Product Posting Group";
        }
        field(67; "Bal. VAT Calculation Type"; Option)
        {
            Caption = 'Bal. VAT Calculation Type', comment = 'DEA="Gegenkto. MwSt.-Berechnungsart"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(68; "Bal. VAT %"; Decimal)
        {
            Caption = 'Bal. VAT %', comment = 'DEA="Gegenkonto MwSt. %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(69; "Bal. VAT Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount', comment = 'DEA="Gegenkonto MwSt.-Betrag"';
        }
        field(70; "Bank Payment Type"; Option)
        {
            AccessByPermission = tabledata "Bank Account" = R;
            Caption = 'Bank Payment Type', comment = 'DEA="Bankkontozahlungsart"';
            OptionCaption = ' ,Computer Check,Manual Check,Electronic Payment,Electronic Payment-IAT', comment = 'DEA=" ,Computer Scheck,Manueller Scheck,Elektronische Zahlung,Elektronische IAT-Zahlung"';
            OptionMembers = " ","Computer Check","Manual Check","Electronic Payment","Electronic Payment-IAT";
        }
        field(71; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount', comment = 'DEA="MwSt.-Bemessungsgrundlage"';
        }
        field(72; "Bal. VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount', comment = 'DEA="Gegenkto. MwSt.-Bemessungsgr."';
        }
        field(73; Correction; Boolean)
        {
            Caption = 'Correction', comment = 'DEA="Storno"';
        }
        field(75; "Check Printed"; Boolean)
        {
            AccessByPermission = tabledata "Check Ledger Entry" = R;
            Caption = 'Check Printed', comment = 'DEA="Storno"';
            Editable = false;
        }
        field(76; "Document Date"; Date)
        {
            Caption = 'Document Date', comment = 'DEA="Belegdatum"';
            ClosingDates = true;
        }
        field(77; "External Document No."; Code[35])
        {
            Caption = 'External Document No.', comment = 'DEA="Externe Belegnummer"';
        }
        field(78; "Source Type"; Option)
        {
            Caption = 'Source Type', comment = 'DEA="Herkunftsart"';
            OptionCaption = ' ,Customer,Vendor,Bank Account,Fixed Asset,IC Partner,Employee', comment = 'DEA=" ,Debitor,Kreditor,Bankkonto,Anlage,IC-Partner,Mitarbeiter"';
            OptionMembers = " ",Customer,Vendor,"Bank Account","Fixed Asset","IC Partner",Employee;
        }
        field(79; "Source No."; Code[20])
        {
            Caption = 'Source No.', comment = 'DEA="Herkunftsnr."';
            TableRelation = if ("Source Type" = const(Customer)) Customer
            else
            if ("Source Type" = const(Vendor)) Vendor
            else
            if ("Source Type" = const("Bank Account")) "Bank Account"
            else
            if ("Source Type" = const("Fixed Asset")) "Fixed Asset"
            else
            if ("Source Type" = const(Employee)) Employee;
        }
        field(80; "Posting No. Series"; Code[20])
        {
            Caption = 'Posting No. Series', comment = 'DEA="Buchungsnr.-Serie"';
            TableRelation = "No. Series";
        }
        field(82; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'DEA="Steuergebietscode"';
            TableRelation = "Tax Area";
        }
        field(83; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'DEA="Steuerpflichtig"';
        }
        field(84; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code', comment = 'DEA="Steuergruppencode"';
            TableRelation = "Tax Group";
        }
        field(85; "Use Tax"; Boolean)
        {
            Caption = 'Use Tax', comment = 'DEA="Verbrauchssteuer"';
        }
        field(86; "Bal. Tax Area Code"; Code[20])
        {
            Caption = 'Bal. Tax Area Code', comment = 'DEA="Gegenkonto Steuergebietscode"';
            TableRelation = "Tax Area";
        }
        field(87; "Bal. Tax Liable"; Boolean)
        {
            Caption = 'Bal. Tax Liable', comment = 'DEA="Gegenkonto Steuerpflichtig"';
        }
        field(88; "Bal. Tax Group Code"; Code[20])
        {
            Caption = 'Bal. Tax Group Code', comment = 'DEA="Gegenkonto Steuergruppencode"';
            TableRelation = "Tax Group";
        }
        field(89; "Bal. Use Tax"; Boolean)
        {
            Caption = 'Bal. Use Tax', comment = 'DEA="Gegenkonto Verbrauchssteuer"';
        }
        field(90; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group', comment = 'DEA="MwSt.-Geschäftsbuchungsgruppe"';
            TableRelation = "VAT Business Posting Group";
        }
        field(91; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', comment = 'DEA="MwSt.-Produktbuchungsgruppe"';
            TableRelation = "VAT Product Posting Group";
        }
        field(92; "Bal. VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'Bal. VAT Bus. Posting Group', comment = 'DEA="Gegenkto. MwSt.-Gesch.-Buch.-G"';
            TableRelation = "VAT Business Posting Group";
        }
        field(93; "Bal. VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'Bal. VAT Prod. Posting Group', comment = 'DEA="Gegenkto. MwSt.-Prod.-Buch.-Gr"';
            TableRelation = "VAT Product Posting Group";
        }
        field(95; "Additional-Currency Posting"; Option)
        {
            Caption = 'Additional-Currency Posting', comment = 'DEA="Buchung (BW)"';
            Editable = false;
            OptionCaption = 'None,Amount Only,Additional-Currency Amount Only', comment = 'DEA="Kein,Nur Betrag,Nur Betrag (BW)"';
            OptionMembers = None,"Amount Only","Additional-Currency Amount Only";
        }
        field(98; "FA Add.-Currency Factor"; Decimal)
        {
            Caption = 'FA Add.-Currency Factor', comment = 'DEA="Anlagenwährungsfaktor (BW)"';
            DecimalPlaces = 0 : 15;
            MinValue = 0;
        }
        field(99; "Source Currency Code"; Code[10])
        {
            Caption = 'Source Currency Code', comment = 'DEA="Urspr.-Währungscode"';
            Editable = false;
            TableRelation = Currency;
        }
        field(100; "Source Currency Amount"; Decimal)
        {
            AccessByPermission = tabledata Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Currency Amount', comment = 'DEA="Urspr.-Währung Betrag"';
            Editable = false;
        }
        field(101; "Source Curr. VAT Base Amount"; Decimal)
        {
            AccessByPermission = tabledata Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Base Amount', comment = 'DEA="Urspr.-Währung MwSt.-Bemess."';
            Editable = false;
        }
        field(102; "Source Curr. VAT Amount"; Decimal)
        {
            AccessByPermission = tabledata Currency = R;
            AutoFormatType = 1;
            Caption = 'Source Curr. VAT Amount', comment = 'DEA="Urspr.-Währung MwSt.-Betrag"';
            Editable = false;
        }
        field(103; "VAT Base Discount %"; Decimal)
        {
            Caption = 'VAT Base Discount %', comment = 'DEA="MwSt.-Bemessungsgr. Skonto %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MaxValue = 100;
            MinValue = 0;
        }
        field(104; "VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Amount (LCY)', comment = 'DEA="MwSt.-Betrag (MW)"';
            Editable = false;
        }
        field(105; "VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'VAT Base Amount (LCY)', comment = 'DEA="MwSt.-Bemessungsgrundlage (MW)"';
            Editable = false;
        }
        field(106; "Bal. VAT Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Amount (LCY)', comment = 'DEA="Gegenkonto MwSt.-Betrag (MW)"';
            Editable = false;
        }
        field(107; "Bal. VAT Base Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Bal. VAT Base Amount (LCY)', comment = 'DEA="Gegenkto. MwSt.-Bemess. (MW)"';
            Editable = false;
        }
        field(108; "Reversing Entry"; Boolean)
        {
            Caption = 'Reversing Entry', comment = 'DEA="Umkehrbuchung"';
            Editable = false;
        }
        field(109; "Allow Zero-Amount Posting"; Boolean)
        {
            Caption = 'Allow Zero-Amount Posting', comment = 'DEA="Buchung ohne Betrag zulassen"';
            Editable = false;
        }
        field(110; "Ship-to/Order Address Code"; Code[10])
        {
            Caption = 'Ship-to/Order Address Code', comment = 'DEA="Verk. an/Eink. von Adresscode"';
            TableRelation = if ("Account Type" = const(Customer)) "Ship-to Address".Code where("Customer No." = field("Bill-to/Pay-to No."))
            else
            if ("Account Type" = const(Vendor)) "Order Address".Code where("Vendor No." = field("Bill-to/Pay-to No."))
            else
            if ("Bal. Account Type" = const(Customer)) "Ship-to Address".Code where("Customer No." = field("Bill-to/Pay-to No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Order Address".Code where("Vendor No." = field("Bill-to/Pay-to No."));
        }
        field(111; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference', comment = 'DEA="MwSt.-Differenz"';
            Editable = false;
        }
        field(112; "Bal. VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Bal. VAT Difference', comment = 'DEA="Gegenkonto MwSt.-Differenz"';
            Editable = false;
        }
        field(113; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code', comment = 'DEA="IC-Partnercode"';
            Editable = false;
            TableRelation = "IC Partner";
        }
        field(114; "IC Direction"; Option)
        {
            Caption = 'IC Direction', comment = 'DEA="IC-Richtung"';
            OptionCaption = 'Outgoing,Incoming', comment = 'DEA="Ausgehend,Eingehend"';
            OptionMembers = Outgoing,Incoming;
        }
        field(116; "IC Partner G/L Acc. No."; Code[20])
        {
            Caption = 'IC Partner G/L Acc. No.', comment = 'DEA="IC-Partner Sachkontonr."';
            TableRelation = "IC G/L Account";
        }
        field(117; "IC Partner Transaction No."; Integer)
        {
            Caption = 'IC Partner Transaction No.', comment = 'DEA="IC-Partner Transaktionsnr."';
            Editable = false;
        }
        field(118; "Sell-to/Buy-from No."; Code[20])
        {
            Caption = 'Sell-to/Buy-from No.', comment = 'DEA="Verk. an/Eink. von Nr."';
            TableRelation = if ("Account Type" = const(Customer)) Customer
            else
            if ("Bal. Account Type" = const(Customer)) Customer
            else
            if ("Account Type" = const(Vendor)) Vendor
            else
            if ("Bal. Account Type" = const(Vendor)) Vendor;
        }
        field(119; "VAT Registration No."; Text[20])
        {
            Caption = 'VAT Registration No.', comment = 'DEA="USt-IdNr."';
        }
        field(120; "Country/Region Code"; Code[10])
        {
            Caption = 'Country/Region Code', comment = 'DEA="Länder-/Regionscode"';
            TableRelation = "Country/Region";
        }
        field(121; Prepayment; Boolean)
        {
            Caption = 'Prepayment', comment = 'DEA="Vorauszahlung"';
        }
        field(122; "Financial Void"; Boolean)
        {
            Caption = 'Financial Void', comment = 'DEA="Finanziell entwertet"';
            Editable = false;
        }
        field(123; "Copy VAT Setup to Jnl. Lines"; Boolean)
        {
            Caption = 'Copy VAT Setup to Jnl. Lines', comment = 'DEA="MwSt.Einr. in Bu.Bl.Zeilen kop."';
            Editable = false;
            InitValue = true;
        }
        field(165; "Incoming Document Entry No."; Integer)
        {
            Caption = 'Incoming Document Entry No.', comment = 'DEA="Lfd. Nr. eingehender Beleg"';
            TableRelation = "Incoming Document";
        }
        field(170; "Creditor No."; Code[20])
        {
            Caption = 'Creditor No.', comment = 'DEA="Gläubiger-Identifikationsnummer"';
        }
        field(171; "Payment Reference"; Code[50])
        {
            Caption = 'Payment Reference', comment = 'DEA="Zahlungsreferenz"';
            Numeric = true;
        }
        field(172; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
            TableRelation = "Payment Method";
        }
        field(173; "Applies-to Ext. Doc. No."; Code[35])
        {
            Caption = 'Applies-to Ext. Doc. No.', comment = 'DEA="Ausgleich ext. Belegnr."';
        }
        field(288; "Recipient Bank Account"; Code[20])
        {
            Caption = 'Recipient Bank Account', comment = 'DEA="Bankkonto Empfänger"';
            TableRelation = if ("Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Account No."))
            else
            if ("Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Account No."))
            else
            if ("Account Type" = const(Employee)) Employee."No." where("Employee No. Filter" = field("Account No."))
            else
            if ("Bal. Account Type" = const(Customer)) "Customer Bank Account".Code where("Customer No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Vendor)) "Vendor Bank Account".Code where("Vendor No." = field("Bal. Account No."))
            else
            if ("Bal. Account Type" = const(Employee)) Employee."No." where("Employee No. Filter" = field("Bal. Account No."));
        }
        field(289; "Message to Recipient"; Text[140])
        {
            Caption = 'Message to Recipient', comment = 'DEA="Nachricht an Empfänger"';
        }
        field(290; "Exported to Payment File"; Boolean)
        {
            Caption = 'Exported to Payment File', comment = 'DEA="In Zahlungsdatei exportiert"';
            Editable = false;
        }
        field(291; "Has Payment Export Error"; Boolean)
        {
            CalcFormula = exist("Payment Jnl. Export Error Text" where("Journal Template Name" = field("Journal Template Name"),
                                                                        "Journal Batch Name" = field("Journal Batch Name"),
                                                                        "Journal Line No." = field("Line No.")));
            Caption = 'Has Payment Export Error', comment = 'DEA="Weist Zahlungsexportfehler auf"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID', comment = 'DEA="Dimensionssatz-ID"';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(827; "Credit Card No."; Code[20])
        {
            Caption = 'Credit Card No.', comment = 'DEA="Kreditkartennr."';
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.', comment = 'DEA="Projektaufgabennr."';
            TableRelation = "Job Task"."Job Task No.";
        }
        field(1002; "Job Unit Price (LCY)"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 2;
            Caption = 'Job Unit Price (LCY)', comment = 'DEA="VK-Preis Projekt (MW)"';
            Editable = false;
        }
        field(1003; "Job Total Price (LCY)"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            Caption = 'Job Total Price (LCY)', comment = 'DEA="Verkaufsbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1004; "Job Quantity"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            Caption = 'Job Quantity', comment = 'DEA="Projektmenge"';
            DecimalPlaces = 0 : 5;
        }
        field(1005; "Job Unit Cost (LCY)"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 2;
            Caption = 'Job Unit Cost (LCY)', comment = 'DEA="Projekteinstandspreis (MW)"';
            Editable = false;
        }
        field(1006; "Job Line Discount %"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            Caption = 'Job Line Discount %', comment = 'DEA="Zeilenrabatt % Projekt"';
        }
        field(1007; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Job Line Disc. Amount (LCY)', comment = 'DEA="Zeilenrabattbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1008; "Job Unit Of Measure Code"; Code[10])
        {
            Caption = 'Job Unit Of Measure Code', comment = 'DEA="Projekteinheitencode"';
            TableRelation = "Unit of Measure";
        }
        field(1009; "Job Line Type"; Option)
        {
            AccessByPermission = tabledata Job = R;
            Caption = 'Job Line Type', comment = 'DEA="Projektzeilenart"';
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable', comment = 'DEA=" ,Budget,Fakturierbar,Budget und Fakturierbar"';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";
        }
        field(1010; "Job Unit Price"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Price', comment = 'DEA="VK-Preis Projekt"';
        }
        field(1011; "Job Total Price"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Price', comment = 'DEA="Verkaufsbetrag Projekt"';
            Editable = false;
        }
        field(1012; "Job Unit Cost"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 2;
            Caption = 'Job Unit Cost', comment = 'DEA="Projekteinstandspreis"';
            Editable = false;
        }
        field(1013; "Job Total Cost"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Total Cost', comment = 'DEA="Projekteinstandsbetrag"';
            Editable = false;
        }
        field(1014; "Job Line Discount Amount"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Discount Amount', comment = 'DEA="Zeilenrabattbetrag Projekt"';
        }
        field(1015; "Job Line Amount"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            Caption = 'Job Line Amount', comment = 'DEA="Zeilenbetrag Projekt"';
        }
        field(1016; "Job Total Cost (LCY)"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            Caption = 'Job Total Cost (LCY)', comment = 'DEA="Projekteinstandsbetrag (MW)"';
            Editable = false;
        }
        field(1017; "Job Line Amount (LCY)"; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            Caption = 'Job Line Amount (LCY)', comment = 'DEA="Zeilenbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1018; "Job Currency Factor"; Decimal)
        {
            Caption = 'Job Currency Factor', comment = 'DEA="Währungsfaktor Projekt"';
        }
        field(1019; "Job Currency Code"; Code[10])
        {
            Caption = 'Job Currency Code', comment = 'DEA="Währungscode Projekt"';
        }
        field(1020; "Job Planning Line No."; Integer)
        {
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Planning Line No.', comment = 'DEA="Projektplanzeilennr."';
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            AccessByPermission = tabledata Job = R;
            Caption = 'Job Remaining Qty.', comment = 'DEA="Verbleibend für Projekt - Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(1200; "Direct Debit Mandate ID"; Code[35])
        {
            Caption = 'Direct Debit Mandate ID', comment = 'DEA="Lastschrift-Mandat-ID"';
            TableRelation = if ("Account Type" = const(Customer)) "SEPA Direct Debit Mandate" where("Customer No." = field("Account No."));

        }
        field(1220; "Data Exch. Entry No."; Integer)
        {
            Caption = 'Data Exch. Entry No.', comment = 'DEA="Datenaustausch-Postennr."';
            Editable = false;
            TableRelation = "Data Exch.";
        }
        field(1221; "Payer Information"; Text[50])
        {
            Caption = 'Payer Information', comment = 'DEA="Informationen Zahlender"';
        }
        field(1222; "Transaction Information"; Text[100])
        {
            Caption = 'Transaction Information', comment = 'DEA="Transaktionsinformationen"';
        }
        field(1223; "Data Exch. Line No."; Integer)
        {
            Caption = 'Data Exch. Line No.', comment = 'DEA="Datenaustausch-Zeilennr."';
            Editable = false;
        }
        field(1224; "Applied Automatically"; Boolean)
        {
            Caption = 'Applied Automatically', comment = 'DEA="Automatisch angewendet"';
        }
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code', comment = 'DEA="Abgrenzungscode"';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(1701; "Deferral Line No."; Integer)
        {
            Caption = 'Deferral Line No.', comment = 'DEA="Abgrenzungszeilennummer"';
        }
        field(5050; "Campaign No."; Code[20])
        {
            Caption = 'Campaign No.', comment = 'DEA="Kampagnennr."';
            TableRelation = Campaign;

        }
        field(5400; "Prod. Order No."; Code[20])
        {
            Caption = 'Prod. Order No.', comment = 'DEA="FA-Nr."';
            Editable = false;
        }
        field(5600; "FA Posting Date"; Date)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'FA Posting Date', comment = 'DEA="Anlagedatum"';
        }
        field(5601; "FA Posting Type"; Option)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'FA Posting Type', comment = 'DEA="Anlagenbuchungsart"';
            OptionCaption = ' ,Acquisition Cost,Depreciation,Write-Down,Appreciation,Custom 1,Custom 2,Disposal,Maintenance', comment = 'DEA=" ,Anschaffung,Normal-AfA,Erhöhte AfA,Zuschreibung,Sonder-AfA,Benutzerdef. AfA,Verkauf,Wartung"';
            OptionMembers = " ","Acquisition Cost",Depreciation,"Write-Down",Appreciation,"Custom 1","Custom 2",Disposal,Maintenance;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code', comment = 'DEA="AfA Buchcode"';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            AutoFormatType = 1;
            Caption = 'Salvage Value', comment = 'DEA="Restwert"';
        }
        field(5604; "No. of Depreciation Days"; Integer)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            BlankZero = true;
            Caption = 'No. of Depreciation Days', comment = 'DEA="Anzahl AfA-Tage"';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Depr. until FA Posting Date', comment = 'DEA="AfA bis Anlagedatum"';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Depr. Acquisition Cost', comment = 'DEA="Rückw. AfA-Korr. b. Anschaff."';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            Caption = 'Maintenance Code', comment = 'DEA="Wartungscode"';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            Caption = 'Insurance No.', comment = 'DEA="Versicherungsnr."';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            Caption = 'Budgeted FA No.', comment = 'DEA="Plananlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book', comment = 'DEA="In AfA-Buch kopieren"';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Use Duplication List', comment = 'DEA="Kopiervorgang aktivieren"';
        }
        field(5614; "FA Reclassification Entry"; Boolean)
        {
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'FA Reclassification Entry', comment = 'DEA="Anlagenumbuchungsposten"';
        }
        field(5615; "FA Error Entry No."; Integer)
        {
            BlankZero = true;
            Caption = 'FA Error Entry No.', comment = 'DEA="Anlagenstornoposten Lfd. Nr."';
            TableRelation = "FA Ledger Entry";
        }
        field(5616; "Index Entry"; Boolean)
        {
            Caption = 'Index Entry', comment = 'DEA="Indexierungsbuchung"';
        }
        field(5617; "Source Line No."; Integer)
        {
            Caption = 'Source Line No.', comment = 'DEA="Herkunftszeilennr."';
        }
        field(5618; Comment; Text[250])
        {
            Caption = 'Comment', comment = 'DEA="Bemerkung"';
        }
        field(5701; "Check Exported"; Boolean)
        {
            Caption = 'Check Exported', comment = 'DEA="Scheck exportiert"';
        }
        field(5702; "Check Transmitted"; Boolean)
        {
            Caption = 'Check Transmitted', comment = 'DEA="Scheck übertragen"';
        }
        field(8000; Id; Guid)
        {
            Caption = 'Id', comment = 'DEA="ID"';
        }
        field(8001; "Account Id"; Guid)
        {
            Caption = 'Account Id', comment = 'DEA="Konto-ID"';
            TableRelation = "G/L Account".Id;
        }
        field(8002; "Customer Id"; Guid)
        {
            Caption = 'Customer Id', comment = 'DEA="Debitoren-ID"';
            TableRelation = Customer.Id;
        }
        field(8003; "Applies-to Invoice Id"; Guid)
        {
            Caption = 'Applies-to Invoice Id', comment = 'DEA="Ausgleichsrechnungs-ID"';
            TableRelation = "Sales Invoice Header".Id;
        }
        field(8004; "Contact Graph Id"; Text[250])
        {
            Caption = 'Contact Graph Id', comment = 'DEA="Kontakt-Graph-ID"';
        }
        field(8005; "Last Modified DateTime"; DateTime)
        {
            Caption = 'Last Modified DateTime', comment = 'DEA="Datum/Uhrzeit der letzten Änderung"';
        }
        field(8006; "Journal Batch Id"; Guid)
        {
            Caption = 'Journal Batch Id', comment = 'DEA="Buch.-Blattname-ID"';
            TableRelation = "Gen. Journal Batch".Id;
        }
        field(8007; "Payment Method Id"; Guid)
        {
            Caption = 'Payment Method Id', comment = 'DEA="Zahlungsformkennung"';
            TableRelation = "Payment Method".Id;
        }
        field(50000; "VAT Posting Type"; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50001; "Allocation Code"; Code[10])
        {
            Caption = 'Allocation Code', comment = 'DEA=Verteilungscode"';
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
        field(50006; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
        }
        field(50008; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            CaptionClass = '1,2,4';
        }
        field(50010; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            CaptionClass = '1,2,5';
        }
        field(50012; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            CaptionClass = '1,2,6';
        }
        field(50014; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 7 Code', comment = 'DEA="Shortcutdimensionscode 7"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            CaptionClass = '1,2,7';
        }
        field(50016; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            CaptionClass = '1,2,8';
        }
        field(50017; "Shortcut Dimension 9 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 9 Code', comment = 'DEA="Shortcutdimensionscode 9"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(9));
            CaptionClass = '1,2,9';
        }
        field(50018; "Shortcut Dimension 10 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="Shortcutdimensionscode 10"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(10));
            CaptionClass = '1,2,10';
        }
        field(50020; "Gen. Bus. Posting Group Desc"; Text[100])
        {
            Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Geschäftsbuchungsgruppe Beschreibung"';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Gen. Business Posting Group".Description where(Code = field("Gen. Bus. Posting Group")));
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