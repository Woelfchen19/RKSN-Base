table 50036 "SalesHeaderNVX"
{
    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Allocation', comment = 'Abfassung Verteilung"';
            TableRelation = AllocationCodeNVX.Code;
        }
        field(15; "Interim Gen.Bus.Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Section', comment = 'DEA="Abfassung Sparte"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        // field(23; "Shortcut Dimension 5 Code"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Geschäftsfeld"';
        //     TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
        // }
        field(25; "Comp Gen. Bus. Pst Grp WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(30; "Transaction No."; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Transaction No.', comment = 'DEA="Transaktionsnummer"';
        }
        field(31; DoNotSplit; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'No dimensional distribution', comment = 'DEA="Keine dimensionale Verteilung"';
        }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrSalesLineNVX."VAT Base Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrSalesLineNVX."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }

    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    procedure GetDefinition(DocumentType: Enum RKSSalesDocumentTypeNVX; DocumentNo: Code[20])
    begin
        if ("Document Type" = DocumentType) and
            ("No." = DocumentNo)
        then
            exit;

        if Get(DocumentType, DocumentNo) then begin
            CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
            exit;
        end;

        Init();
        "Document Type" := DocumentType;
        "No." := DocumentNo;
        Insert();
        CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
    end;
}