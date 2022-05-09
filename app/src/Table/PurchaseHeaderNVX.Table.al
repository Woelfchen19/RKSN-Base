table 50028 "PurchaseHeaderNVX"
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
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount', comment = 'DEA="Verteilungsbetrag"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrPurchLineNVX."VAT Base Amount" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT', comment = 'DEA="Verteilungsbetrag inkl. USt."';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrPurchLineNVX."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("No.")));
        }
    }
    keys
    {
        key(PK; "Document Type", "No.")
        {
            Clustered = true;
        }
    }
    procedure GetDefinition(DocumentType: Enum RKSPurchaseDocumentTypeNVX; DocumentNo: Code[20])
    begin
        if ("Document Type" = DocumentType) and
            ("No." = DocumentNo)
        then
            exit;

        if Get(DocumentType, DocumentNo) then begin
            CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
            exit;
        end;

        Init();
        "Document Type" := DocumentType;
        "No." := DocumentNo;
        Insert();
        CalcFields("Allocation Amount", "Allocation Amount Incl. VAT")
    end;
}