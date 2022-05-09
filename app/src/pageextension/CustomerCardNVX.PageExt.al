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
                    CaptionClass = '1,2,9';
                    Importance = Additional;
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(PBReminderTermsCodeNVX; PBReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(PBPaymentTermsCodeNVX; PBPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    Importance = Additional;
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';
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
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RDHReminderTermsCodeNVX; RDReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RDPaymentTermsCodeNVX; RDPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    Importance = Additional;
                    ToolTip = '', comment = 'DEA=""';
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
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RHReminderTermsCodeNVX; RHReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RHPaymentTermsCodeNVX; RHPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    Importance = Additional;
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';
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
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EAReminderTermsCodeNVX; EAReminderTermsCode)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EAPaymentTermsCodeNVX; EAPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
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
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(SOReminderTermsCodeNVX; SOReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(SOPaymentTermsCodeNVX; SOPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Importance = Additional;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';
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
                    TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EVReminderTermsCodeNVX; EVReminderTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    Importance = Additional;
                    TableRelation = "Reminder Terms";
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EVPaymentTermsCodeNVX; EVPaymentTermsCode)
                {
                    ApplicationArea = All;
                    Caption = 'Payment Terms Code', comment = 'DEA="Zlg. Bedingungscode"';
                    Importance = Promoted;
                    TableRelation = "Payment Terms";
                    ToolTip = '', comment = 'DEA=""';
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
                                SetupBusinessField.Modify();
                            end else begin
                                PBShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                PBShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                PBReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                PBPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                            end;
                        2:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := RDShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := RDShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := RDReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := RDPaymentTermsCode;
                                SetupBusinessField.Modify();
                            end else begin
                                RDShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                RDShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                RDReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                RDPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                            end;
                        3:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := RHShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := RHShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := RHReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := RHPaymentTermsCode;
                                SetupBusinessField.Modify();
                            end else begin
                                RHShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                RHShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                RHReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                RHPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                            end;
                        4:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := EAShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := EAShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := EAReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := EAPaymentTermsCode;
                                SetupBusinessField.Modify();
                            end else begin
                                EAShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                EAShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                EAReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                EAPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                            end;
                        5:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := SOShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := SOShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := SOReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := SOPaymentTermsCode;
                                SetupBusinessField.Modify();
                            end else begin
                                SOShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                SOShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                SOReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                SOPaymentTermsCode := SetupBusinessField."Payment Terms Code";
                            end;
                        6:
                            if OnClosePage then begin
                                SetupBusinessField."Shortcut Dimension 5 Code" := EVShortcutDimension5Code;
                                SetupBusinessField."Shortcut Dimension 9 Code" := EVShortcutDimension9Code;
                                SetupBusinessField."Reminder Terms Code" := EVReminderTermsCode;
                                SetupBusinessField."Payment Terms Code" := EVPaymentTermsCode;
                                SetupBusinessField.Modify();
                            end else begin
                                EVShortcutDimension5Code := SetupBusinessField."Shortcut Dimension 5 Code";
                                EVShortcutDimension9Code := SetupBusinessField."Shortcut Dimension 9 Code";
                                EVReminderTermsCode := SetupBusinessField."Reminder Terms Code";
                                EVPaymentTermsCode := SetupBusinessField."Payment Terms Code";
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
                SetupBusinessField.SetRange(CustomerNo, Rec."No.");
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
                SetupBusinessField2.CustomerNo := Rec."No.";
                SetupBusinessField2."Shortcut Dimension 5 Code" := DimensionValue.Code;
                SetupBusinessField2.Insert(true);
            until DimensionValue.Next() = 0;
    end;

    local procedure ModifySetupBusinessField()
    begin
        AssignBusinessFields(true);
    end;

    var
        SetupBusinessField: Record SetupBusinessFieldNVX;
        UserSetup: Record "User Setup";
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";

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
        EASetupVisible: Boolean;
        EVSetupVisible: Boolean;
        PBSetupVisible: Boolean;
        RDSetupVisible: Boolean;
        RHSetupVisible: Boolean;
        SOSetupVisible: Boolean;
}
