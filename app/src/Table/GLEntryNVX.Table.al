table 50016 GLEntryNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Entry No.";Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10;"SShortcut Dimension 1 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1338,1'; //= Sales + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
        }
        field(11;"SShortcut Dimension 3 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            CaptionClass = '1338,3'; //= Sales + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(12;"PShortcut Dimension 1 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1339,1'; //= Purchase + Dim Name
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1)); 
        }
        field(13;"PShortcut Dimension 3 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            CaptionClass = '1339,3'; //= Purchase + Dim Name      
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));      
        }
        field(15;"Interim Gen.Bus.Posting Group";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
        field(20;"Allocation Code";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
        }
        field(25;"VAT Posting Type";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
        }
    }

    keys
    {
        key(PK;"Entry No.")
        {
            Clustered = true;
        }
    }
    
    var
        myInt : Integer;

    trigger OnInsert();
    begin
    end;

    trigger OnModify();
    begin
    end;

    trigger OnDelete();
    begin
    end;

    trigger OnRename();
    begin
    end;

}