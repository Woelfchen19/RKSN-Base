table 50005 BsnPstGrpVATPstTypeNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Gen. Bus. Posting Group";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Geschäftsbuchungsgruppe"';
        }
        field(2;"VAT Posting Type";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
        }
        field(10;"Gen. Bus. Posting Group2";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Gen. Bus. Posting Group', comment = 'DEA="Geschäftsbuchungsgruppe"';
        }
        field(11;Description;Text[50])
        {
            Caption = 'Description', comment = 'DEA="Beschreibung"';
            FieldClass = FlowField;
            CalcFormula = Lookup("Gen. Business Posting Group".Description WHERE (Code=FIELD("Gen. Bus. Posting Group2")));
            Editable = false;
        }
    }

    keys
    {
        key(PK;"Gen. Bus. Posting Group","VAT Posting Type")
        {
            Clustered = true;
        }
    }
}