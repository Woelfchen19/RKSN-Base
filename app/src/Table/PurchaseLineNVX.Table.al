table 50028 PurchaseLineNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"Document No.";Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4;"Line No.";Integer)
        {
            DataClassification = CustomerContent;            
        }
        field(10;"Allocation Code";Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }

        field(20;"Shortcut Dimension 1 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));       
            // CaptionClass = '1338,1'; = Sales + Dim Name
            // CaptionClass = '1339,1'; = Purchase + Dim Name
        }
        field(21;"Shortcut Dimension 3 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            // CaptionClass = '1338,3'; = Sales + Dim Name
            // CaptionClass = '1339,3'; = Purchase + Dim Name            
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
        }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrPurchLineNVX."VAT Base Amount" where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrPurchLineNVX."Amount Including VAT" where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
        }
    }

    keys
    {
        key(PK;"Document Type","Document No.","Line No.")
        {
            Clustered = true;
        }
    }
}