table 50010 DistrPurchLineNVX
{
    Caption = 'Purchase Line', comment = 'DEA="Einkaufszeile"';
    LookupPageId = DimVATAllocNVX;
    DrillDownPageId = DimVATAllocNVX;
    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Document Type', comment = 'DEA="Belegart"';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Buy-from Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Buy-from Vendor No.', comment = 'DEA="Eink. von Kred.-Nr."';
            Editable = false;
            TableRelation = Vendor;
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Document No.', comment = 'DEA="Belegnr."';
            TableRelation = "Purchase Header"."No." where("Document Type" = field("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(5; Type; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Type', comment = 'DEA="Art"';
            OptionCaption = ' ,G/L Account,Item,,Fixed Asset,Charge (Item)', comment = 'DEA=" ,Sachkonto,Artikel,,WG/Anlage,Zu-/Abschlag (Artikel)"';
            OptionMembers = " ","G/L Account",Item,,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'No.', comment = 'DEA="Nr."';
        }
        field(7; "Location Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Location Code', comment = 'DEA="Lagerortcode"';
            TableRelation = Location where("Use As In-Transit" = const(false));
        }
        field(8; "Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Posting Group', comment = 'DEA="Buchungsgruppe"';
            Editable = false;
            TableRelation = if (Type = const(Item)) "Inventory Posting Group"
            else
            if (Type = const("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Expected Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Expected Receipt Date', comment = 'DEA="Erwartetes Wareneingangsdatum"';
        }
        field(11; Description; Text[100])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
        field(12; "Description 2"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Description 2', comment = 'DEA="Beschreibung 2"';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure', comment = 'DEA="Einheit"';
        }
        field(15; Quantity; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity', comment = 'DEA="Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Quantity', comment = 'DEA="Restbestellungsmenge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Invoice', comment = 'DEA="Menge akt. Rechnung"';
            DecimalPlaces = 0 : 5;

        }
        field(18; "Qty. to Receive"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Qty. to Receive', comment = 'DEA="Menge akt. Lieferung"';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Direct Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            // CaptionClass = GetCaptionClass(FieldNo("Direct Unit Cost"));
            Caption = 'Direct Unit Cost', comment = 'DEA="EK-Preis"';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)', comment = 'DEA="Einstandspreis (MW)"';
        }
        field(25; "VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT %', comment = 'DEA="MwSt. %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Line Discount %', comment = 'DEA="Zeilenrabatt %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount', comment = 'DEA="Zeilenrabattbetrag"';
        }
        field(29; Amount; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'DEA="Betrag"';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT', comment = 'DEA="Betrag inkl. MwSt."';
            Editable = false;
        }
        field(31; "Unit Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 2;
            Caption = 'Unit Price (LCY)', comment = 'DEA="VK-Preis (MW)"';
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Invoice Disc.', comment = 'DEA="Rech.-Rabatt zulassen"';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Gross Weight', comment = 'DEA="Bruttogewicht"';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Net Weight', comment = 'DEA="Nettogewicht"';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Units per Parcel', comment = 'DEA="Anzahl pro Paket"';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Unit Volume', comment = 'DEA="Volumen"';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Item = R;
            Caption = 'Appl.-to Item Entry', comment = 'DEA="Ausgleich mit Artikelposten"';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1),
                                                          Blocked = const(false));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2),
                                                          Blocked = const(false));

        }
        field(45; "Job No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job No.', comment = 'DEA="Projektnr."';
            TableRelation = Job;
        }
        field(54; "Indirect Cost %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Indirect Cost %', comment = 'DEA="Indirekte Kosten %"';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Recalculate Invoice Disc.', comment = 'DEA="Rechnungsrabatt neu berechnen"';
            Editable = false;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount', comment = 'DEA="Restbestellbetrag"';
            Editable = false;
        }
        field(58; "Qty. Rcd. Not Invoiced"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Rcd. Not Invoiced', comment = 'DEA="Lief. nicht fakt. Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Amt. Rcd. Not Invoiced"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced', comment = 'DEA="Nicht fakt. Lieferbetrag"';
            Editable = false;
        }
        field(60; "Quantity Received"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Quantity Received', comment = 'DEA="Bereits gelief. Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity Invoiced', comment = 'DEA="Bereits berech. Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Receipt No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt No.', comment = 'DEA="Wareneingangsnr."';
            Editable = false;
        }
        field(64; "Receipt Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Receipt Line No.', comment = 'DEA="Wareneingangszeilennr."';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Profit %', comment = 'DEA="DB %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Pay-to Vendor No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Pay-to Vendor No.', comment = 'DEA="Zahlung an Kred.-Nr."';
            Editable = false;
            TableRelation = Vendor;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Discount Amount', comment = 'DEA="Rechnungsrabattbetrag"';
            Editable = false;
        }
        field(70; "Vendor Item No."; Text[50])
        {
            DataClassification = CustomerContent;
            Caption = 'Vendor Item No.', comment = 'DEA="Kred.-Artikelnr."';
        }
        field(71; "Sales Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Order No.', comment = 'DEA="Verkaufsauftragsnr."';
            Editable = false;
            TableRelation = if ("Drop Shipment" = const(true)) "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(72; "Sales Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Order Line No.', comment = 'DEA="Verkaufsauftragszeilennr."';
            Editable = false;
        }
        field(73; "Drop Shipment"; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment', comment = 'DEA="Direktlieferung"';
            Editable = false;
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Geschäftsbuchungsgruppe"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Prod. Posting Group', comment = 'DEA="Produktbuchungsgruppe"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Calculation Type', comment = 'DEA="MwSt.-Berechnungsart"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Type', comment = 'DEA="Art des Geschäftes"';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transport Method', comment = 'DEA="Verkehrszweig"';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Attached to Line No.', comment = 'DEA="Gehört zu Zeilennr."';
            Editable = false;
            TableRelation = "Purchase Line"."Line No." where("Document Type" = field("Document Type"),
                                                              "Document No." = field("Document No."));
        }
        field(81; "Entry Point"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Entry Point', comment = 'DEA="Entladehafen"';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Area', comment = 'DEA="Bestimmungsregion"';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction Specification', comment = 'DEA="Verfahren"';
            TableRelation = "Transaction Specification";
        }
        field(85; "Tax Area Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Area Code', comment = 'DEA="Steuergebietscode"';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Liable', comment = 'DEA="Steuerpflichtig"';
        }
        field(87; "Tax Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Tax Group Code', comment = 'DEA="Steuergruppencode"';
            TableRelation = "Tax Group";
        }
        field(88; "Use Tax"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Use Tax', comment = 'DEA="Verbrauchssteuer"';
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Bus. Posting Group', comment = 'DEA="MwSt.-Geschäftsbuchungsgruppe"';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Prod. Posting Group', comment = 'DEA="MwSt.-Produktbuchungsgruppe"';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Currency Code', comment = 'DEA="Währungscode"';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)', comment = 'DEA="Restbestellbetrag (MW)"';
            Editable = false;
        }
        field(93; "Amt. Rcd. Not Invoiced (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            AutoFormatType = 1;
            Caption = 'Amt. Rcd. Not Invoiced (LCY)', comment = 'DEA="Nicht fakt. Lieferbetrag (MW)"';
            Editable = false;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            CalcFormula = sum("Reservation Entry".Quantity where("Source ID" = field("Document No."),
                                                                  "Source Ref. No." = field("Line No."),
                                                                  "Source Type" = const(39),
                                                                  "Source Subtype" = field("Document Type"),
                                                                  "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Quantity', comment = 'DEA="Reservierte Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order No.', comment = 'DEA="Rahmenbestellungsnr."';
            TableRelation = "Purchase Header"."No." where("Document Type" = const("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Blanket Order Line No.', comment = 'DEA="Rahmenbestellungszeilennr."';
            TableRelation = "Purchase Line"."Line No." where("Document Type" = const("Blanket Order"),
                                                              "Document No." = field("Blanket Order No."));
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount', comment = 'DEA="MwSt.-Bemessungsgrundlage"';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost', comment = 'DEA="Einstandspreis"';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'System-Created Entry', comment = 'DEA="Systembuchung"';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount', comment = 'DEA="Zeilenbetrag"';
        }
        field(104; "VAT Difference"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference', comment = 'DEA="MwSt.-Differenz"';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice', comment = 'DEA="Rech.-Rabattbetrag akt. Rech."';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Identifier', comment = 'DEA="MwSt.-Kennzeichen"';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "IC G/L Account" = R;
            Caption = 'IC Partner Ref. Type', comment = 'DEA="IC-Partnerref.-Art"';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.,Vendor Item No.', comment = 'DEA=" ,Sachkonto,Artikel,,,Zu-/Abschlag (Artikel),Referenz,Gemeinsame Artikelnr.,Kred.-Artikelnr."';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.","Vendor Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "IC G/L Account" = R;
            Caption = 'IC Partner Reference', comment = 'DEA="IC-Partnerreferenz"';
        }
        field(109; "Prepayment %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment %', comment = 'DEA="Vorauszahlung %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Line Amount', comment = 'DEA="Vorauszahlungszeilenbetrag"';
            MinValue = 0;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Inv.', comment = 'DEA="Fakt. Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT', comment = 'DEA="Vorauszahlungsbetrag einschl. MwSt"';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount', comment = 'DEA="Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.', comment = 'DEA="MwSt.-Bemessungsgrundlage Vorauszahlung"';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment VAT %', comment = 'DEA="MwSt % Vorauszahlung"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. VAT Calc. Type', comment = 'DEA="MwSt.-Berechnungsart Vorauszahlung"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(117; "Prepayment VAT Identifier"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment VAT Identifier', comment = 'DEA="MwSt-Kennzeichen Vorauszahlung"';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Tax Area Code', comment = 'DEA="Steuergebietscode Vorauszahlung"';
            TableRelation = "Tax Area";
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Tax Liable', comment = 'DEA="Steuerpflichtige Vorauszahlung"';
        }
        field(120; "Prepayment Tax Group Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Tax Group Code', comment = 'DEA="Steuergruppencode Vorauszahlung"';
            TableRelation = "Tax Group";
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt to Deduct"));
            Caption = 'Prepmt Amt to Deduct', comment = 'DEA="Abzuziehender Vorauszahlungsbetrag"';
            MinValue = 0;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt Deducted"));
            Caption = 'Prepmt Amt Deducted', comment = 'DEA="Abgezogener Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepayment Line', comment = 'DEA="Vorauszahlungszeile"';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT', comment = 'DEA="Fakt. Vorauszahlungsbetrag einschl. MwSt."';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)', comment = 'DEA="Fakt. Vorauszahlungsbetrag (MW)"';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'IC Partner Code', comment = 'DEA="IC-Partnercode"';
            TableRelation = "IC Partner";
        }
        field(132; "Prepmt. VAT Amount Inv. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Prepmt. VAT Amount Inv. (LCY)', comment = 'DEA="Fakt. MwSt.-Vorauszahlungsbetrag (MW)"';
            Editable = false;
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference', comment = 'DEA="MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct', comment = 'DEA="Abzuziehende MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted', comment = 'DEA="Abgezogene MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        field(140; "Outstanding Amt. Ex. VAT (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Amt. Ex. VAT (LCY)', comment = 'DEA="Restauftragsbetrag ohne MwSt. (MW)"';
        }
        field(141; "A. Rcd. Not Inv. Ex. VAT (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'A. Rcd. Not Inv. Ex. VAT (LCY)', comment = 'DEA="Nicht fakt. Lieferbetrag ohne MwSt. (MW)"';
        }
        field(480; "Dimension Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Set ID', comment = 'DEA="Dimensionssatz-ID"';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(1001; "Job Task No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Task No.', comment = 'DEA="Projektaufgabennr."';
            TableRelation = "Job Task"."Job Task No." where("Job No." = field("Job No."));
        }
        field(1002; "Job Line Type"; Option)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            Caption = 'Job Line Type', comment = 'DEA="Projektzeilenart"';
            OptionCaption = ' ,Budget,Billable,Both Budget and Billable', comment = 'DEA=" ,Budget,Fakturierbar,Budget und Fakturierbar"';
            OptionMembers = " ",Budget,Billable,"Both Budget and Billable";
        }
        field(1003; "Job Unit Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Unit Price', comment = 'DEA="VK-Preis Projekt"';
        }
        field(1004; "Job Total Price"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Total Price', comment = 'DEA="Verkaufsbetrag Projekt"';
            Editable = false;
        }
        field(1005; "Job Line Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount', comment = 'DEA="Zeilenbetrag Projekt"';
        }
        field(1006; "Job Line Discount Amount"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            AutoFormatExpression = "Job Currency Code";
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Discount Amount', comment = 'DEA="Zeilenrabattbetrag Projekt"';
        }
        field(1007; "Job Line Discount %"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Line Discount %', comment = 'DEA="Zeilenrabatt % Projekt"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(1008; "Job Unit Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Unit Price (LCY)', comment = 'DEA="VK-Preis Projekt (MW)"';
            Editable = false;
        }
        field(1009; "Job Total Price (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Total Price (LCY)', comment = 'DEA="Verkaufsbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1010; "Job Line Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Amount (LCY)', comment = 'DEA="Zeilenbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1011; "Job Line Disc. Amount (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            AutoFormatType = 1;
            BlankZero = true;
            Caption = 'Job Line Disc. Amount (LCY)', comment = 'DEA="Zeilenrabattbetrag Projekt (MW)"';
            Editable = false;
        }
        field(1012; "Job Currency Factor"; Decimal)
        {
            DataClassification = CustomerContent;
            BlankZero = true;
            Caption = 'Job Currency Factor', comment = 'DEA="Währungsfaktor Projekt"';
        }
        field(1013; "Job Currency Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Job Currency Code', comment = 'DEA="Währungscode Projekt"';
        }
        field(1019; "Job Planning Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            BlankZero = true;
            Caption = 'Job Planning Line No.', comment = 'DEA="Projektplanzeilennr."';

            trigger OnLookup()
            var
                JobPlanningLine: Record "Job Planning Line";
            begin
                JobPlanningLine.SetRange("Job No.", "Job No.");
                JobPlanningLine.SetRange("Job Task No.", "Job Task No.");
                case Type of
                    Type::"G/L Account":
                        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::"G/L Account");
                    Type::Item:
                        JobPlanningLine.SetRange(Type, JobPlanningLine.Type::Item);
                end;
                JobPlanningLine.SetRange("No.", "No.");
                JobPlanningLine.SetRange("Usage Link", true);
                JobPlanningLine.SetRange("System-Created Entry", false);

                if Page.RunModal(0, JobPlanningLine) = Action::LookupOK then
                    Validate("Job Planning Line No.", JobPlanningLine."Line No.");
            end;
        }
        field(1030; "Job Remaining Qty."; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Job = R;
            Caption = 'Job Remaining Qty.', comment = 'DEA="Verbleibend für Projekt - Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(1031; "Job Remaining Qty. (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Job Remaining Qty. (Base)', comment = 'DEA="Verbleibend für Projekt - Menge (Basis)"';
        }
        field(1700; "Deferral Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Deferral Code', comment = 'DEA="Abgrenzungscode"';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(1702; "Returns Deferral Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Returns Deferral Start Date', comment = 'DEA="Gibt Abgrenzungsstartdatum zurück"';
        }
        field(5401; "Prod. Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Machine Center" = R;
            Caption = 'Prod. Order No.', comment = 'DEA="FA-Nr."';
            Editable = false;
            TableRelation = "Production Order"."No." where(Status = const(Released));
            ValidateTableRelation = false;
        }
        field(5402; "Variant Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Variant Code', comment = 'DEA="Variantencode"';
            TableRelation = if (Type = const(Item)) "Item Variant".Code where("Item No." = field("No."));

        }
        field(5403; "Bin Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Bin Code', comment = 'DEA="Lagerplatzcode"';
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. per Unit of Measure', comment = 'DEA="Menge pro Einheit"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure Code', comment = 'DEA="Einheitencode"';
            TableRelation = if (Type = const(Item),
                                "No." = filter(<> '')) "Item Unit of Measure".Code where("Item No." = field("No."))
            else
            "Unit of Measure";

        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Quantity (Base)', comment = 'DEA="Menge (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Outstanding Qty. (Base)', comment = 'DEA="Restbestellungsmenge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Invoice (Base)', comment = 'DEA="Menge akt. Rechnung (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Receive (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. to Receive (Base)', comment = 'DEA="Menge akt. Lieferung (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Rcd. Not Invoiced (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Rcd. Not Invoiced (Base)', comment = 'DEA="Lief. nicht fakt. Menge(Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Received (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Received (Base)', comment = 'DEA="Bereits gelief. Menge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Qty. Invoiced (Base)', comment = 'DEA="Bereits berech. Menge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            CalcFormula = sum("Reservation Entry"."Quantity (Base)" where("Source Type" = const(39),
                                                                           "Source Subtype" = field("Document Type"),
                                                                           "Source ID" = field("Document No."),
                                                                           "Source Ref. No." = field("Line No."),
                                                                           "Reservation Status" = const(Reservation)));
            Caption = 'Reserved Qty. (Base)', comment = 'DEA="Reservierte Menge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5600; "FA Posting Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'FA Posting Date', comment = 'DEA="Anlagedatum"';
        }
        field(5601; "FA Posting Type"; Option)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'FA Posting Type', comment = 'DEA="Anlagenbuchungsart"';
            OptionCaption = ' ,Acquisition Cost,Maintenance,,Appreciation', comment = 'DEA=" ,Anschaffung,Wartung"';
            OptionMembers = " ","Acquisition Cost",Maintenance,,Appreciation;
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Depreciation Book Code', comment = 'DEA="AfA Buchcode"';
            TableRelation = "Depreciation Book";
        }
        field(5603; "Salvage Value"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Salvage Value', comment = 'DEA="Restwert"';
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Depr. until FA Posting Date', comment = 'DEA="AfA bis Anlagedatum"';
        }
        field(5606; "Depr. Acquisition Cost"; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Depr. Acquisition Cost', comment = 'DEA="Rückw. AfA-Korr. b. Anschaff."';
        }
        field(5609; "Maintenance Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Maintenance Code', comment = 'DEA="Wartungscode"';
            TableRelation = Maintenance;
        }
        field(5610; "Insurance No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Insurance No.', comment = 'DEA="Versicherungsnr."';
            TableRelation = Insurance;
        }
        field(5611; "Budgeted FA No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Budgeted FA No.', comment = 'DEA="Plananlagennr."';
            TableRelation = "Fixed Asset";
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Duplicate in Depreciation Book', comment = 'DEA="In AfA-Buch kopieren"';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Fixed Asset" = R;
            Caption = 'Use Duplication List', comment = 'DEA="Kopiervorgang aktivieren"';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center', comment = 'DEA="Zuständigkeitseinheitencode"';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Item Cross Reference" = R;
            Caption = 'Cross-Reference No.', comment = 'DEA="Referenznr.';
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Unit of Measure (Cross Ref.)', comment = 'DEA="Einheit (Referenz)"';
            TableRelation = if (Type = const(Item)) "Item Unit of Measure".Code where("Item No." = field("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference Type', comment = 'DEA="Referenzart"';
            OptionCaption = ' ,Customer,Vendor,Bar Code', comment = 'DEA=" ,Debitor,Kreditor,Barcode"';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            DataClassification = CustomerContent;
            Caption = 'Cross-Reference Type No.', comment = 'DEA="Referenzartennr."';
        }
        field(5709; "Item Category Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Item Category Code', comment = 'DEA="Artikelkategoriencode"';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Nonstock Item" = R;
            Caption = 'Catalog', comment = 'DEA="Katalogartikel"';
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchasing Code', comment = 'DEA="Einkaufscode"';
            Editable = false;
            TableRelation = Purchasing;
        }
        field(5713; "Special Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Special Order', comment = 'DEA="Spezialauftrag"';
        }
        field(5714; "Special Order Sales No."; Code[20])
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Sales No.', comment = 'DEA="Spezialauftrag-Auftragsnr."';
            TableRelation = if ("Special Order" = const(true)) "Sales Header"."No." where("Document Type" = const(Order));
        }
        field(5715; "Special Order Sales Line No."; Integer)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Sales Line No.', comment = 'DEA="Spezialauftrag-Verk.-Zeilennr."';
            TableRelation = if ("Special Order" = const(true)) "Sales Line"."Line No." where("Document Type" = const(Order),
                                                                                            "Document No." = field("Special Order Sales No."));
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            AccessByPermission = tabledata Location = R;
            BlankZero = true;
            CalcFormula = sum("Warehouse Receipt Line"."Qty. Outstanding (Base)" where("Source Type" = const(39),
                                                                                        "Source Subtype" = field("Document Type"),
                                                                                        "Source No." = field("Document No."),
                                                                                        "Source Line No." = field("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)', comment = 'DEA="Lagerrestbestellmenge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Received"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Completely Received', comment = 'DEA="Komplettlieferung (Eingang)"';
            Editable = false;
        }
        field(5790; "Requested Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Requested Receipt Date', comment = 'DEA="Gewünschtes Wareneingangsdatum"';
        }
        field(5791; "Promised Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Order Promising Line" = R;
            Caption = 'Promised Receipt Date', comment = 'DEA="Zugesagtes Wareneingangsdatum"';
        }
        field(5792; "Lead Time Calculation"; DateFormula)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Lead Time Calculation', comment = 'DEA="Beschaffungszeit"';
        }
        field(5793; "Inbound Whse. Handling Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata Location = R;
            Caption = 'Inbound Whse. Handling Time', comment = 'DEA="Eingeh. Lagerdurchlaufzeit"';
        }
        field(5794; "Planned Receipt Date"; Date)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Order Promising Line" = R;
            Caption = 'Planned Receipt Date', comment = 'DEA="Geplantes Wareneingangsdatum"';
        }
        field(5795; "Order Date"; Date)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Purch. Rcpt. Header" = R;
            Caption = 'Order Date', comment = 'DEA="Bestelldatum"';
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Item Charge" = R;
            Caption = 'Allow Item Charge Assignment', comment = 'DEA="Artikel Zu-/Abschlagszuw. zul."';
            InitValue = true;
        }
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Purch)"."Qty. to Assign" where("Document Type" = field("Document Type"),
                                                                                       "Document No." = field("Document No."),
                                                                                       "Document Line No." = field("Line No.")));
            Caption = 'Qty. to Assign', comment = 'DEA="Menge für Zuweisung"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = sum("Item Charge Assignment (Purch)"."Qty. Assigned" where("Document Type" = field("Document Type"),
                                                                                      "Document No." = field("Document No."),
                                                                                      "Document Line No." = field("Line No.")));
            Caption = 'Qty. Assigned', comment = 'DEA="Zugewiesene Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5803; "Return Qty. to Ship"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Return Shipment Header" = R;
            Caption = 'Return Qty. to Ship', comment = 'DEA="Rücklieferungsmenge zu liefern"';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Ship (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Return Qty. to Ship (Base)', comment = 'DEA="Rücklief.-Mge. zu lief.(Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Shipped Not Invd."; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Return Qty. Shipped Not Invd.', comment = 'DEA="Rücklief.-Menge Lief. n. fakt."';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5806; "Ret. Qty. Shpd Not Invd.(Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Ret. Qty. Shpd Not Invd.(Base)', comment = 'DEA="Rückl.-Mge. Lief.n.fak.(Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5807; "Return Shpd. Not Invd."; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd.', comment = 'DEA=""';
            Editable = false;
        }
        field(5808; "Return Shpd. Not Invd. (LCY)"; Decimal)
        {
            DataClassification = CustomerContent;
            AutoFormatType = 1;
            Caption = 'Return Shpd. Not Invd. (LCY)', comment = 'DEA="Lief. n. fakt. Rückl.-Betrag"';
            Editable = false;
        }
        field(5809; "Return Qty. Shipped"; Decimal)
        {
            DataClassification = CustomerContent;
            AccessByPermission = tabledata "Return Shipment Header" = R;
            Caption = 'Return Qty. Shipped', comment = 'DEA="Rücklieferungsmenge geliefert"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5810; "Return Qty. Shipped (Base)"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Return Qty. Shipped (Base)', comment = 'DEA="Rücklief.-Menge gelief.(Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(6600; "Return Shipment No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Shipment No.', comment = 'DEA="Rücklieferungsnr."';
            Editable = false;
        }
        field(6601; "Return Shipment Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Return Shipment Line No.', comment = 'DEA="Rücklieferzeilennr."';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Return Reason Code', comment = 'DEA="Reklamationsgrundcode"';
            TableRelation = "Return Reason";
        }
        field(6609; Subtype; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Subtype', comment = 'DEA="Unterart"';
            OptionCaption = ' ,Item - Inventory,Item - Service,Comment', comment = 'DEA=" ,Artikel - Lagerbestand,Artikel - Dienstleistung,Kommentar"';
            OptionMembers = " ","Item - Inventory","Item - Service",Comment;
        }
        field(6610; "Copied From Posted Doc."; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Copied From Posted Doc.', comment = 'DEA="Copied From Posted Doc."';
        }
        field(5005396; "Order No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Order No.', comment = 'DEA="Auftragsnr."';
        }
        field(5005397; "Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Order Line No.', comment = 'DEA="Auftragszeilennr."';
            // ObsoleteReason = 'Merged to W1';
            // ObsoleteState = Pending;
        }
        field(99000750; "Routing No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Routing No.', comment = 'DEA="Arbeitsplannr."';
            TableRelation = "Routing Header";
        }
        field(99000751; "Operation No."; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Operation No.', comment = 'DEA="Arbeitsgangnr."';
            Editable = false;
            TableRelation = "Prod. Order Routing Line"."Operation No." where(Status = const(Released),
                                                                              "Prod. Order No." = field("Prod. Order No."),
                                                                              "Routing No." = field("Routing No."));
        }
        field(99000752; "Work Center No."; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Work Center No.', comment = 'DEA="Arbeitsplatzgruppennr."';
            Editable = false;
            TableRelation = "Work Center";
        }
        field(99000753; Finished; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Finished', comment = 'DEA="Beendet"';
        }
        field(99000754; "Prod. Order Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Prod. Order Line No.', comment = 'DEA="FA-Zeilennr."';
            Editable = false;
            TableRelation = "Prod. Order Line"."Line No." where(Status = filter(Released ..),
                                                                 "Prod. Order No." = field("Prod. Order No."));
        }
        field(99000755; "Overhead Rate"; Decimal)
        {
            DataClassification = CustomerContent;
            Caption = 'Overhead Rate', comment = 'DEA="Gemeinkostensatz"';
            DecimalPlaces = 0 : 5;

            trigger OnValidate()
            begin
                Validate("Indirect Cost %");
            end;
        }
        field(99000756; "MPS Order"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'MPS Order', comment = 'DEA="Prod.-Programmplanungsauftrag"';
        }
        field(99000757; "Planning Flexibility"; Option)
        {
            DataClassification = CustomerContent;
            Caption = 'Planning Flexibility', comment = 'DEA="Planungsflexibilität"';
            OptionCaption = 'Unlimited,None', comment = 'DEA="Unbeschränkt,Keine"';
            OptionMembers = Unlimited,None;
        }
        field(99000758; "Safety Lead Time"; DateFormula)
        {
            DataClassification = CustomerContent;
            Caption = 'Safety Lead Time', comment = 'DEA="Sicherh.-Zuschl. Beschaff.-Zt."';
        }
        field(99000759; "Routing Reference No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Routing Reference No.', comment = 'DEA="Arbeitsplanref.-Nr."';
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
        field(50020; "Gen. Bus. Posting Group Desc"; Text[100])
        {
            Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Geschäftsbuchungsgruppe Beschreibung"';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Gen. Business Posting Group".Description where(Code = field("Gen. Bus. Posting Group")));
        }
        field(50025; "Purchase Shortcut Dimension 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            // CaptionClass = '1338,1'; = Sales + Dim Name
            // CaptionClass = '1339,1'; = Purchase + Dim Name
        }
        field(50026; "Purchase Shortcut Dimension 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            // CaptionClass = '1338,3'; = Sales + Dim Name
            // CaptionClass = '1339,3'; = Purchase + Dim Name            
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(50035; "Deactivate dimensional distr"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Deactivate dimensional distribution', comment = 'DEA="Verteilung deaktiviert"';
        }
        field(50050; "Origin Line No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'EnglishText', comment = 'DEA=""';
        }
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
}