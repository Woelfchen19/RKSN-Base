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
            trigger OnValidate();
            begin
                CheckValid();
            end;
        }
        field(11; "Inventory Posting Group NVX"; Code[20])
        {
            DataClassification = ToBeClassified;
            Caption = 'Inventory Posting Group', comment = 'DEA="Lagerbuchungsgruppe"';
            TableRelation = "Inventory Posting Group".Code;
            trigger OnValidate();
            begin
                CheckValid();
            end;
        }
    }

    keys
    {
        key(PK; Code)
        {
            Clustered = true;
        }
    }

    procedure CheckValid();
    var
        InvalidCombination_Err: Label 'If ''No Item'' is selected then field ''Inventory Posting Group'' must be empty',
        comment = 'DEA="Bei der Auswahl ''kein Artikel'' ist eine Zuordnung der Lagerbuchungsgruppe nicht möglich!"';
    begin
        if ("Inventory Value Zero" = "Inventory Value Zero"::"No Item") and ("Inventory Posting Group NVX" <> '') then
            Error(InvalidCombination_Err);
    end;
}