table 50041 "SetupBusinessFieldNVX"
{
    Caption = 'Businessfields (Dim 5)', comment = 'DEA="Geschäftsfelder (Dim 5)"';
    DataClassification = CustomerContent;
    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', comment = 'DEA="Debitornr."';
            DataClassification = CustomerContent;
        }
        // field(2; OKIcon; MediaSet)
        // {
        //     Caption = 'OK-Icon', comment = 'DEA="OK-Icon"';
        //     DataClassification = CustomerContent;
        // }
        field(10; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
        }
        field(11; "Shortcut Dimension 9 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code';
            CaptionClass = '1,2,9';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
        }
        field(12; "Dimension5Name"; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(5), Code = field("Shortcut Dimension 5 Code")));
            Caption = 'Shortcut Dimension 5 Name', comment = 'DEA="Name"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(13; "Dimension Value Type"; Option)
        {
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";
        }
        field(20; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code', comment = 'DEA="Mahnmethodencode"';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Terms";
        }
        field(21; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'DEA="Zlg.-Bedingungscode"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(22; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(23; "Preferred BankAccount Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkontocode"';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(40; Active; Boolean)
        {
            Caption = 'Active', comment = 'DEA="Aktiv"';
            DataClassification = CustomerContent;
        }
        field(41; Sort; integer)
        {
            Caption = 'Sort', comment = 'DEA="Sortierung"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; "Customer No.", "Shortcut Dimension 5 Code")
        {
            Clustered = true;
        }
        key(Key2; Sort)
        {
        }
    }

    trigger OnInsert()
    begin
        SetSorting();
    end;

    local procedure SetSorting()
    var
        DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX;
    begin

        case "Shortcut Dimension 5 Code" of
            Format(DimShortcutBusinessField::PB):
                sort := 1;
            Format(DimShortcutBusinessField::RD):
                sort := 2;
            Format(DimShortcutBusinessField::RH):
                sort := 3;
            Format(DimShortcutBusinessField::EA):
                sort := 4;
            Format(DimShortcutBusinessField::SO):
                sort := 5;
            Format(DimShortcutBusinessField::EV):
                sort := 6;
        end
    end;
}