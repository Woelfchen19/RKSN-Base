table 50043 FixedAssetSetupNVX
{
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Primary Key"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
        }
        //Journal Template Name,Journal Batch Name,Line No.
        field(50000; "VAT as Expense Jnl Templ Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT as Expense Journal Template Name', comment = 'DEA="VST als Aufwand Buch.-Blattvorlagenname"';
            TableRelation = "FA Journal Template";
        }
        field(50001; "VAT as Expense Jnl Batch Name"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'VAT as Expense Journal Batch Name', comment = 'DEA="VST als Aufwand Buch.-Blattname"';
            TableRelation = "FA Journal Batch".Name where("Journal Template Name" = field("VAT as Expense Jnl Templ Name"));
        }
    }

    keys
    {
        key(Key1; "Primary Key")
        {
            Clustered = true;
        }
    }
}