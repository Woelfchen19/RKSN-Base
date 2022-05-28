table 50041 "CustomerBusinessFieldNVX"
{
    Caption = 'Customer Businessfield (Dim 5)', comment = 'DEA="Debitor Geschäftsfeld (Dim 5)"';
    DataCaptionFields = "Customer No.";
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Customer No."; Code[20])
        {
            Caption = 'Customer No.', comment = 'DEA="Debitornr."';
            DataClassification = CustomerContent;
        }
        field(2; State; Enum StatusCustBusinessFieldsNVX)
        {
            Caption = 'State', comment = 'DEA="Status"';
            DataClassification = CustomerContent;
        }
        field(5; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', comment = 'DEA="Errichtungsdatum"';
        }
        field(6; "Created By User"; Code[50])
        {
            Caption = 'Created By User', comment = 'DEA="Erstellt von Benutzer"';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
        field(7; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date', comment = 'DEA="Datum der letzten Änderung"';
        }
        field(8; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User', comment = 'DEA="Zuletzt geändert von Benutzer"';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
        }
        field(10; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
        }
        field(11; Dimension5Name; Text[50])
        {
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(5), Code = field("Shortcut Dimension 5 Code")));
            Caption = 'Shortcut Dimension 5 Name', comment = 'DEA="Name"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Dimension Value Type"; Option)
        {
            Caption = 'Dimension Value Type';
            OptionCaption = 'Standard,Heading,Total,Begin-Total,End-Total';
            OptionMembers = Standard,Heading,Total,"Begin-Total","End-Total";
        }

        field(20; "Shortcut Dimension 9 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 9 Code';
            CaptionClass = '1,2,9';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
        }
        field(21; "Reminder Terms Code"; Code[10])
        {
            Caption = 'Reminder Terms Code', comment = 'DEA="Mahnmethodencode"';
            DataClassification = CustomerContent;
            TableRelation = "Reminder Terms";
        }
        field(22; "Payment Terms Code"; Code[10])
        {
            Caption = 'Payment Terms Code', comment = 'DEA="Zlg.-Bedingungscode"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(23; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(24; "Preferred BankAccount Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkontocode"';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Customer No."));
        }
        field(30; "Allowed Setup dynamic fields"; Boolean)
        {
            Caption = 'Allowed Setup dynamic Fields', comment = 'DEA="setup dynamische Felder erlaubt"';
            DataClassification = CustomerContent;
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

        "Created By User" := Format(UserId);
        "Creation Date" := CurrentDateTime();
    end;

    trigger OnModify()
    begin
        "Last Modified Date" := CurrentDateTime;
        "Last Modified By User" := Format(UserId);
    end;

    procedure InsertSetupBusinessField(CustomerNo: Code[20])
    var
        UserSetup: Record "User Setup";
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        AppMgt: Codeunit AppMgtNVX;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        GLSetup.Get();
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        if DimensionValue.FindSet() then begin
            repeat
                CustomerBusinessField.Init();
                CustomerBusinessField."Customer No." := CustomerNo;
                CustomerBusinessField."Shortcut Dimension 5 Code" := DimensionValue.Code;
                CustomerBusinessField."Dimension Value Type" := DimensionValue."Dimension Value Type";
                CustomerBusinessField.Insert(true);
            until DimensionValue.Next() = 0;

            CustomerBusinessField.Init();
            CustomerBusinessField."Customer No." := CustomerNo;
            CustomerBusinessField."Shortcut Dimension 5 Code" := Format(DimShortcutBusinessField::All);
            CustomerBusinessField."Dimension Value Type" := DimensionValue."Dimension Value Type"::Standard;
            CustomerBusinessField.Insert(true);
        end;
    end;

    procedure SetStatusSetup(CustomerNo: Code[20]; DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX): Enum StatusCustBusinessFieldsNVX
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        AppMgt: Codeunit AppMgtNVX;
        RecRef: RecordRef;
        StatusCustBusinessField: Enum StatusCustBusinessFieldsNVX;
        TotalCounter: integer;
        Counter: integer;
        i: Integer;
    begin
        if DimShortcutBusinessField = DimShortcutBusinessField::All then
            exit(StatusCustBusinessField::EMPTY);

        CustomerBusinessField.Reset();
        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField.SetRange(Active, true);
        CustomerBusinessField.SetRange("Shortcut Dimension 5 Code", Format(DimShortcutBusinessField));
        if CustomerBusinessField.FindSet() then
            repeat
                RecRef.GetTable(CustomerBusinessField);
                for i := 20 to 39 do
                    if RecRef.FieldExist(i) then begin
                        TotalCounter += 1;
                        if AppMgt.IsNormalField(RecRef.Field(i)) and AppMgt.HasValue(RecRef.Field(i)) then
                            Counter += 1;
                    end;
            until CustomerBusinessField.Next() = 0;

        if Counter = TotalCounter then
            Exit(StatusCustBusinessField::EE);

        if Counter = 0 then
            exit(StatusCustBusinessField::NE)
        else
            exit(StatusCustBusinessField::TE);
    end;

    procedure SetStyle(): Text
    begin
        case Rec.State of
            StatusCustBusinessFieldsNVX::EMPTY:
                exit('Standard');
            StatusCustBusinessFieldsNVX::EE:
                exit('Favorable');
            StatusCustBusinessFieldsNVX::NE:
                exit('Attension');
            StatusCustBusinessFieldsNVX::TE:
                exit('AttensionAccent');
        end;
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
            Format(DimShortcutBusinessField::All):
                sort := 7;
        end
    end;
}