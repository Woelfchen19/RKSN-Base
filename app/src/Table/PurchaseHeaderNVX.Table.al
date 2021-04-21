table 50040 PurchaseHeaderNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"No.";Code[20])
        {
            DataClassification = CustomerContent;
        }
        // field(15;"Interim Gen.Bus.Posting Group";Code[20])
        // {
        //     DataClassification = CustomerContent;
        //     Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
        //     TableRelation = "Gen. Business Posting Group".Code;
        // }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrPurchLineNVX."VAT Base Amount" where ("Document Type" = field ("Document Type"), "Document No." = field ("No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrPurchLineNVX."Amount Including VAT" where ("Document Type" = field ("Document Type"), "Document No." = field ("No.")));
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