table 50002 "InvSetupNVX"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
        }
        field(10; "Allow Neg. Inv. Stock Value"; Boolean)
        //RKSN-38
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Negative Inventory for Items with Stock Value', comment = 'DEA="Zu lagerbewerteten Artikeln negative Lagerbestände zulassen"';
        }
        field(11; "Allow Neg. Inv. no Stock Value"; Boolean)
        //RKSN-38
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Negative Inventory for Items without Stock Value', comment = 'DEA="Zu NICHT lagerbewerteten Artikeln negative Lagerbestände zulassen"';
        }
        field(20; "Inventory Section"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Section', comment = 'DEA="Lager Sparte"'; //TODO CaptionClass einrichten in Codeunit42HookNVX
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(21; "Inventory Cost Center"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Cost Center', comment = 'DEA="Lager KSt."'; //TODO CaptionClass einrichten in Codeunit42HookNVX
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
        }
        field(22; "Section - Inventory Value Zero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Section - Inventory Value Zero', comment = 'DEA="EK und VK nicht lagerbewertet Sparte"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(25; "Purch Gen. Bus. Pst Grp Fixed"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Gen. Bus. Posting Group Fixed', comment = 'DEA="Zukauf Steuerschlüssel FIX"';
            TableRelation = "Gen. Business Posting Group".Code;
        }

        field(100; "Composition Customer"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Customer', comment = 'DEA="Abfassung Debitor"';
            TableRelation = Customer."No.";
        }
        field(101; "Comp Gen. Bus. Pst Grp Fixed"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Gen. Bus. Posting Group Fixed', comment = 'DEA="Abfassung Steuerschlüssel FIX"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(102; "Comp Gen. Bus. Pst Grp WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(103; "Comp Sect - Inv Value Zero"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Section - Inventory Value Zero', comment = 'DEA="Abfassung nicht lagerbewertete Sparte"';
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(104; "Composition Bal. WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Bal. WES', comment = 'DEA="Abfassung Entl. WES"';
            TableRelation = "G/L Account"."No.";
        }
        field(105; "Composition Journal Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Journal Name', comment = 'DEA="Abfassung Buchblattname"';
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = const ('Verkauf'));
        }
        field(106; "Comp Journal Description"; Text[100])
        {
            Caption = 'Composition Journal Description', comment = 'DEA="Abfassung Buchblattbeschreibung"';
            FieldClass = FlowField;
            CalcFormula = lookup ("Gen. Journal Batch".Description where (Name = field("Composition Journal Name"),"Journal Template Name" = const ('VERKAUF')));
            Editable = false;
        }
        field(107; "Sales Journal Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Journal Name', comment = 'DEA="Verkauf Buchblattname"';
            TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = const ('Verkauf'));
        }
        field(108; "Sales Journal Description"; Text[100])
        {
            Caption = 'Sales Journal Description', comment = 'DEA="Verkauf Buchblattbeschreibung"';
            FieldClass = FlowField;
            CalcFormula = lookup ("Gen. Journal Batch".Description where (Name = field("Sales Journal Name"),"Journal Template Name" = const ('VERKAUF')));
            Editable = false;
        }
        field(109; "Sales Bal. Return"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Bal. Return', comment = 'DEA="Verkauf Entl. Erlöse"';
            TableRelation = "G/L Account"."No.";
        }
        field(110; "Sales Bal. WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Bal. WES', comment = 'DEA="Verkauf Entl. WES"';
            TableRelation = "G/L Account"."No.";
        }
        field(150; "Vend./Cust. Dim 1"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
            Caption = 'Vendor/Customer postings Dimension 1', comment = 'DEA="Dim. 1 Personenkonten Buchungsgruppen"';
        }
        field(151; "Vend./Cust. Dim 2"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(2));
            Caption = 'Vendor/Customer postings Dimension 2', comment = 'DEA="Dim. 2 Personenkonten Buchungsgruppen"';
        }
        field(152; "Vend./Cust. Dim 3"; Code[20])
        {
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
            Caption = 'Vendor/Customer postings Dimension 3', comment = 'DEA="Dim. 3 Personenkonten Buchungsgruppen"';
        }
        field(153; "Vend./Cust. Dim Set ID"; Integer)
        {
            DataClassification = CustomerContent;
            Editable = false;
            Caption = 'Vendor/Customer Dimension Set-ID', comment = 'DEA="Dim. Personenkonten Buchungsgruppen Dimension Set ID"';
        }
    }

    keys
    {
        key(PK;"Primary Key")
        {
            Clustered = true;
        }
    }

    procedure GetDimSetID()
    var
        tempDimSetEntry: Record "Dimension Set Entry" temporary;
        GLSetup: Record "General Ledger Setup";
    begin
        IF tempDimSetEntry.IsTemporary then
            tempDimSetEntry.DeleteAll();
        GLSetup.Get();
        IF "Vend./Cust. Dim 1" <> '' then begin
            tempDimSetEntry.Init();
            tempDimSetEntry."Dimension Set ID" := 0;
            tempDimSetEntry.Validate("Dimension Code",GLSetup."Global Dimension 1 Code");
            tempDimSetEntry.Validate("Dimension Value Code","Vend./Cust. Dim 1");
            tempDimSetEntry.Insert();
        end;
        IF "Vend./Cust. Dim 2" <> '' then begin
            tempDimSetEntry.Init();
            tempDimSetEntry."Dimension Set ID" := 0;
            tempDimSetEntry.Validate("Dimension Code",GLSetup."Global Dimension 2 Code");
            tempDimSetEntry.Validate("Dimension Value Code","Vend./Cust. Dim 2");
            tempDimSetEntry.Insert();
        end;
        IF "Vend./Cust. Dim 3" <> '' then begin
            tempDimSetEntry.Init();
            tempDimSetEntry."Dimension Set ID" := 0;
            tempDimSetEntry.Validate("Dimension Code",GLSetup."Shortcut Dimension 3 Code");
            tempDimSetEntry.Validate("Dimension Value Code","Vend./Cust. Dim 3");
            tempDimSetEntry.Insert();
        end;

        "Vend./Cust. Dim Set ID" := tempDimSetEntry.GetDimensionSetID(tempDimSetEntry);
        Modify();
    end;
}