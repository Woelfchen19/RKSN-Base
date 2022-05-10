pageextension 50002 "CustomerCardNVX" extends "Customer Card"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text): Boolean;
            var
                RKSMgt: Codeunit AllocationMgtNVX;
                NewGBPG: Code[20];
                FilterOptionNVX: Enum FilterOptionNVX;
            begin
                NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::Customer);
                if (NewGBPG <> '') then
                    Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
            end;
        }
        addafter(Statistics)
        {
            group(SetupBusinessFieldPBNVX)
            {
                Caption = 'Care and Support', comment = 'DEA="Pflege und Betreuung - PB"';
                Visible = PBSetupVisible;

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
                    Importance = Additional;
                    CaptionClass = '1,2,9';
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PBShortcutDimension9Code := AppMgt.OnLookupByBusinessFieldDimension(PBShortcutDimension5Code, 9);
                    end;
                }
                field(PBHReminderTermsCodeNVX; PBReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PBReminderTermsCode := AppMgt.ShowPageReminderTerms(PBShortcutDimension5Code);
                    end;
                }
                field(PBPaymentTermsCodeNVX; PBPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    Importance = Additional;
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        PBPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
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
                        PBPaymentMethodCode := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
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
                        PBPreferredBankAccountCode :=
                            AppMgt.ShowPageCustomerBankAccount(
                                StrSubstNo(TokenPreferredBankAccountCodeTok, PBShortcutDimension5Code));
                    end;
                }
            }
            group(SetupBusinessFieldRDNVX)
            {
                Caption = 'Emergency Assistence - RD', comment = 'DEA="Rettungsdienst - RD"';
                Visible = RDSetupVisible;

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
                    Importance = Additional;
                    CaptionClass = '1,2,9';
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RDShortcutDimension9Code := AppMgt.OnLookupByBusinessFieldDimension(RDShortcutDimension5Code, 9);
                    end;
                }
                field(RDHReminderTermsCodeNVX; RDReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RDReminderTermsCode := AppMgt.ShowPageReminderTerms(RDShortcutDimension5Code);
                    end;
                }
                field(RDPaymentTermsCodeNVX; RDPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    Importance = Additional;
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RDPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
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
                        RDPaymentMethodCode := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
                    end;
                }
                field(RDPreferredBankAccountCodeNVX; RDPreferredBankAccountCode)
                {
                    ApplicationArea = All;
                    Caption = 'Preferred Bank Account Code', comment = 'DEA="Bevorzugter Bankkkontocode"';
                    TableRelation = "Customer Bank Account";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RDPreferredBankAccountCode :=
                            AppMgt.ShowPageCustomerBankAccount(
                                StrSubstNo(TokenPreferredBankAccountCodeTok, RDShortcutDimension5Code));
                    end;
                }
            }
            group(SetupBusinessFieldRHNVX)
            {
                Caption = 'Call Help - RH', comment = 'DEA="Rufhilfe - RH"';
                Visible = RHSetupVisible;

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
                    Importance = Additional;
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RHShortcutDimension9Code := AppMgt.OnLookupByBusinessFieldDimension(RHShortcutDimension5Code, 9);
                    end;
                }
                field(RHReminderTermsCodeNVX; RHReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RHReminderTermsCode := AppMgt.ShowPageReminderTerms(RHShortcutDimension5Code);
                    end;
                }
                field(RHPaymentTermsCodeNVX; RHPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    Importance = Additional;
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        RHPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
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
                        RHPaymentMethodCode := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
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
                        RHPreferredBankAccountCode :=
                            AppMgt.ShowPageCustomerBankAccount(
                                StrSubstNo(TokenPreferredBankAccountCodeTok, RHShortcutDimension5Code));
                    end;
                }
            }
            group(SetupBusinessFieldEANVX)
            {
                Caption = 'Food on Wheels - EA', comment = 'DEA="Essen auf Rädern - EA"';
                Visible = EASetupVisible;

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
                    Importance = Additional;
                    CaptionClass = '1,2,9';
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EAShortcutDimension9Code := AppMgt.OnLookupByBusinessFieldDimension(EAShortcutDimension5Code, 9);
                    end;
                }
                field(EAReminderTermsCodeNVX; EAReminderTermsCode)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EAReminderTermsCode := AppMgt.ShowPageReminderTerms(EAShortcutDimension5Code);
                    end;
                }
                field(EAPaymentTermsCodeNVX; EAPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';

                    trigger OnLookup(var Text: Text): Boolean
                    begin
                        EAPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
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
                        EAPaymentMethodCode := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
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
                        EAPreferredBankAccountCode :=
                            AppMgt.ShowPageCustomerBankAccount(
                                StrSubstNo(TokenPreferredBankAccountCodeTok, EAShortcutDimension5Code));
                    end;
                }

                group(SetupBusinessFieldSONVX)
                {
                    Caption = 'Miscellanious - SO', comment = 'DEA="Sonstiges - SO"';
                    Visible = SOSetupVisible;

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
                        Importance = Additional;
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            SOShortcutDimension9Code := AppMgt.OnLookupByBusinessFieldDimension(SOShortcutDimension5Code, 9);
                        end;
                    }
                    field(SOReminderTermsCodeNVX; SOReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        Importance = Additional;
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            SOReminderTermsCode := AppMgt.ShowPageReminderTerms(SOShortcutDimension5Code);
                        end;
                    }
                    field(SOPaymentTermsCodeNVX; SOPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Importance = Additional;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            SOPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
                        end;
                    }
                }
                group(SetupBusinessFieldEVNVX)
                {
                    Caption = 'Evidence - EV', comment = 'DEA="Evidenz - EV"';
                    Visible = EVSetupVisible;

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
                        Importance = Additional;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            EVShortcutDimension9Code :=
                                AppMgt.OnLookupByBusinessFieldDimension(EVShortcutDimension5Code, 9);
                        end;
                    }
                    field(EVReminderTermsCodeNVX; EVReminderTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                        Importance = Additional;
                        TableRelation = "Reminder Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            EVReminderTermsCode := AppMgt.ShowPageReminderTerms(EVShortcutDimension5Code);
                        end;
                    }
                    field(EVPaymentTermsCodeNVX; EVPaymentTermsCode)
                    {
                        ApplicationArea = All;
                        Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                        Importance = Promoted;
                        TableRelation = "Payment Terms";
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            EVPaymentTermsCode := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
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

    /// <summary>
    /// ToDo 
    /// Variables should be an Array 
    /// e.g. PBPreferredBankAccountCode -> PreferredBankAccountCode[i]
    /// </summary>
    /// <param name="OnClosePage"></param>
    local procedure AssignBusinessFields(OnClosePage: Boolean)
    begin
        GLSetup.Get();
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        if DimensionValue.FindSet() then
            repeat
                if SetupBusinessField.Get(Rec."No.", DimensionValue.Code) then
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
        if UserSetup.Get(UserId) then begin
            PBSetupVisible := UserSetup.PBSetupNVX;
            RDSetupVisible := Usersetup.RDSetupNVX;
            RHSetupVisible := Usersetup.RHSetupNVX;
            EASetupVisible := Usersetup.EASetupNVX;
            SOSetupVisible := Usersetup.SOSetupNVX;
            EVSetupVisible := UserSetup.EVSetupNVX;

            if Rec."No." <> '' then begin
                SetupBusinessField.Reset();
                SetupBusinessField.SetRange("Customer No.", Rec."No.");
                if SetupBusinessField.IsEmpty() then
                    InsertSetupBusinessField();
            end;
        end;
    end;

    local procedure InsertSetupBusinessField()
    var
        SetupBusinessField2: Record SetupBusinessFieldNVX;
    begin
        GLSetup.Get();
        DimensionValue.Reset();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        if DimensionValue.FindSet() then
            repeat
                SetupBusinessField2.Init();
                SetupBusinessField2."Customer No." := Rec."No.";
                SetupBusinessField2."Shortcut Dimension 5 Code" := DimensionValue.Code;
                SetupBusinessField2.Insert(true);
            until DimensionValue.Next() = 0;
    end;

    local procedure ModifySetupBusinessField()
    begin
        AssignBusinessFields(true);
    end;

    var
        DimensionValue: Record "Dimension Value";
        SetupBusinessField: Record SetupBusinessFieldNVX;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        AppMgt: Codeunit AppMgtNVX;
        PBShortcutDimension5Code: Code[20];

        RDShortcutDimension5Code: Code[20];
        RHShortcutDimension5Code: Code[20];
        EAShortcutDimension5Code: Code[20];
        SOShortcutDimension5Code: Code[20];
        EVShortcutDimension5Code: Code[20];

        PBShortcutDimension9Code: Code[20];
        RDShortcutDimension9Code: Code[20];
        RHShortcutDimension9Code: Code[20];
        EAShortcutDimension9Code: Code[20];
        SOShortcutDimension9Code: Code[20];
        EVShortcutDimension9Code: Code[20];

        PBReminderTermsCode: Code[10];
        RDReminderTermsCode: Code[10];
        RHReminderTermsCode: Code[10];
        EAReminderTermsCode: Code[10];
        SOReminderTermsCode: Code[10];
        EVReminderTermsCode: Code[10];

        PBPaymentTermsCode: Code[10];
        RDPaymentTermsCode: Code[10];
        RHPaymentTermsCode: Code[10];
        EAPaymentTermsCode: Code[10];
        SOPaymentTermsCode: Code[10];
        EVPaymentTermsCode: Code[10];

        PBPaymentMethodCode: Code[10];
        RDPaymentMethodCode: Code[10];
        RHPaymentMethodCode: Code[10];
        EAPaymentMethodCode: Code[10];
        SOPaymentMethodCode: Code[10];
        EVPaymentMethodCode: Code[10];

        PBPreferredBankAccountCode: Code[20];
        RDPreferredBankAccountCode: Code[20];
        RHPreferredBankAccountCode: Code[20];
        EAPreferredBankAccountCode: Code[20];
        SOPreferredBankAccountCode: Code[20];
        EVPreferredBankAccountCode: Code[20];

        EASetupVisible: Boolean;
        EVSetupVisible: Boolean;
        PBSetupVisible: Boolean;
        RDSetupVisible: Boolean;
        RHSetupVisible: Boolean;
        SOSetupVisible: Boolean;

        TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"';
}
