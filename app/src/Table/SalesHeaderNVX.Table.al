table 50039 "SalesHeaderNVX"
{
    DataClassification = CustomerContent;
    
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
            Caption = 'Composition Allocation', comment = 'Abfassung Verteilung"';
            DataClassification = CustomerContent;
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
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }   
        // field(22; "Shortcut Dimension 6 Code"; Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
        //     TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6));       
        //     CaptionClass = '1337,6'; //= Dim Name without "Code" or "Filter"
        // }
        field(25; "Comp Gen. Bus. Pst Grp WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrSalesLineNVX."VAT Base Amount" where ("Document Type" = field ("Document Type"), "Document No." = field ("No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrSalesLineNVX."Amount Including VAT" where ("Document Type" = field ("Document Type"), "Document No." = field ("No.")));
        }
    }

    keys
    {
        key(PK;"Document Type","No.")
        {
            Clustered = true;
        }
    }
}