pageextension 50002 CustomerCardNVX extends "Customer Card"
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


                // field(PBSetupNVX; UserSetup.PBSetupNVX)
                // {
                //     ApplicationArea = All;
                //     ToolTip = 'PBSetup', comment = 'DEA="PBSetup"';
                // }

                //ToDo
                //Show Shortcutdim5 PB -> Geschäftsfall -> PB
                field(PBShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(1))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(PBReminderTermsCodeNVX; ReminderTermsCode.Get(1))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
            group(SetupBusinessFieldRDNVX)
            {
                Caption = 'Emergency Assistence', comment = 'DEA="Rettungsdienst"';
                Visible = RDSetupVisible;

                field(RDShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(2))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RDHReminderTermsCodeNVX; ReminderTermsCode.Get(2))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
            group(SetupBusinessFieldRHNVX)
            {
                Caption = 'Call Help - RH', comment = 'DEA="Rufhilfe - RH"';
                Visible = EVSetupVisible;

                field(RHShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(3))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(RHReminderTermsCodeNVX; ReminderTermsCode.Get(3))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
            group(SetupBusinessFieldEANVX)
            {
                Caption = 'Food on Wheels - EA', comment = 'DEA="Essen auf Rädern - EA"';
                Visible = EVSetupVisible;

                field(EAShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(4))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EAReminderTermsCodeNVX; ReminderTermsCode.Get(4))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
            group(SetupBusinessFieldSONVX)
            {
                Caption = 'Miscellanious - SO', comment = 'DEA="Sonstiges - SO"';
                Visible = EVSetupVisible;

                field(SOShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(5))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(SOReminderTermsCodeNVX; ReminderTermsCode.Get(5))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
            group(SetupBusinessFieldEVNVX)
            {
                Caption = 'Evidence - EV', comment = 'DEA="Evidenz - EV"';
                Visible = EVSetupVisible;

                field(EVShortcutDimension9CodeNVX; ShortcutDimension9Code.Get(2))
                {
                    ApplicationArea = All;
                    Caption = 'Shortcut Dimension 9 Code';
                    ToolTip = '', comment = 'DEA=""';
                }
                field(EVReminderTermsCodeNVX; ReminderTermsCode.Get(2))
                {
                    ApplicationArea = All;
                    Caption = 'Reminder Terms Code', comment = 'DEA="Mahnungsmethodencode"';
                    ToolTip = '', comment = 'DEA=""';
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Get(userid);
        PBSetupVisible := UserSetup.PBSetupNVX;
        EVSetupVisible := UserSetup.EVSetupNVX;

        Initialize();
        AssingnBusinessFields();
    end;

    var
        SetupBusinessField: Record SetupBusinessFieldNVX;
        UserSetup: Record "User Setup";
        EASetupVisible: Boolean;
        EVSetupVisible: Boolean;
        PBSetupVisible: Boolean;
        RDSetupVisible: Boolean;
        RHSetupVisible: Boolean;
        SOSetupVisible: Boolean;
        BusinessField: List of [Code[20]];
        ReminderTermsCode: List of [Code[20]];
        ShortcutDimension9Code: List of [Code[20]];

    local procedure AssignBusinessField(DimensionCode: Code[20])
    begin
        if SetupBusinessField.Get(Rec."No.", DimensionCode) then begin
            ShortcutDimension9Code.Add(SetupBusinessField."Shortcut Dimension 9 Code");
            ReminderTermsCode.Add(SetupBusinessField."Reminder Terms Code");
        end;
    end;

    local procedure AssingnBusinessFields()
    var
        DimensionCode: Code[20];
    begin
        foreach DimensionCode in BusinessField do
            AssignBusinessField(DimensionCode);
    end;

    local procedure Initialize()
    var
        DimensionValue: Record "Dimension Value";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        DimensionValue.SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        if DimensionValue.FindSet() then
            repeat
                BusinessField.Add(DimensionValue.Code);
            until DimensionValue.Next() = 0;
    end;
}
