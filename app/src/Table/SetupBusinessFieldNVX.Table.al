table 50041 "SetupBusinessFieldNVX"
{
    DataClassification = CustomerContent;
    fields
    {
        field(1; CustomerNo; Code[20])
        {
            Caption = 'Customer No.', comment = 'DEA="Debitornr."';
            DataClassification = CustomerContent;
        }
        field(2; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
        }
        field(3; "Shortcut Dimension 9 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code';
            CaptionClass = '1,2,9';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
        }
        field(4; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code', comment = 'DEA="Mahnmethodencode"';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Terms";
        }
        field(10; Activ; Boolean)
        {
            Caption = 'Activ', comment = 'DEA="Aktiv"';
            DataClassification = CustomerContent;
        }
        field(20; Sort; integer)
        {
            Caption = 'Sort', comment = 'DEA="Sortierung"';
            DataClassification = CustomerContent;
        }
    }

    keys
    {
        key(Key1; "CustomerNo", "Shortcut Dimension 5 Code")
        {
            Clustered = true;
        }
        key(Key2; CustomerNo, Sort)
        {

        }
    }

    trigger OnInsert()
    begin
        SetSorting();
    end;

    local procedure SetSorting()
    begin
        case "Shortcut Dimension 5 Code" of
            PBTxt:
                Sort := 1;
            RDTxt:
                Sort := 2;
            RHTxt:
                Sort := 3;
            EATxt:
                Sort := 4;
            SOTxt:
                Sort := 5;
            EVTxt:
                Sort := 6;
            else
                sort := 0;
        end;
    end;

    var
        PBTxt: Label 'PB';
        RDTxt: Label 'RD';
        RHTxt: Label 'RH';
        EATxt: Label 'EA';
        SOTxt: Label 'SO';
        EVTxt: Label 'EV';
}