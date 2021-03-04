table 50000 GenPrdPstGrpNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Code', comment = 'DEA="Code"';
        }
        field(10; "Inventory Value Zero"; Option)
        //RKSN-36
        {
            DataClassification = CustomerContent;
            Caption = 'Inventory Value Zero', comment = 'DEA="Ohne Lagerbewertung"';
            OptionMembers = "No Item",Yes,No;
            OptionCaption = 'No Item,Yes,No', comment = 'DEA="Kein Artikel,Ja,Nein"';
        }
    }

    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }
}