page 50033 "CustBusinessFieldsCardNVX"
{

    Caption = 'Customer Business Fields', comment = 'DEA="Debitoren Geschäftsfelder"';
    DataCaptionFields = "Customer No.";
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = CustomerBusinessFieldNVX;
    layout
    {
        area(content)
        {
            group(SetupBusinessFieldPBNVX)
            {
                Caption = 'Care and Support', comment = 'DEA="Pflege und Betreuung - PB"';
                Visible = PBSetupVisible;

                group(GeneralPB)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(PBShortcutDimension5CodeNVX; PBShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(PBShortcutDimension9CodeNVX; PBShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(PBShortcutDimension5Code, 9, PBShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementPB)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(PBHReminderTermsCodeNVX; PBReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(PBShortcutDimension5Code, PBReminderTermsCode);
                        end;
                    }
                    field(PBPaymentTermsCodeNVX; PBPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, PBPaymentTermsCode);
                        end;
                    }
                    field(PBPaymentMethodCodeNVX; PBPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, PBPaymentMethodCode);
                        end;
                    }
                    field(PBPreferredBankAccountCodeNVX; PBPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::PB);
                        end;
                    }
                }
            }
            group(SetupBusinessFieldRDNVX)
            {
                Caption = 'Emergency Assistence - RD', comment = 'DEA="Rettungsdienst - RD"';
                Visible = RDSetupVisible;
                group(GeneralRD)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(RDShortcutDimension5CodeNVX; RDShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(RDShortcutDimension9CodeNVX; RDShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(RDShortcutDimension5Code, 9, RDShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementRD)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(RDHReminderTermsCodeNVX; RDReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(RDShortcutDimension5Code, RDReminderTermsCode);
                        end;
                    }
                    field(RDPaymentTermsCodeNVX; RDPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, RDPaymentTermsCode);
                        end;
                    }
                    field(RDPaymentMethodCodeNVX; RDPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, RDPaymentMethodCode);
                        end;
                    }
                    field(RDPreferredBankAccountCodeNVX; RDPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = 'Prevered Bankacccount Code', comment = 'DEA="Bevorzugter Bankkontocode"';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::RD);
                        end;
                    }
                }
            }
            group(SetupBusinessFieldRHNVX)
            {
                Caption = 'Call Help - RH', comment = 'DEA="Rufhilfe - RH"';
                Visible = RHSetupVisible;
                group(GeneralRH)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(RHShortcutDimension5CodeNVX; RHShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(RHShortcutDimension9CodeNVX; RHShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(RHShortcutDimension5Code, 9, RHShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementRH)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(RHReminderTermsCodeNVX; RHReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(RHShortcutDimension5Code, RHReminderTermsCode);
                        end;
                    }
                    field(RHPaymentTermsCodeNVX; RHPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, RHPaymentTermsCode);
                        end;
                    }
                    field(RHPaymentMethodCodeNVX; RHPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, RHPaymentMethodCode);
                        end;
                    }
                    field(RHPreferredBankAccountCodeNVX; RHPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::RH);
                        end;
                    }
                }
            }
            group(SetupBusinessFieldEANVX)
            {
                Caption = 'Food on Wheels - EA', comment = 'DEA="Essen auf Rädern - EA"';
                Visible = EASetupVisible;

                group(GeneralEA)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(EAShortcutDimension5CodeNVX; EAShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(EAShortcutDimension9CodeNVX; EAShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(EAShortcutDimension5Code, 9, EAShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementEA)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(EAReminderTermsCodeNVX; EAReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(EAShortcutDimension5Code, EAReminderTermsCode);
                        end;
                    }
                    field(EAPaymentTermsCodeNVX; EAPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, EAPaymentTermsCode);
                        end;
                    }
                    field(EAPaymentMethodCodeNVX; EAPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, EAPaymentMethodCode);
                        end;
                    }
                    field(EAPreferredBankAccountCodeNVX; EAPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::EA);
                        end;
                    }
                }
            }
            group(SetupBusinessFieldSONVX)
            {
                Caption = 'Miscellanious - SO', comment = 'DEA="Sonstiges - SO"';
                Visible = SOSetupVisible;

                group(GeneralSO)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(SOShortcutDimension5CodeNVX; SOShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(SOShortcutDimension9CodeNVX; SOShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(SOShortcutDimension5Code, 9, SOShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementSO)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(SOReminderTermsCodeNVX; SOReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(SOShortcutDimension5Code, SOReminderTermsCode);
                        end;
                    }
                    field(SOPaymentTermsCodeNVX; SOPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, SOPaymentTermsCode);
                        end;
                    }
                    field(SOPaymentMethodCodeNVX; SOPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, SOPaymentMethodCode);
                        end;
                    }
                    field(SOPreferredBankAccountCodeNVX; SOPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::SO);
                        end;
                    }
                }
            }
            group(SetupBusinessFieldEVNVX)
            {
                Caption = 'Evidence - EV', comment = 'DEA="Evidenz - EV"';
                Visible = EVSetupVisible;

                group(GeneralEV)
                {
                    Caption = 'General', comment = 'DEA="Allgemein"';
                    field(EVShortcutDimension5CodeNVX; EVShortcutDimension5Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,5';
                        Editable = false;
                        TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));
                        ToolTip = '', comment = 'DEA=""';
                    }
                    field(EVShortcutDimension9CodeNVX; EVShortcutDimension9Code)
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.OnLookupByBusinessField9Dimension(EVShortcutDimension5Code, 9, EVShortcutDimension9Code);
                        end;
                    }
                }
                group(PaymentManagementEV)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field(EVReminderTermsCodeNVX; EVReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(EVShortcutDimension5Code, EVReminderTermsCode);
                        end;
                    }
                    field(EVPaymentTermsCodeNVX; EVPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, EVPaymentTermsCode);
                        end;
                    }
                    field(EVPaymentMethodCodeNVX; EVPaymentMethodCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Method Code', comment = 'DEA="Zahlungsformcode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, EVPaymentMethodCode);
                        end;
                    }
                    field(EVPreferredBankAccountCodeNVX; EVPreferredBankAccountCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                        TableRelation = "Customer Bank Account";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            ShowPageCustomerBankAccount(DimShortcutBusinessField::EV);
                        end;
                    }
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        Initialize();
        AssignBusinessFields(false);
    end;

    trigger OnClosePage()
    begin
        ModifySetupBusinessField();
    end;

    var
        SetupBusinessField: Record CustomerBusinessFieldNVX;
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;

        EASetupVisible: Boolean;
        EVSetupVisible: Boolean;
        PBSetupVisible: Boolean;
        RDSetupVisible: Boolean;
        RHSetupVisible: Boolean;
        SOSetupVisible: Boolean;
        EAPaymentMethodCode: Code[10];
        EAPaymentTermsCode: Code[10];
        EAReminderTermsCode: Code[10];
        EVPaymentMethodCode: Code[10];
        EVPaymentTermsCode: Code[10];
        EVReminderTermsCode: Code[10];

        PBPaymentMethodCode: Code[10];

        PBPaymentTermsCode: Code[10];

        PBReminderTermsCode: Code[10];
        RDPaymentMethodCode: Code[10];
        RDPaymentTermsCode: Code[10];
        RDReminderTermsCode: Code[10];
        RHPaymentMethodCode: Code[10];
        RHPaymentTermsCode: Code[10];
        RHReminderTermsCode: Code[10];
        SOPaymentMethodCode: Code[10];
        SOPaymentTermsCode: Code[10];
        SOReminderTermsCode: Code[10];
        EAPreferredBankAccountCode: Code[20];
        EAShortcutDimension5Code: Code[20];
        EAShortcutDimension9Code: Code[20];
        EVPreferredBankAccountCode: Code[20];
        EVShortcutDimension5Code: Code[20];
        EVShortcutDimension9Code: Code[20];

        PBPreferredBankAccountCode: Code[20];
        PBShortcutDimension5Code: Code[20];

        PBShortcutDimension9Code: Code[20];
        RDPreferredBankAccountCode: Code[20];

        RDShortcutDimension5Code: Code[20];
        RDShortcutDimension9Code: Code[20];
        RHPreferredBankAccountCode: Code[20];
        RHShortcutDimension5Code: Code[20];
        RHShortcutDimension9Code: Code[20];
        SOPreferredBankAccountCode: Code[20];
        SOShortcutDimension5Code: Code[20];
        SOShortcutDimension9Code: Code[20];
        DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX;
        TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;

        TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"', Locked = true;

    procedure ShowPageCustomerBankAccount(DimShortcutBusinessField: enum DimShortcutBusinessFieldNVX)
    begin
        case DimShortcutBusinessField of
            DimShortcutBusinessField::PB:
                AppMgt.ShowPageCustomerBankAccount(
                    Rec."Customer No.",
                        StrSubstNo(TokenPreferredBankAccountCodeTok, PBShortcutDimension5Code),
                            PBPreferredBankAccountCode);
            DimShortcutBusinessField::RD:
                AppMgt.ShowPageCustomerBankAccount(Rec."Customer No.",
                    StrSubstNo(TokenPreferredBankAccountCodeTok, RDShortcutDimension5Code), RDPreferredBankAccountCode);
            DimShortcutBusinessField::RH:
                AppMgt.ShowPageCustomerBankAccount(Rec."Customer No.",
                    StrSubstNo(TokenPreferredBankAccountCodeTok, RHShortcutDimension5Code), RHPreferredBankAccountCode);
            DimShortcutBusinessField::SO:
                AppMgt.ShowPageCustomerBankAccount(Rec."Customer No.",
                    StrSubstNo(TokenPreferredBankAccountCodeTok, SOShortcutDimension5Code), SOPreferredBankAccountCode);
            DimShortcutBusinessField::EA:
                AppMgt.ShowPageCustomerBankAccount(Rec."Customer No.",
                    StrSubstNo(TokenPreferredBankAccountCodeTok, EAShortcutDimension5Code), EAPreferredBankAccountCode);
            DimShortcutBusinessField::EV:
                AppMgt.ShowPageCustomerBankAccount(Rec."Customer No.",
                    StrSubstNo(TokenPreferredBankAccountCodeTok, EVShortcutDimension5Code), EVPreferredBankAccountCode);
        end;
    end;

    procedure ShowPageReminderTerms()
    begin

    end;

    local procedure AssignBusinessFields(OnClosePage: Boolean)
    begin
        GLSetup.Get();
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        DimensionValue.SetRange("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
        if DimensionValue.FindSet() then
            repeat
                if SetupBusinessField.Get(Rec."Customer No.", DimensionValue.Code) then
                    case SetupBusinessField.Sort of
                        1:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := PBShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := PBShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := PBReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := PBPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := PBPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := PBPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                PBShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                PBShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                PBReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                PBPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                PBPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                PBPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                        2:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := RDShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := RDShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := RDReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := RDPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := RDPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := RDPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                RDShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                RDShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                RDReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                RDPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                RDPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                RDPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                        3:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := RHShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := RHShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := RHReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := RHPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := RHPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := RHPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                RHShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                RHShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                RHReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                RHPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                RHPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                RHPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                        4:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := EAShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := EAShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := EAReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := EAPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := EAPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := EAPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                EAShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                EAShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                EAReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                EAPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                EAPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                EAPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                        5:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := SOShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := SOShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := SOReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := SOPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := SOPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := SOPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                SOShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                SOShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                SOReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                SOPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                SOPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                SOPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                        6:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := EVShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := EVShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := EVReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := EVPaymentTermsCode;
                                SetupBusinessField."Payment Method Code" := EVPaymentMethodCode;
                                SetupBusinessField."Preferred BankAccount Code" := EVPreferredBankAccountCode;
                                SetupBusinessField.Modify();
                            end else begin
                                EVShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                EVShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                EVReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                EVPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                                EVPaymentMethodCode := SetupBusinessField."Payment Method Code";
                                EVPreferredBankAccountCode := SetupBusinessField."Preferred BankAccount Code";
                            end;
                    end;
            until DimensionValue.Next() = 0;
    end;

    local procedure Initialize()
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        PBSetupVisible := UserSetup.PBSetupNVX;
        RDSetupVisible := Usersetup.RDSetupNVX;
        RHSetupVisible := Usersetup.RHSetupNVX;
        EASetupVisible := Usersetup.EASetupNVX;
        SOSetupVisible := Usersetup.SOSetupNVX;
        EVSetupVisible := UserSetup.EVSetupNVX;

        if Rec."customer No." <> '' then begin
            SetupBusinessField.Reset();
            SetupBusinessField.SetRange("Customer No.", Rec."Customer No.");
            if SetupBusinessField.IsEmpty() then
                SetupBusinessField.InsertSetupBusinessField(Rec."Customer No.");
            AppMgt.SetActiveAndStateCustomerBusinessLines(Rec."Customer No.");
        end;
    end;

    local procedure ModifySetupBusinessField()
    begin
        AssignBusinessFields(true);
        AppMgt.SetActiveAndStateCustomerBusinessLines("Customer No.");
    end;

}
