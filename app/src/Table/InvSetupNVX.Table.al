table 50002 InvSetupNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Primary Key";Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Primary Key', comment = 'DEA="Primärschlüssel"';
        }
        field(10;"Allow Neg. Inv. Stock Value";Boolean)
        //RKSN-38
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Negative Inventory for Items with Stock Value', comment = 'DEA="Zu lagerbewerteten Artikeln negative Lagerbestände zulassen"';
        }
        field(11;"Allow Neg. Inv. no Stock Value";Boolean)
        //RKSN-38
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Negative Inventory for Items without Stock Value', comment = 'DEA="Zu NICHT lagerbewerteten Artikeln negative Lagerbestände zulassen"';
        }
        field(20;"Inventory Section";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Section', comment = 'DEA="Lager Sparte"'; //TODO CaptionClass einrichten in Codeunit42HookNVX
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
        }
        field(21;"Inventory Cost Center";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Cost Center', comment = 'DEA="Lager KSt."'; //TODO CaptionClass einrichten in Codeunit42HookNVX
            TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
        }
        field(25;"Purchase Gen. Bus. Posting Group Fixed";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Purchase Gen. Bus. Posting Group Fixed', comment = 'DEA="Zukauf Steuerschlüssel FIX"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
    }

    keys
    {
        key(PK;"Primary Key")
        {
            Clustered = true;
        }
    }
}