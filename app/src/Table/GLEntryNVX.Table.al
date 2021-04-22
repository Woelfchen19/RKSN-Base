table 50016 "GLEntryNVX"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Entry No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Sales Shortcut Dimension 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1338,1'; //= Sales + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
        }
        field(11; "Sales Shortcut Dimension 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            CaptionClass = '1338,3'; //= Sales + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(12; "Purchase Shortcut Dimension 1"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1339,1'; //= Purchase + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
        }
        field(13; "Purchase Shortcut Dimension 3"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            CaptionClass = '1339,3'; //= Purchase + Dim Name      
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));      
        }
        field(15; "Interim Gen.Bus.Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(20; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
        }
        field(25; "VAT Posting Type"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
        }
        field(35; "Deactivate dimensional distr"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Deactivate dimensional distribution', comment = 'DEA="Verteilung deaktiviert"';
        }
    }

    keys
    {
        key(PK;"Entry No.")
        {
            Clustered = true;
        }
    }
}