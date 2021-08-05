table 50001 "UserSetupNVX"
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID', comment = 'DEA="Benutzer-ID"';
        }
        field(10; "Allow Item Prod.Pst.Grp Change"; Boolean)
        //RKSN-37
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
        }
    }

    keys
    {
        key(PK;"User ID")
        {
            Clustered = true;
        }
    }
}