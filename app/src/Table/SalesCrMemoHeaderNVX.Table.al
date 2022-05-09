table 50033 "SalesCrMemoHeaderNVX"
{
    DataClassification = CustomerContent;

    fields
    {
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
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
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
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }
}