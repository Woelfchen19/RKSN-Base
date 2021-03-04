table 50009 DimValueNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Dimension Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Dimension Code', comment = 'DEA="Dimensionscode"';
        }
        field(2;Code;Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code', comment = 'DEA="Code"';
        }
        field(10;"VAT Posting Type";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            TableRelation = VATPostingTypeNVX.Code;
        }
        field(11;"VAT Posting Type Desc";Text[50])
        {
            Caption = 'VAT Posting Type Description', comment = 'DEA="USt.-Buchungsart Beschreibung"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(VATPostingTypeNVX.Description where (Code=field("VAT Posting Type")));
        }
    }

    keys
    {
        key(PK;"Dimension Code",Code)
        {
            Clustered = true;
        }
    }
}