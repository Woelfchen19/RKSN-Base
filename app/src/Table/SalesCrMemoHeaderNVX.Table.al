table 50042 "SalesCrMemoHeaderNVX"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "No."; Code[20])
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
    }

    keys
    {
        key(PK;"No.")
        {
            Clustered = true;
        }
    }
}