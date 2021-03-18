table 50036 SalesLineNVX
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
        field(100; "Allocation Amount"; Integer)
        {
            Caption = 'Allocation Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrSalesLineNVX.Amount where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Integer)
        {
            Caption = 'Allocation Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrSalesLineNVX."Line Amount" where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
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