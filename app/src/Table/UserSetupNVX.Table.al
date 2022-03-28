table 50041 UserSetupNVX
{
    fields
    {
        field(1; "User ID"; Code[50])
        {
            DataClassification = CustomerContent;
            Caption = 'User ID', comment = 'DEA="Benutzer-ID"';
        }
        field(10; "Allow Item Prod.Pst.Grp Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Item Prod.Post.Group Change', comment = 'DEA="Änderung Prod.Bu.Grp. Artikelkarte"';
        }
        field(11; "Allow Item Invt.Pst.Grp Change"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Allow Item Invt.Post.Group Change', comment = 'DEA="Änderung Lager.Bu.Grp. Artikelkarte"';
        }
    }

    keys
    {
        key(PK; "User ID")
        {
            Clustered = true;
        }
    }
}