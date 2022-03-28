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
}