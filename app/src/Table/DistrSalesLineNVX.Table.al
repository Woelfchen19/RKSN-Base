table 50035 DistrSalesLineNVX
{
    Caption = 'Sales Line', comment = 'DEA="Verkaufszeile';
    DrillDownPageID = "Sales Lines";
    LookupPageID = "Sales Lines";

    fields
    {
        field(1; "Document Type"; Option)
        {
            Caption = 'Document Type', comment = 'DEA="Belegart"';
            OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order', comment = 'DEA="Angebot,Auftrag,Rechnung,Gutschrift,Rahmenauftrag,Reklamation"';
            OptionMembers = Quote,"Order",Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(2; "Sell-to Customer No."; Code[20])
        {
            Caption = 'Sell-to Customer No.', comment = 'DEA="Verk. an Deb.-Nr."';
            Editable = false;
            TableRelation = Customer;
        }
        field(3; "Document No."; Code[20])
        {
            Caption = 'Document No.', comment = 'DEA="Belegnr."';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = FIELD("Document Type"));
        }
        field(4; "Line No."; Integer)
        {
            Caption = 'Line No.', comment = 'DEA="Zeilennr."';
        }
        field(5; Type; Option)
        {
            Caption = 'Type', comment = 'DEA="Art"';
            OptionCaption = ' ,G/L Account,Item,Resource,Fixed Asset,Charge (Item)', comment = 'DEA=" ,Sachkonto,Artikel,Ressource,WG/Anlage,Zu-/Abschlag (Artikel)"';
            OptionMembers = " ","G/L Account",Item,Resource,"Fixed Asset","Charge (Item)";
        }
        field(6; "No."; Code[20])
        {
            // CaptionClass = GetCaptionClass(FieldNo("No."));
            Caption = 'No.', comment = 'DEA="Nr."';
            TableRelation = IF (Type = CONST(" ")) "Standard Text"
            ELSE
            IF (Type = CONST("G/L Account"),
                                     "System-Created Entry" = CONST(false)) "G/L Account" WHERE("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account"
            ELSE
            IF (Type = CONST(Resource)) Resource
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset"
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge"
            ELSE
            IF (Type = CONST(Item),
                                                                                                                 "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Item),
                                                                                                                                                                                                "Document Type" = FILTER("Credit Memo" | "Return Order")) Item WHERE(Blocked = CONST(false));
            ValidateTableRelation = false;
        }
        field(7; "Location Code"; Code[10])
        {
            Caption = 'Location Code', comment = 'DEA="Lagerortcode"';
            TableRelation = Location WHERE("Use As In-Transit" = CONST(false));
        }
        field(8; "Posting Group"; Code[20])
        {
            Caption = 'Posting Group', comment = 'DEA="Buchungsgruppe"';
            Editable = false;
            TableRelation = IF (Type = CONST(Item)) "Inventory Posting Group"
            ELSE
            IF (Type = CONST("Fixed Asset")) "FA Posting Group";
        }
        field(10; "Shipment Date"; Date)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Shipment Date', comment = 'DEA="Warenausg.-Datum"';
        }
        field(11; Description; Text[100])
        {
            Caption = 'Description', comment = 'DEA="Beschreibung"';
            TableRelation = IF (Type = CONST("G/L Account"),
                                "System-Created Entry" = CONST(false)) "G/L Account".Name WHERE("Direct Posting" = CONST(true),
                                                                                               "Account Type" = CONST(Posting),
                                                                                               Blocked = CONST(false))
            ELSE
            IF (Type = CONST("G/L Account"),
                                                                                                        "System-Created Entry" = CONST(true)) "G/L Account".Name
            ELSE
            IF (Type = CONST(Item),
                                                                                                                 "Document Type" = FILTER(<> "Credit Memo" & <> "Return Order")) Item.Description WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Item),
                                                                                                                                                                                                            "Document Type" = FILTER("Credit Memo" | "Return Order")) Item.Description WHERE(Blocked = CONST(false))
            ELSE
            IF (Type = CONST(Resource)) Resource.Name
            ELSE
            IF (Type = CONST("Fixed Asset")) "Fixed Asset".Description
            ELSE
            IF (Type = CONST("Charge (Item)")) "Item Charge".Description;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(12; "Description 2"; Text[50])
        {
            Caption = 'Description 2', comment = 'DEA="Beschreibung 2"';
        }
        field(13; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure', comment = 'DEA="Einheit"';
            TableRelation = IF (Type = FILTER(<> " ")) "Unit of Measure".Description;
            //This property is currently not supported
            //TestTableRelation = false;
            ValidateTableRelation = false;
        }
        field(15; Quantity; Decimal)
        {
            Caption = 'Quantity', comment = 'DEA="Menge"';
            DecimalPlaces = 0 : 5;
        }
        field(16; "Outstanding Quantity"; Decimal)
        {
            Caption = 'Outstanding Quantity', comment = 'DEA="Restauftragsmenge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(17; "Qty. to Invoice"; Decimal)
        {
            Caption = 'Qty. to Invoice', comment = 'DEA="Zu fakturieren"';
            DecimalPlaces = 0 : 5;
        }
        field(18; "Qty. to Ship"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Qty. to Ship', comment = 'DEA="Zu liefern"';
            DecimalPlaces = 0 : 5;
        }
        field(22; "Unit Price"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            // CaptionClass = GetCaptionClass(FieldNo("Unit Price"));
            Caption = 'Unit Price', comment = 'DEA="VK-Preis"';
        }
        field(23; "Unit Cost (LCY)"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Cost (LCY)', comment = 'DEA="Einstandspreis (MW)"';
        }
        field(25; "VAT %"; Decimal)
        {
            Caption = 'VAT %', comment = 'DEA="MwSt. %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(27; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %', comment = 'DEA="Zeilenrabatt %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(28; "Line Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Line Discount Amount', comment = 'DEA="Zeilenrabattbetrag"';
        }
        field(29; Amount; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount', comment = 'DEA="Betrag"';
            Editable = false;
        }
        field(30; "Amount Including VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Amount Including VAT', comment = 'DEA="Betrag inkl. MwSt."';
            Editable = false;
        }
        field(32; "Allow Invoice Disc."; Boolean)
        {
            Caption = 'Allow Invoice Disc.', comment = 'DEA="Rech.-Rabatt zulassen"';
            InitValue = true;
        }
        field(34; "Gross Weight"; Decimal)
        {
            Caption = 'Gross Weight', comment = 'DEA="Bruttogewicht"';
            DecimalPlaces = 0 : 5;
        }
        field(35; "Net Weight"; Decimal)
        {
            Caption = 'Net Weight', comment = 'DEA="Nettogewicht"';
            DecimalPlaces = 0 : 5;
        }
        field(36; "Units per Parcel"; Decimal)
        {
            Caption = 'Units per Parcel', comment = 'DEA="Anzahl pro Paket"';
            DecimalPlaces = 0 : 5;
        }
        field(37; "Unit Volume"; Decimal)
        {
            Caption = 'Unit Volume', comment = 'DEA="Volumen"';
            DecimalPlaces = 0 : 5;
        }
        field(38; "Appl.-to Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-to Item Entry', comment = 'DEA="Ausgleich mit Artikelposten"';
        }
        field(40; "Shortcut Dimension 1 Code"; Code[20])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1),
                                                          Blocked = CONST(false));
        }
        field(41; "Shortcut Dimension 2 Code"; Code[20])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Shortcutdimensionscode 2"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2),
                                                          Blocked = CONST(false));
        }
        field(42; "Customer Price Group"; Code[10])
        {
            Caption = 'Customer Price Group', comment = 'DEA="Debitorenpreisgruppe"';
            Editable = false;
            TableRelation = "Customer Price Group";
        }
        field(45; "Job No."; Code[20])
        {
            Caption = 'Job No.', comment = 'DEA="Projektnr."';
            Editable = false;
            TableRelation = Job;
        }
        field(52; "Work Type Code"; Code[10])
        {
            Caption = 'Work Type Code', comment = 'DEA="Arbeitstypencode"';
            TableRelation = "Work Type";
        }
        field(56; "Recalculate Invoice Disc."; Boolean)
        {
            Caption = 'Recalculate Invoice Disc.', comment = 'DEA="Rechnungsrabatt neu berechnen"';
            Editable = false;
        }
        field(57; "Outstanding Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Outstanding Amount', comment = 'DEA="Restauftragsbetrag"';
            Editable = false;
        }
        field(58; "Qty. Shipped Not Invoiced"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invoiced', comment = 'DEA="Lief. nicht fakt. Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(59; "Shipped Not Invoiced"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced', comment = 'DEA="Lief. nicht fakt. Betrag"';
            Editable = false;
        }
        field(60; "Quantity Shipped"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Quantity Shipped', comment = 'DEA="Menge geliefert"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(61; "Quantity Invoiced"; Decimal)
        {
            Caption = 'Quantity Invoiced', comment = 'DEA="Menge fakturiert"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(63; "Shipment No."; Code[20])
        {
            Caption = 'Shipment No.', comment = 'DEA="Lieferungsnr."';
            Editable = false;
        }
        field(64; "Shipment Line No."; Integer)
        {
            Caption = 'Shipment Line No.', comment = 'DEA="Lieferzeilennr."';
            Editable = false;
        }
        field(67; "Profit %"; Decimal)
        {
            Caption = 'Profit %', comment = 'DEA="DB %"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(68; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.', comment = 'DEA="Rech. an Deb.-Nr."';
            Editable = false;
            TableRelation = Customer;
        }
        field(69; "Inv. Discount Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Inv. Discount Amount"));
            Caption = 'Inv. Discount Amount', comment = 'DEA="Rechnungsrabattbetrag"';
            Editable = false;
        }
        field(71; "Purchase Order No."; Code[20])
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Purchase Order No.', comment = 'DEA="Bestellungsnr."';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(72; "Purch. Order Line No."; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Purch. Order Line No.', comment = 'DEA="Bestellungszeilennr."';
            Editable = false;
            TableRelation = IF ("Drop Shipment" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Purchase Order No."));
        }
        field(73; "Drop Shipment"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Drop Shipment', comment = 'DEA="Direktlieferung"';
            Editable = true;
        }
        field(74; "Gen. Bus. Posting Group"; Code[20])
        {
            Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Geschäftsbuchungsgruppe"';
            TableRelation = "Gen. Business Posting Group";
        }
        field(75; "Gen. Prod. Posting Group"; Code[20])
        {
            Caption = 'Gen. Prod. Posting Group', comment = 'DEA="Produktbuchungsgruppe"';
            TableRelation = "Gen. Product Posting Group";
        }
        field(77; "VAT Calculation Type"; Option)
        {
            Caption = 'VAT Calculation Type', comment = 'DEA="MwSt.-Berechnungsart"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(78; "Transaction Type"; Code[10])
        {
            Caption = 'Transaction Type', comment = 'DEA="Art des Geschäftes"';
            TableRelation = "Transaction Type";
        }
        field(79; "Transport Method"; Code[10])
        {
            Caption = 'Transport Method', comment = 'DEA="Verkehrszweig"';
            TableRelation = "Transport Method";
        }
        field(80; "Attached to Line No."; Integer)
        {
            Caption = 'Attached to Line No.', comment = 'DEA="Gehört zu Zeilennr."';
            Editable = false;
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = FIELD("Document Type"),
                                                           "Document No." = FIELD("Document No."));
        }
        field(81; "Exit Point"; Code[10])
        {
            Caption = 'Exit Point', comment = 'DEA="Einladehafen"';
            TableRelation = "Entry/Exit Point";
        }
        field(82; "Area"; Code[10])
        {
            Caption = 'Area', comment = 'DEA="Ursprungsregion"';
            TableRelation = Area;
        }
        field(83; "Transaction Specification"; Code[10])
        {
            Caption = 'Transaction Specification', comment = 'DEA="Verfahren"';
            TableRelation = "Transaction Specification";
        }
        field(84; "Tax Category"; Code[10])
        {
            Caption = 'Tax Category', comment = 'DEA="Steuerkategorie"';
        }
        field(85; "Tax Area Code"; Code[20])
        {
            Caption = 'Tax Area Code', comment = 'DEA="Steuergebietscode"';
            TableRelation = "Tax Area";
        }
        field(86; "Tax Liable"; Boolean)
        {
            Caption = 'Tax Liable', comment = 'DEA="Steuerpflichtig"';
        }
        field(87; "Tax Group Code"; Code[20])
        {
            Caption = 'Tax Group Code', comment = 'DEA="Steuergruppencode"';
            TableRelation = "Tax Group";
        }
        field(88; "VAT Clause Code"; Code[20])
        {
            Caption = 'VAT Clause Code', comment = 'DEA="MwSt.-Klauselcode"';
            TableRelation = "VAT Clause";
        }
        field(89; "VAT Bus. Posting Group"; Code[20])
        {
            Caption = 'VAT Bus. Posting Group', comment = 'DEA="MwSt.-Geschäftsbuchungsgruppe"';
            TableRelation = "VAT Business Posting Group";
        }
        field(90; "VAT Prod. Posting Group"; Code[20])
        {
            Caption = 'VAT Prod. Posting Group', comment = 'DEA="MwSt.-Produktbuchungsgruppe"';
            TableRelation = "VAT Product Posting Group";
        }
        field(91; "Currency Code"; Code[10])
        {
            Caption = 'Currency Code', comment = 'DEA="Währungscode"';
            Editable = false;
            TableRelation = Currency;
        }
        field(92; "Outstanding Amount (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Outstanding Amount (LCY)', comment = 'DEA="Restauftragsbetrag (MW)"';
            Editable = false;
        }
        field(93; "Shipped Not Invoiced (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Shipped Not Invoiced (LCY) Incl. VAT', comment = 'DEA="Nicht fakturierte Lieferung (MW) inkl. MwSt."';
            Editable = false;
        }
        field(94; "Shipped Not Inv. (LCY) No VAT"; Decimal)
        {
            Caption = 'Shipped Not Invoiced (LCY)', comment = 'DEA="Nicht fakturierte Lieferung (MW)"';
            Editable = false;
            FieldClass = Normal;
        }
        field(95; "Reserved Quantity"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = - Sum ("Reservation Entry".Quantity WHERE("Source ID" = FIELD("Document No."),
                                                                   "Source Ref. No." = FIELD("Line No."),
                                                                   "Source Type" = CONST(37),
                                                                   "Source Subtype" = FIELD("Document Type"),
                                                                   "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Quantity', comment = 'DEA="Reservierte Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(96; Reserve; Option)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Reserve', comment = 'DEA="Reservieren"';
            OptionCaption = 'Never,Optional,Always', comment = 'DEA="Nie,Optional,Immer"';
            OptionMembers = Never,Optional,Always;
        }
        field(97; "Blanket Order No."; Code[20])
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Blanket Order No.', comment = 'DEA="Rahmenauftragsnr."';
            TableRelation = "Sales Header"."No." WHERE("Document Type" = CONST("Blanket Order"));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(98; "Blanket Order Line No."; Integer)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            Caption = 'Blanket Order Line No.', comment = 'DEA="Rahmenauftragszeilennr."';
            TableRelation = "Sales Line"."Line No." WHERE("Document Type" = CONST("Blanket Order"),
                                                           "Document No." = FIELD("Blanket Order No."));
            //This property is currently not supported
            //TestTableRelation = false;
        }
        field(99; "VAT Base Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Base Amount', comment = 'DEA="MwSt.-Bemessungsgrundlage"';
            Editable = false;
        }
        field(100; "Unit Cost"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 2;
            Caption = 'Unit Cost', comment = 'DEA="Einstandspreis"';
            Editable = false;
        }
        field(101; "System-Created Entry"; Boolean)
        {
            Caption = 'System-Created Entry', comment = 'DEA="Systembuchung"';
            Editable = false;
        }
        field(103; "Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Line Amount"));
            Caption = 'Line Amount', comment = 'DEA="Zeilenbetrag"';
        }
        field(104; "VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'VAT Difference', comment = 'DEA="MwSt.-Differenz"';
            Editable = false;
        }
        field(105; "Inv. Disc. Amount to Invoice"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Inv. Disc. Amount to Invoice', comment = 'DEA="Rechnungsrabattbetrag zu fakt."';
            Editable = false;
        }
        field(106; "VAT Identifier"; Code[20])
        {
            Caption = 'VAT Identifier', comment = 'DEA="MwSt.-Kennzeichen"';
            Editable = false;
        }
        field(107; "IC Partner Ref. Type"; Option)
        {
            AccessByPermission = TableData "IC G/L Account" = R;
            Caption = 'IC Partner Ref. Type', comment = 'DEA="IC-Partnerref.-Art"';
            OptionCaption = ' ,G/L Account,Item,,,Charge (Item),Cross Reference,Common Item No.', comment = 'DEA=" ,Sachkonto,Artikel,,,Zu-/Abschlag (Artikel),Referenz,Gemeinsame Artikelnr."';
            OptionMembers = " ","G/L Account",Item,,,"Charge (Item)","Cross Reference","Common Item No.";
        }
        field(108; "IC Partner Reference"; Code[20])
        {
            AccessByPermission = TableData "IC G/L Account" = R;
            Caption = 'IC Partner Reference', comment = 'DEA="IC-Partnerreferenz"';
        }
        field(109; "Prepayment %"; Decimal)
        {
            Caption = 'Prepayment %', comment = 'DEA="Vorauszahlung %"';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;
        }
        field(110; "Prepmt. Line Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt. Line Amount"));
            Caption = 'Prepmt. Line Amount', comment = 'DEA="Vorauszahlungszeilenbetrag"';
            MinValue = 0;
        }
        field(111; "Prepmt. Amt. Inv."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt. Amt. Inv."));
            Caption = 'Prepmt. Amt. Inv.', comment = 'DEA="Fakt. Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(112; "Prepmt. Amt. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amt. Incl. VAT', comment = 'DEA="Vorauszahlungsbetrag einschl. MwSt"';
            Editable = false;
        }
        field(113; "Prepayment Amount"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment Amount', comment = 'DEA="Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(114; "Prepmt. VAT Base Amt."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. VAT Base Amt.', comment = 'DEA="MwSt.-Bemessungsgrundlage Vorauszahlung"';
            Editable = false;
        }
        field(115; "Prepayment VAT %"; Decimal)
        {
            Caption = 'Prepayment VAT %', comment = 'DEA="MwSt % Vorauszahlung"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            MinValue = 0;
        }
        field(116; "Prepmt. VAT Calc. Type"; Option)
        {
            Caption = 'Prepmt. VAT Calc. Type', comment = 'DEA="MwSt.-Berechnungsart Vorauszahlung"';
            Editable = false;
            OptionCaption = 'Normal VAT,Reverse Charge VAT,Full VAT,Sales Tax', comment = 'DEA="Normale MwSt.,Erwerbsbesteuerung,Nur MwSt.,Verkaufssteuer"';
            OptionMembers = "Normal VAT","Reverse Charge VAT","Full VAT","Sales Tax";
        }
        field(117; "Prepayment VAT Identifier"; Code[20])
        {
            Caption = 'Prepayment VAT Identifier', comment = 'DEA="MwSt-Kennzeichen Vorauszahlung"';
            Editable = false;
        }
        field(118; "Prepayment Tax Area Code"; Code[20])
        {
            Caption = 'Prepayment Tax Area Code', comment = 'DEA="Steuergebietscode Vorauszahlung"';
            TableRelation = "Tax Area";
        }
        field(119; "Prepayment Tax Liable"; Boolean)
        {
            Caption = 'Prepayment Tax Liable', comment = 'DEA="Steuerpflichtige Vorauszahlung"';
        }
        field(120; "Prepayment Tax Group Code"; Code[20])
        {
            Caption = 'Prepayment Tax Group Code', comment = 'DEA="Steuergruppencode Vorauszahlung"';
            TableRelation = "Tax Group";
        }
        field(121; "Prepmt Amt to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt to Deduct"));
            Caption = 'Prepmt Amt to Deduct', comment = 'DEA="Abzuziehender Vorauszahlungsbetrag"';
            MinValue = 0;
        }
        field(122; "Prepmt Amt Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            // CaptionClass = GetCaptionClass(FieldNo("Prepmt Amt Deducted"));
            Caption = 'Prepmt Amt Deducted', comment = 'DEA="Abgezogener Vorauszahlungsbetrag"';
            Editable = false;
        }
        field(123; "Prepayment Line"; Boolean)
        {
            Caption = 'Prepayment Line', comment = 'DEA="Vorauszahlungszeile"';
            Editable = false;
        }
        field(124; "Prepmt. Amount Inv. Incl. VAT"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. Incl. VAT', comment = 'DEA="Fakt. Vorauszahlungsbetrag einschl. MwSt."';
            Editable = false;
        }
        field(129; "Prepmt. Amount Inv. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Prepmt. Amount Inv. (LCY)', comment = 'DEA="Fakt. Vorauszahlungsbetrag (MW)"';
            Editable = false;
        }
        field(130; "IC Partner Code"; Code[20])
        {
            Caption = 'IC Partner Code', comment = 'DEA="IC-Partnercode"';
            TableRelation = "IC Partner";
        }
        field(132; "Prepmt. VAT Amount Inv. (LCY)"; Decimal)
        {
            Caption = 'Prepmt. VAT Amount Inv. (LCY)', comment = 'DEA="Fakt. MwSt.-Vorauszahlungsbetrag (MW)"';
            Editable = false;
        }
        field(135; "Prepayment VAT Difference"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepayment VAT Difference', comment = 'DEA="MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        field(136; "Prepmt VAT Diff. to Deduct"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. to Deduct', comment = 'DEA="Abzuziehende MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        field(137; "Prepmt VAT Diff. Deducted"; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Prepmt VAT Diff. Deducted', comment = 'DEA="Abgezogene MwSt.-Differenz Vorauszahlung"';
            Editable = false;
        }
        // field(145; "Pmt. Discount Amount"; Decimal)
        // {
        //     AutoFormatExpression = "Currency Code";
        //     AutoFormatType = 1;
        //     Caption = 'Pmt. Discount Amount', comment = 'DEA=""';
        // }
        field(180; "Line Discount Calculation"; Option)
        {
            Caption = 'Line Discount Calculation', comment = 'DEA="Zeilenrabattberechnung"';
            OptionCaption = 'None,%,Amount', comment = 'DEA="Kein,%,Betrag"';
            OptionMembers = "None","%",Amount;
        }
        field(480; "Dimension Set ID"; Integer)
        {
            Caption = 'Dimension Set ID', comment = 'DEA="Dimensionssatz-ID"';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
        field(900; "Qty. to Assemble to Order"; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            Caption = 'Qty. to Assemble to Order', comment = 'DEA="Menge für Auftragsmontage"';
            DecimalPlaces = 0 : 5;
        }
        field(901; "Qty. to Asm. to Order (Base)"; Decimal)
        {
            Caption = 'Qty. to Asm. to Order (Base)', comment = 'DEA="Menge für Auftragsmontage (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(902; "ATO Whse. Outstanding Qty."; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            BlankZero = true;
            CalcFormula = Sum ("Warehouse Shipment Line"."Qty. Outstanding" WHERE("Source Type" = CONST(37),
                                                                                  "Source Subtype" = FIELD("Document Type"),
                                                                                  "Source No." = FIELD("Document No."),
                                                                                  "Source Line No." = FIELD("Line No."),
                                                                                  "Assemble to Order" = FILTER(true)));
            Caption = 'ATO Whse. Outstanding Qty.', comment = 'DEA="Auftragsmontage - Lagerrestbestellmenge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(903; "ATO Whse. Outstd. Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "BOM Component" = R;
            BlankZero = true;
            CalcFormula = Sum ("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37),
                                                                                         "Source Subtype" = FIELD("Document Type"),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No."),
                                                                                         "Assemble to Order" = FILTER(true)));
            Caption = 'ATO Whse. Outstd. Qty. (Base)', comment = 'DEA="Auftragsmontage - Lagerrestbestellmenge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(1001; "Job Task No."; Code[20])
        {
            Caption = 'Job Task No.', comment = 'DEA="Projektaufgabennr."';
            Editable = false;
            TableRelation = "Job Task"."Job Task No." WHERE("Job No." = FIELD("Job No."));
        }
        field(1002; "Job Contract Entry No."; Integer)
        {
            AccessByPermission = TableData Job = R;
            Caption = 'Job Contract Entry No.', comment = 'DEA="Projektvertragspostennr."';
            Editable = false;
        }
        // field(1300; "Posting Date"; Date)
        // {
        //     CalcFormula = Lookup ("Sales Header"."Posting Date" WHERE("Document Type" = FIELD("Document Type"),
        //                                                               "No." = FIELD("Document No.")));
        //     Caption = 'Posting Date', comment = 'DEA="Buchungsdatum"';
        //     FieldClass = FlowField;
        // }
        field(1700; "Deferral Code"; Code[10])
        {
            Caption = 'Deferral Code', comment = 'DEA="Abgrenzungscode"';
            TableRelation = "Deferral Template"."Deferral Code";
        }
        field(1702; "Returns Deferral Start Date"; Date)
        {
            Caption = 'Returns Deferral Start Date', comment = 'DEA="Gibt Abgrenzungsstartdatum zurück"';
        }
        field(5402; "Variant Code"; Code[10])
        {
            Caption = 'Variant Code', comment = 'DEA="Variantencode"';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("No."));
        }
        field(5403; "Bin Code"; Code[20])
        {
            Caption = 'Bin Code', comment = 'DEA="Lagerplatzcode"';
            TableRelation = IF ("Document Type" = FILTER(Order | Invoice),
                                Quantity = FILTER(>= 0),
                                "Qty. to Asm. to Order (Base)" = CONST(0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                         "Item No." = FIELD("No."),
                                                                                                         "Variant Code" = FIELD("Variant Code"))
            ELSE
            IF ("Document Type" = FILTER("Return Order" | "Credit Memo"),
                                                                                                                  Quantity = FILTER(< 0)) "Bin Content"."Bin Code" WHERE("Location Code" = FIELD("Location Code"),
                                                                                                                                                                       "Item No." = FIELD("No."),
                                                                                                                                                                       "Variant Code" = FIELD("Variant Code"))
            ELSE
            Bin.Code WHERE("Location Code" = FIELD("Location Code"));
        }
        field(5404; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure', comment = 'DEA="Menge pro Einheit"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            InitValue = 1;
        }
        field(5405; Planned; Boolean)
        {
            Caption = 'Planned', comment = 'DEA="Geplant"';
            Editable = false;
        }
        field(5407; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code', comment = 'DEA="Einheitencode"';
            TableRelation = IF (Type = CONST(Item),
                                "No." = FILTER(<> '')) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."))
            ELSE
            IF (Type = CONST(Resource),
                                         "No." = FILTER(<> '')) "Resource Unit of Measure".Code WHERE("Resource No." = FIELD("No."))
            ELSE
            "Unit of Measure";
        }
        field(5415; "Quantity (Base)"; Decimal)
        {
            Caption = 'Quantity (Base)', comment = 'DEA="Menge (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5416; "Outstanding Qty. (Base)"; Decimal)
        {
            Caption = 'Outstanding Qty. (Base)', comment = 'DEA="Restauftragsmenge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5417; "Qty. to Invoice (Base)"; Decimal)
        {
            Caption = 'Qty. to Invoice (Base)', comment = 'DEA="Zu fakturieren (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5418; "Qty. to Ship (Base)"; Decimal)
        {
            Caption = 'Qty. to Ship (Base)', comment = 'DEA="Zu liefern (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5458; "Qty. Shipped Not Invd. (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped Not Invd. (Base)', comment = 'DEA="Lief. nicht fakt. Menge(Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5460; "Qty. Shipped (Base)"; Decimal)
        {
            Caption = 'Qty. Shipped (Base)', comment = 'DEA="Menge geliefert (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5461; "Qty. Invoiced (Base)"; Decimal)
        {
            Caption = 'Qty. Invoiced (Base)', comment = 'DEA="Menge fakturiert (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5495; "Reserved Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData "Sales Shipment Header" = R;
            CalcFormula = - Sum ("Reservation Entry"."Quantity (Base)" WHERE("Source ID" = FIELD("Document No."),
                                                                            "Source Ref. No." = FIELD("Line No."),
                                                                            "Source Type" = CONST(37),
                                                                            "Source Subtype" = FIELD("Document Type"),
                                                                            "Reservation Status" = CONST(Reservation)));
            Caption = 'Reserved Qty. (Base)', comment = 'DEA="Reservierte Menge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5600; "FA Posting Date"; Date)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'FA Posting Date', comment = 'DEA="Anlagedatum"';
        }
        field(5602; "Depreciation Book Code"; Code[10])
        {
            Caption = 'Depreciation Book Code', comment = 'DEA="AfA Buchcode"';
            TableRelation = "Depreciation Book";
        }
        field(5605; "Depr. until FA Posting Date"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Depr. until FA Posting Date', comment = 'DEA="AfA bis Anlagedatum"';
        }
        field(5612; "Duplicate in Depreciation Book"; Code[10])
        {
            Caption = 'Duplicate in Depreciation Book', comment = 'DEA="In AfA-Buch kopieren"';
            TableRelation = "Depreciation Book";
        }
        field(5613; "Use Duplication List"; Boolean)
        {
            AccessByPermission = TableData "Fixed Asset" = R;
            Caption = 'Use Duplication List', comment = 'DEA="Kopiervorgang aktivieren"';
        }
        field(5700; "Responsibility Center"; Code[10])
        {
            Caption = 'Responsibility Center', comment = 'DEA="Zuständigkeitseinheitencode"';
            Editable = false;
            TableRelation = "Responsibility Center";
        }
        field(5701; "Out-of-Stock Substitution"; Boolean)
        {
            Caption = 'Out-of-Stock Substitution', comment = 'DEA="Ersatz da nicht am Lager"';
            Editable = false;
        }
        field(5702; "Substitution Available"; Boolean)
        {
            CalcFormula = Exist ("Item Substitution" WHERE(Type = CONST(Item),
                                                           "No." = FIELD("No."),
                                                           "Substitute Type" = CONST(Item)));
            Caption = 'Substitution Available', comment = 'DEA="Ersatzartikel verfügbar"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5703; "Originally Ordered No."; Code[20])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered No.', comment = 'DEA="Urspr. Nr. (Auftrag)"';
            TableRelation = IF (Type = CONST(Item)) Item;
        }
        field(5704; "Originally Ordered Var. Code"; Code[10])
        {
            AccessByPermission = TableData "Item Substitution" = R;
            Caption = 'Originally Ordered Var. Code', comment = 'DEA="Urspr. Variantencode (Auftrag)"';
            TableRelation = IF (Type = CONST(Item)) "Item Variant".Code WHERE("Item No." = FIELD("Originally Ordered No."));
        }
        field(5705; "Cross-Reference No."; Code[20])
        {
            AccessByPermission = TableData "Item Cross Reference" = R;
            Caption = 'Cross-Reference No.', comment = 'DEA="Referenznr."';
        }
        field(5706; "Unit of Measure (Cross Ref.)"; Code[10])
        {
            AccessByPermission = TableData "Item Cross Reference" = R;
            Caption = 'Unit of Measure (Cross Ref.)', comment = 'DEA="Einheit (Referenz)"';
            TableRelation = IF (Type = CONST(Item)) "Item Unit of Measure".Code WHERE("Item No." = FIELD("No."));
        }
        field(5707; "Cross-Reference Type"; Option)
        {
            Caption = 'Cross-Reference Type', comment = 'DEA="Referenzart"';
            OptionCaption = ' ,Customer,Vendor,Bar Code', comment = 'DEA=" ,Debitor,Kreditor,Barcode"';
            OptionMembers = " ",Customer,Vendor,"Bar Code";
        }
        field(5708; "Cross-Reference Type No."; Code[30])
        {
            Caption = 'Cross-Reference Type No.', comment = 'DEA="Referenzartennr."';
        }
        field(5709; "Item Category Code"; Code[20])
        {
            Caption = 'Item Category Code', comment = 'DEA="Artikelkategoriencode"';
            TableRelation = "Item Category";
        }
        field(5710; Nonstock; Boolean)
        {
            AccessByPermission = TableData "Nonstock Item" = R;
            Caption = 'Catalog', comment = 'DEA="Katalogartikel"';
            Editable = false;
        }
        field(5711; "Purchasing Code"; Code[10])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Purchasing Code', comment = 'DEA="Einkaufscode"';
            TableRelation = Purchasing;
        }
        // field(5712; "Product Group Code"; Code[10])
        // {
        //     Caption = 'Product Group Code', comment = 'DEA="Produktgruppencode"';
        //     ObsoleteReason = 'Product Groups became first level children of Item Categories.';
        //     ObsoleteState = Obsolete;
        //     TableRelation = "Product Group".Code WHERE("Item Category Code" = FIELD("Item Category Code"));
        //     ValidateTableRelation = false;
        // }
        field(5713; "Special Order"; Boolean)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order', comment = 'DEA="Spezialauftrag"';
            Editable = false;
        }
        field(5714; "Special Order Purchase No."; Code[20])
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Purchase No.', comment = 'DEA="Spezialauftrag-Bestellnr."';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Header"."No." WHERE("Document Type" = CONST(Order));
        }
        field(5715; "Special Order Purch. Line No."; Integer)
        {
            AccessByPermission = TableData "Drop Shpt. Post. Buffer" = R;
            Caption = 'Special Order Purch. Line No.', comment = 'DEA="Spezialauftrag-Eink.-Zeilennr."';
            TableRelation = IF ("Special Order" = CONST(true)) "Purchase Line"."Line No." WHERE("Document Type" = CONST(Order),
                                                                                               "Document No." = FIELD("Special Order Purchase No."));
        }
        field(5749; "Whse. Outstanding Qty."; Decimal)
        {
            AccessByPermission = TableData Location = R;
            BlankZero = true;
            CalcFormula = Sum ("Warehouse Shipment Line"."Qty. Outstanding" WHERE("Source Type" = CONST(37),
                                                                                  "Source Subtype" = FIELD("Document Type"),
                                                                                  "Source No." = FIELD("Document No."),
                                                                                  "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty.', comment = 'DEA="Lagerrestbestellmenge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5750; "Whse. Outstanding Qty. (Base)"; Decimal)
        {
            AccessByPermission = TableData Location = R;
            BlankZero = true;
            CalcFormula = Sum ("Warehouse Shipment Line"."Qty. Outstanding (Base)" WHERE("Source Type" = CONST(37),
                                                                                         "Source Subtype" = FIELD("Document Type"),
                                                                                         "Source No." = FIELD("Document No."),
                                                                                         "Source Line No." = FIELD("Line No.")));
            Caption = 'Whse. Outstanding Qty. (Base)', comment = 'DEA="Lagerrestbestellmenge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5752; "Completely Shipped"; Boolean)
        {
            Caption = 'Completely Shipped', comment = 'DEA="Komplettlieferung (Ausgang)"';
            Editable = false;
        }
        field(5790; "Requested Delivery Date"; Date)
        {
            Caption = 'Requested Delivery Date', comment = 'DEA="Gewünschtes Lieferdatum"';
        }
        field(5791; "Promised Delivery Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Promised Delivery Date', comment = 'DEA="Zugesagtes Lieferdatum"';
        }
        field(5792; "Shipping Time"; DateFormula)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Shipping Time', comment = 'DEA="Transportzeit"';
        }
        field(5793; "Outbound Whse. Handling Time"; DateFormula)
        {
            AccessByPermission = TableData Location = R;
            Caption = 'Outbound Whse. Handling Time', comment = 'DEA="Ausgeh. Lagerdurchlaufzeit"';
        }
        field(5794; "Planned Delivery Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Planned Delivery Date', comment = 'DEA="Geplantes Lieferdatum"';
        }
        field(5795; "Planned Shipment Date"; Date)
        {
            AccessByPermission = TableData "Order Promising Line" = R;
            Caption = 'Planned Shipment Date', comment = 'DEA="Geplantes Warenausgangsdatum"';
        }
        field(5796; "Shipping Agent Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Code', comment = 'DEA="Zustellercode"';
            TableRelation = "Shipping Agent";
        }
        field(5797; "Shipping Agent Service Code"; Code[10])
        {
            AccessByPermission = TableData "Shipping Agent Services" = R;
            Caption = 'Shipping Agent Service Code', comment = 'DEA="Zustellertransportartencode"';
            TableRelation = "Shipping Agent Services".Code WHERE("Shipping Agent Code" = FIELD("Shipping Agent Code"));
        }
        field(5800; "Allow Item Charge Assignment"; Boolean)
        {
            AccessByPermission = TableData "Item Charge" = R;
            Caption = 'Allow Item Charge Assignment', comment = 'DEA="Artikel Zu-/Abschlagszuw. zul."';
            InitValue = true;
        }
        field(5801; "Qty. to Assign"; Decimal)
        {
            CalcFormula = Sum ("Item Charge Assignment (Sales)"."Qty. to Assign" WHERE("Document Type" = FIELD("Document Type"),
                                                                                       "Document No." = FIELD("Document No."),
                                                                                       "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. to Assign', comment = 'DEA="Menge für Zuweisung"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5802; "Qty. Assigned"; Decimal)
        {
            CalcFormula = Sum ("Item Charge Assignment (Sales)"."Qty. Assigned" WHERE("Document Type" = FIELD("Document Type"),
                                                                                      "Document No." = FIELD("Document No."),
                                                                                      "Document Line No." = FIELD("Line No.")));
            Caption = 'Qty. Assigned', comment = 'DEA="Zugewiesene Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
            FieldClass = FlowField;
        }
        field(5803; "Return Qty. to Receive"; Decimal)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Return Qty. to Receive', comment = 'DEA="Menge akt. Rücksendung"';
            DecimalPlaces = 0 : 5;
        }
        field(5804; "Return Qty. to Receive (Base)"; Decimal)
        {
            Caption = 'Return Qty. to Receive (Base)', comment = 'DEA="Menge akt. Rücksendung (Basis)"';
            DecimalPlaces = 0 : 5;
        }
        field(5805; "Return Qty. Rcd. Not Invd."; Decimal)
        {
            Caption = 'Return Qty. Rcd. Not Invd.', comment = 'DEA="Lief. n. fakt. Rücks.-Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5806; "Ret. Qty. Rcd. Not Invd.(Base)"; Decimal)
        {
            Caption = 'Ret. Qty. Rcd. Not Invd.(Base)', comment = 'DEA="Lief.n.fak. Rücks.-Mge.(Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5807; "Return Rcd. Not Invd."; Decimal)
        {
            AutoFormatExpression = "Currency Code";
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd.', comment = 'DEA="Lief. n. fakt. Rücks.-Betr."';
            Editable = false;
        }
        field(5808; "Return Rcd. Not Invd. (LCY)"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Return Rcd. Not Invd. (LCY)', comment = 'DEA="Lief. n. fak. Rücks.-Betr.(MW)"';
            Editable = false;
        }
        field(5809; "Return Qty. Received"; Decimal)
        {
            AccessByPermission = TableData "Return Receipt Header" = R;
            Caption = 'Return Qty. Received', comment = 'DEA="Bereits gelief. Rücks.-Menge"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5810; "Return Qty. Received (Base)"; Decimal)
        {
            Caption = 'Return Qty. Received (Base)', comment = 'DEA="Ber. gel. Rücks.-Menge (Basis)"';
            DecimalPlaces = 0 : 5;
            Editable = false;
        }
        field(5811; "Appl.-from Item Entry"; Integer)
        {
            AccessByPermission = TableData Item = R;
            Caption = 'Appl.-from Item Entry', comment = 'DEA="Ausgegl. von Artikelposten"';
            MinValue = 0;
        }
        field(5909; "BOM Item No."; Code[20])
        {
            Caption = 'BOM Item No.', comment = 'DEA="Fert.-Stückliste Artikelnr."';
            TableRelation = Item;
        }
        field(6600; "Return Receipt No."; Code[20])
        {
            Caption = 'Return Receipt No.', comment = 'DEA="Rücksendungsnr."';
            Editable = false;
        }
        field(6601; "Return Receipt Line No."; Integer)
        {
            Caption = 'Return Receipt Line No.', comment = 'DEA="Rücksendungszeilennr."';
            Editable = false;
        }
        field(6608; "Return Reason Code"; Code[10])
        {
            Caption = 'Return Reason Code', comment = 'DEA="Reklamationsgrundcode"';
            TableRelation = "Return Reason";
        }
        field(6610; "Copied From Posted Doc."; Boolean)
        {
            Caption = 'Copied From Posted Doc.', comment = 'DEA="Copied From Posted Doc."';
            DataClassification = SystemMetadata;
        }
        field(7001; "Allow Line Disc."; Boolean)
        {
            Caption = 'Allow Line Disc.', comment = 'DEA="Zeilenrabatt zulassen"';
            InitValue = true;
        }
        field(7002; "Customer Disc. Group"; Code[20])
        {
            Caption = 'Customer Disc. Group', comment = 'DEA="Debitorenrabattgruppe"';
            TableRelation = "Customer Discount Group";
        }
        field(7003; Subtype; Option)
        {
            Caption = 'Subtype', comment = 'DEA="Unterart"';
            OptionCaption = ' ,Item - Inventory,Item - Service,Comment', comment = 'DEA=" ,Artikel - Lagerbestand,Artikel - Dienstleistung,Kommentar"';
            OptionMembers = " ","Item - Inventory","Item - Service",Comment;
        }
        field(7004; "Price description"; Text[80])
        {
            Caption = 'Price description', comment = 'DEA="Preisbeschreibung"';
        }
        // field(7010; "Attached Doc Count"; Integer)
        // {
        //     BlankNumbers = DontBlank;
        //     CalcFormula = Count ("Document Attachment" WHERE("Table ID" = CONST(37),
        //                                                      "No." = FIELD("Document No."),
        //                                                      "Document Type" = FIELD("Document Type"),
        //                                                      "Line No." = FIELD("Line No.")));
        //     Caption = 'Attached Doc Count', comment = 'DEA=""';
        //     FieldClass = FlowField;
        //     InitValue = 0;
        // }
        field(50000;"VAT Posting Type";Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50001;"Allocation Code";Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002;"Allocation %";Decimal)
        {
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
            DataClassification = CustomerContent;
        }
        field(50003;"Start Date";Date)
        {
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
            DataClassification = CustomerContent;
        }
        field(50004; "Shortcut Dimension 1 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup ("Dimension Value".Name WHERE("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
        field(50006; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (3));
            CaptionClass = '1,2,3';
        }
        // field(50007; "Shortcut Dimension 3 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 3 Name', comment = 'DEA="Shortcutdimensionsname 3"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (3), Code = field ("Shortcut Dimension 3 Code")));
        //     CaptionClass = '1337,3';
        // }
        field(50008; "Shortcut Dimension 4 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (4));
            CaptionClass = '1,2,4';
        }
        // field(50009; "Shortcut Dimension 4 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 4 Name', comment = 'DEA="Shortcutdimensionsname 4"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (4), Code = field ("Shortcut Dimension 4 Code")));
        //     CaptionClass = '1337,4';
        // }
        field(50010; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (5));
            CaptionClass = '1,2,5';
        }
        // field(50011; "Shortcut Dimension 5 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 5 Name', comment = 'DEA="Shortcutdimensionsname 5"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (5), Code = field ("Shortcut Dimension 5 Code")));
        //     CaptionClass = '1337,5';
        // }
        field(50012; "Shortcut Dimension 6 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (6));
            CaptionClass = '1,2,6';
        }
        // field(50013; "Shortcut Dimension 6 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 6 Name', comment = 'DEA="Shortcutdimensionsname 6"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (6), Code = field ("Shortcut Dimension 6 Code")));
        //     CaptionClass = '1337,6';
        // }
        field(50014; "Shortcut Dimension 7 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 7 Code', comment = 'DEA="Shortcutdimensionscode 7"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (7));
            CaptionClass = '1,2,7';
        }
        // field(50015; "Shortcut Dimension 7 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 7 Name', comment = 'DEA="Shortcutdimensionsname 7"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (7), Code = field ("Shortcut Dimension 7 Code")));
        //     CaptionClass = '1337,7';
        // }
        field(50016; "Shortcut Dimension 8 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No." = CONST (8));
            CaptionClass = '1,2,8';
        }
        // field(50017; "Shortcut Dimension 8 Name"; Text[50])
        // {
        //     Caption = 'Shortcut Dimension 8 Name', comment = 'DEA="Shortcutdimensionsname 8"';
        //     Editable = false;
        //     FieldClass = FlowField;
        //     CalcFormula = lookup ("Dimension Value".Name WHERE ("Global Dimension No." = const (8), Code = field ("Shortcut Dimension 8 Code")));
        //     CaptionClass = '1337,8';
        // }
        field(50020;"Gen. Bus. Posting Group Description";Text[50])
        {
            Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Geschäftsbuchungsgruppe Beschreibung"';
            FieldClass = FlowField;
            CalcFormula = lookup ("Gen. Business Posting Group".Description where (Code = field("Gen. Bus. Posting Group")));
        }
        field(50031;"External Document No.";Code[35])
        {
            Caption = 'External Document No.', comment = 'DEA="Externe Belegnummer"';
            DataClassification = CustomerContent;
        }     
        field(50050;"Origin Line No.";Integer)
        {
            DataClassification = CustomerContent;
        }   
    }

    keys
    {
        key(Key1; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
        // key(Key2; "Document No.", "Line No.", "Document Type")
        // {
        //     Enabled = false;
        // }
        // key(Key3; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Shipment Date")
        // {
        //     SumIndexFields = "Outstanding Qty. (Base)";
        // }
        // key(Key4; "Document Type", "Bill-to Customer No.", "Currency Code", "Document No.")
        // {
        //     SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)", "Return Rcd. Not Invd. (LCY)";
        // }
        // key(Key5; "Document Type", Type, "No.", "Variant Code", "Drop Shipment", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Location Code", "Shipment Date")
        // {
        //     Enabled = false;
        //     SumIndexFields = "Outstanding Qty. (Base)";
        // }
        // key(Key6; "Document Type", "Bill-to Customer No.", "Shortcut Dimension 1 Code", "Shortcut Dimension 2 Code", "Currency Code", "Document No.")
        // {
        //     Enabled = false;
        //     SumIndexFields = "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        // }
        // key(Key7; "Document Type", "Blanket Order No.", "Blanket Order Line No.")
        // {
        // }
        // key(Key8; "Document Type", "Document No.", "Location Code")
        // {
        //     MaintainSQLIndex = false;
        //     SumIndexFields = Amount, "Amount Including VAT", "Outstanding Amount", "Shipped Not Invoiced", "Outstanding Amount (LCY)", "Shipped Not Invoiced (LCY)";
        // }
        // key(Key9; "Document Type", "Shipment No.", "Shipment Line No.")
        // {
        // }
        // key(Key10; Type, "No.", "Variant Code", "Drop Shipment", "Location Code", "Document Type", "Shipment Date")
        // {
        //     MaintainSQLIndex = false;
        // }
        // key(Key11; "Document Type", "Sell-to Customer No.", "Shipment No.", "Document No.")
        // {
        //     SumIndexFields = "Outstanding Amount (LCY)";
        // }
        // key(Key12; "Job Contract Entry No.")
        // {
        // }
        // key(Key13; "Document Type", "Document No.", "Qty. Shipped Not Invoiced")
        // {
        //     Enabled = false;
        // }
        // key(Key14; "Document Type", "Document No.", Type, "No.")
        // {
        //     Enabled = false;
        // }
        // key(Key15; "Recalculate Invoice Disc.")
        // {
        // }
        // key(Key16; "Qty. Shipped Not Invoiced")
        // {
        // }
        // key(Key17; "Qty. Shipped (Base)")
        // {
        // }
        // key(Key18; "Shipment Date", "Outstanding Quantity")
        // {
        // }
    }
}

