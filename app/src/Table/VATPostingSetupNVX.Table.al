table 50042 VATPostingSetupNVX
{
    fields
    {
        field(1; "VAT Bus. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(2; "VAT Prod. Posting Group"; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(50000; "Purchase VAT as Expense"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase VAT as Expense', comment = 'DEA="VST als Aufwand"';
        }
    }

    keys
    {
        key(Key1; "VAT Bus. Posting Group", "VAT Prod. Posting Group")
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(VATBusPostingGroup: Code[20]; VATProdPostingGroup: Code[20])
    begin
        if ("VAT Bus. Posting Group" = VATBusPostingGroup) and
            ("VAT Prod. Posting Group" = VATProdPostingGroup)
        then
            exit;

        if Get(VATBusPostingGroup, VATProdPostingGroup) then
            exit;

        Init();
        "VAT Bus. Posting Group" := VATBusPostingGroup;
        "VAT Prod. Posting Group" := VATProdPostingGroup;
        Insert();
    end;
}