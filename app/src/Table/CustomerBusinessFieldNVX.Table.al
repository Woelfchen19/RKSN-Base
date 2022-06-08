table 50041 "CustomerBusinessFieldNVX"
{
    Caption = 'Customer Businessfield (Dim 5)', comment = 'DEA="Debitor Geschäftsfeld (Dim 5)"';
    DataCaptionFields = "Customer No.";
    DataClassification = CustomerContent;
    DrillDownPageId = CustBusinessFieldListNVX;
    LookupPageId = CustBusinessFieldListNVX;

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
        field(3; "BankAccountCustBusinessField"; Code[20])
        {
            Caption = 'BankAccount Customer BusinessField', comment = 'DEA="Bankkonto Debitor Geschäftsfeld"';
            TableRelation = "Customer Bank Account";
        }
        field(4; BalanceBusinessField; Decimal)
        {
            AutoFormatType = 1;
            CalcFormula = Sum("Detailed Cust. Ledg. Entry".Amount WHERE("Customer No." = FIELD("Customer No."),
                                                                         "Initial Entry Global Dim. 1" = FIELD("Global Dimension 1 Filter"),
                                                                         "Initial Entry Global Dim. 2" = FIELD("Global Dimension 2 Filter"),
                                                                         "Currency Code" = FIELD("Currency Filter"),
                                                                         ShortcutDimension5CodeNVX = field("Shortcut Dimension 5 Code")));
            Caption = 'Balance BusinessField', comment = 'DEA="Debitorensaldo Geschäftsfeld"';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; "Creation Date"; DateTime)
        {
            Caption = 'Creation Date', comment = 'DEA="Errichtungsdatum"';
            Editable = false;
        }
        field(6; "Created By User"; Code[50])
        {
            Caption = 'Created By User', comment = 'DEA="Erstellt von Benutzer"';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            Editable = false;
        }
        field(7; "Last Modified Date"; DateTime)
        {
            Caption = 'Last Modified Date', comment = 'DEA="Datum der letzten Änderung"';
            Editable = false;
        }
        field(8; "Last Modified By User"; Code[50])
        {
            Caption = 'Last Modified By User', comment = 'DEA="Zuletzt geändert von Benutzer"';
            DataClassification = EndUserIdentifiableInformation;
            TableRelation = User."User Name";
            Editable = false;
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
        field(13; "Global Dimension 1 Filter"; Code[20])
        {
            Caption = 'Global Dimension 1 Filter';
            CaptionClass = '1,3,1';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
        }
        field(14; "Global Dimension 2 Filter"; Code[20])
        {
            Caption = 'Global Dimension 2 Filter';
            CaptionClass = '1,3,2';
            FieldClass = FlowFilter;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(15; "Currency Filter"; Code[10])
        {
            Caption = 'Currency Filter';
            FieldClass = FlowFilter;
            TableRelation = Currency;
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
            Caption = 'Payment Terms Code', comment = 'DEA="Zlg.Bedigung Geschäftsfeld"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Terms";
        }
        field(23; "Payment Method Code"; Code[10])
        {
            Caption = 'Payment Method Code', comment = 'DEA="Zahlungsform Geschäftsfeld"';
            DataClassification = CustomerContent;
            TableRelation = "Payment Method";
        }
        field(24; "Preferred BankAccount Code"; Code[20])
        {
            Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkontocode"';
            TableRelation = "Customer Bank Account".Code WHERE("Customer No." = FIELD("Customer No."));
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
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        GLSetup.GetRecordOnce();
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        if DimensionValue.FindSet() then begin
            repeat
                CustomerBusinessField.Init();
                CustomerBusinessField."Customer No." := CustomerNo;
                CustomerBusinessField."Shortcut Dimension 5 Code" := DimensionValue.Code;
                CustomerBusinessField."Dimension Value Type" := DimensionValue."Dimension Value Type";
                if CustomerBusinessField.Insert(true) then;
            until DimensionValue.Next() = 0;

            CustomerBusinessField.Init();
            CustomerBusinessField."Customer No." := CustomerNo;
            CustomerBusinessField."Shortcut Dimension 5 Code" := Format(DimShortcutBusinessField::All);
            CustomerBusinessField."Dimension Value Type" := DimensionValue."Dimension Value Type"::Standard;
            if CustomerBusinessField.Insert(true) then;
        end;
    end;

    procedure SetStatusSetup(CustomerNo: Code[20]; DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX): Enum StatusCustBusinessFieldsNVX
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        AppMgt: Codeunit AppMgtNVX;
        RecRef: RecordRef;
        StatusCustBusinessField: Enum StatusCustBusinessFieldsNVX;
        Counter: integer;
        i: Integer;
        TotalCounter: integer;
    begin
        CustomerBusinessField.Reset();
        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
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

    // procedure ShowPageCustomerBankAccount(Fielddnumber: integer; DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX; CodeFilter: Code[20]; var ReturnValue: Code[20])
    // var
    //     CustomerBusinessField: Record CustomerBusinessFieldNVX;
    //     AppMgt: Codeunit AppMgtNVX;
    // begin
    //     case DimShortcutBusinessField of
    //         DimShortcutBusinessField::PB:
    //             case Fielddnumber of
    //                 CustomerBusinessField.FieldNo("Preferred BankAccount Code"):
    //                     AppMgt.ShowPageCustomerBankAccount(
    //                         StrSubstNo(TokenPreferredBankAccountCodeTok, CodeFilter), ReturnValue);
    //                 CustomerBusinessField.FieldNo("Payment Method Code"):
    //                     AppMgt.ShowPagePaymentMethods(
    //                         StrSubstNo(TokenPaymentMethodTok, CodeFilter), ReturnValue);
    //                 CustomerBusinessField.FieldNo("Payment Terms Code"):
    //                     AppMgt.ShowPagePaymentTerms(
    //                         StrSubstNo(TokenPaymentMethodTok, CodeFilter), ReturnValue);
    //                 CustomerBusinessField.FieldNo("Reminder Terms Code"):
    //                     AppMgt.ShowPageReminderTerms(CodeFilter, ReturnValue);
    //             end;
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, PBShortcutDimension5Code), PBPreferredBankAccountCode);
    // DimShortcutBusinessField::RD:
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, RDShortcutDimension5Code), RDPreferredBankAccountCode);
    // DimShortcutBusinessField::RH:
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, RHShortcutDimension5Code), RHPreferredBankAccountCode);
    // DimShortcutBusinessField::SO:
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, SOShortcutDimension5Code), SOPreferredBankAccountCode);
    // DimShortcutBusinessField::EA:
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, EAShortcutDimension5Code), EAPreferredBankAccountCode);
    // DimShortcutBusinessField::EV:
    //     AppMgt.ShowPageCustomerBankAccount(
    //         StrSubstNo(TokenPreferredBankAccountCodeTok, EVShortcutDimension5Code), EVPreferredBankAccountCode);
    // end;
    // end;

    // var
    //     TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;
    //     TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
    //     TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"', Locked = true;
}