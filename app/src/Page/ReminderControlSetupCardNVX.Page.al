page 50044 "ReminderControlSetupCardNVX"
{
    Caption = 'ReminderControlSetupCard', comment = 'DEA="Steuerung Mahnungen Karte"';
    PageType = Card;
    SourceTable = ReminderControlSetupNVX;

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                field(Activ; Rec.Activ)
                {
                    ToolTip = 'Specifies the value of the Activ field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Name"; Rec."Shortcut Dimension 2 Name")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Name field.';
                    ApplicationArea = All;
                }
                field("RKST Bankaccount"; Rec."RKST Bankaccount")
                {
                    ToolTip = 'Specifies the value of the RKST Bankaccount field.';
                    ApplicationArea = All;
                    Visible = RKSTBankaccountVisible;
                }
                field("Reminder Associated"; Rec."Reminder Associated")
                {
                    ToolTip = 'Specifies the value of the Reminder Assosiated field.';
                    ApplicationArea = All;
                }
            }
            group(Address)
            {
                Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
                field(Address1BusinessField; Rec.Address1BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(Address2BusinessField; Rec.Address2BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(Address3BusinessField; Rec.Address3BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(Address4BusinessField; Rec.Address4BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(Address5BusinessField; Rec.Address5BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(Address6BusinessField; Rec.Address6BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.';
                    ApplicationArea = All;
                }
                field(CityBusinessField; Rec.CityBusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder City Businessfield field.';
                    ApplicationArea = All;
                }
            }
            group(GeneralInfo01)
            {
                Caption = 'General Info 01 businessfield', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                field(GeneralInfo01BusinessField; Rec.GeneralInfo01BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo02BusinessField; Rec.GeneralInfo02BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo03BusinessField; Rec.GeneralInfo03BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo04BusinessField; Rec.GeneralInfo04BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo05BusinessField; Rec.GeneralInfo05BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo06BusinessField; Rec.GeneralInfo06BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.';
                    ApplicationArea = All;
                }
            }
            group(GeneralInfo02)
            {
                Caption = 'General Info 02 businessfield', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                field(GeneralInfo001BusinessField; Rec.GeneralInfo001BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo002BusinessField; Rec.GeneralInfo002BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo0003BusinessField; Rec.GeneralInfo0003BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo0042BusinessField; Rec.GeneralInfo0042BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo0005BusinessField; Rec.GeneralInfo0005BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
                field(GeneralInfo0006BusinessField; Rec.GeneralInfo0006BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        RKSTBankaccountVisible := (Rec.ReminderSetupExtension = Rec.ReminderSetupExtension::BusinessField);
    end;

    var
        RKSTBankaccountVisible: Boolean;
}
