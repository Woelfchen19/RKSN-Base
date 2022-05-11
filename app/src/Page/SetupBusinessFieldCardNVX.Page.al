page 50032 SetupBusinessFieldCardNVX
{
    Caption = 'BusinessFields Customer Card', comment = 'DEA="Geschäftsfelder Debitor Karte"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = SetupBusinessFieldNVX;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                group(BusinessFields)
                {
                    Caption = 'Business Fields', comment = 'DEA="Geschäftsfelder"';
                    field("Customer No."; Rec."Customer No.")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                        Visible = false;
                    }
                    field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Shortcut Dimension 9 Code" :=
                                AppMgt.OnLookupByBusinessFieldDimension(Rec."Shortcut Dimension 5 Code", 9);
                        end;
                    }
                }
                group(Payment)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field("Reminder Terms Code"; Rec."Reminder Terms Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Reminder Terms Code" := AppMgt.ShowPageReminderTerms(Rec."Shortcut Dimension 5 Code");
                        end;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Payment Terms Code" := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
                        end;
                    }
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Payment Method Code" := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
                        end;
                    }
                    field("Preferred BankAccount Code"; Rec."Preferred BankAccount Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            "Preferred BankAccount Code" :=
                                AppMgt.ShowPageCustomerBankAccount(
                                    StrSubstNo(TokenPreferredBankAccountCodeTok, "Shortcut Dimension 5 Code"));
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
        if UserSetup.Get(UserId) then begin
            // PBSetupVisible := UserSetup.PBSetupNVX;
            // RDSetupVisible := Usersetup.RDSetupNVX;
            // RHSetupVisible := Usersetup.RHSetupNVX;
            // EASetupVisible := Usersetup.EASetupNVX;
            // SOSetupVisible := Usersetup.SOSetupNVX;
            // EVSetupVisible := UserSetup.EVSetupNVX;
            ;
            if Rec."Customer No." <> '' then begin
                SetupBusinessField.Reset();
                SetupBusinessField.SetRange("Customer No.", Rec."Customer No.");
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
                SetupBusinessField2."Customer No." := Rec."Customer No.";
                SetupBusinessField2."Shortcut Dimension 5 Code" := DimensionValue.Code;
                SetupBusinessField2."Dimension Value Type" := DimensionValue."Dimension Value Type";
                SetupBusinessField2.Insert(true);
            until DimensionValue.Next() = 0;
    end;

    local procedure ModifySetupBusinessField()
    begin
        AssignBusinessFields(true);
    end;

    var
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
        SetupBusinessField: Record SetupBusinessFieldNVX;
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;

        // EASetupVisible: Boolean;
        // EVSetupVisible: Boolean;
        // PBSetupVisible: Boolean;
        // RDSetupVisible: Boolean;
        // RHSetupVisible: Boolean;
        // SOSetupVisible: Boolean;
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
        TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"';
}