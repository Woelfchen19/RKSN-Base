table 50000 "GenPrdPstGrpNVX"
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
            TableRelation = "Inventory Posting Group";
            trigger OnValidate();
            begin
                CheckValid();
            end;            
        }        
    }

    keys
    {
        key(PK;Code)
        {
            Clustered = true;
        }
    }

    procedure CheckValid();
    var
        InvalidCombination_Err: Label 'Your are not allowed to fill both fields "Inventory Value Zero" and "Inventory Posting Group"', 
        comment = 'DEA="Es ist nicht erlaubt beide Felder "Ohne Lagerbewertung" und "Lagerbuchungsgruppe" zu befüllen';
    begin 
        if ("Inventory Value Zero" = "Inventory Value Zero"::Yes) and ("Inventory Posting Group NVX" <> '') then
            error(InvalidCombination_Err);
    end;
}