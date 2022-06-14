page 50050 "ReminderControlPCListNVX"
{
    ApplicationArea = All;
    Caption = 'Reminder Control PROFITCENTER', comment = 'DEA="Steuerung Mahnungen PROFITCENTER"';
    PageType = List;
    SourceTable = ReminderControlSetupNVX;
    UsageCategory = Administration;
    CardPageId = ReminderControlSetupCardNVX;
    Editable = false;
    SourceTableView = WHERE(ReminderSetupExtension = filter(PC));
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Activ; Rec.Activ)
                {
                    ToolTip = 'Specifies the value of the Activ field.';
                    ApplicationArea = All;
                }
                field(Address1BusinessField; Rec.Address1BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(Address2BusinessField; Rec.Address2BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(Address3BusinessField; Rec.Address3BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(Address4BusinessField; Rec.Address4BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(Address5BusinessField; Rec.Address5BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(Address6BusinessField; Rec.Address6BusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder Address Businessfield field.', Comment = 'DEA="Mahnadresse Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(CityBusinessField; Rec.CityBusinessField)
                {
                    ToolTip = 'Specifies the value of the Reminder City Businessfield field.', Comment = 'DEA="Mahnort Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo0003BusinessField; Rec.GeneralInfo0003BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo0005BusinessField; Rec.GeneralInfo0005BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo0006BusinessField; Rec.GeneralInfo0006BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo001BusinessField; Rec.GeneralInfo001BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo002BusinessField; Rec.GeneralInfo002BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo0042BusinessField; Rec.GeneralInfo0042BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 02 BusinessField field.', Comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo01BusinessField; Rec.GeneralInfo01BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo02BusinessField; Rec.GeneralInfo02BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo03BusinessField; Rec.GeneralInfo03BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo04BusinessField; Rec.GeneralInfo04BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo05BusinessField; Rec.GeneralInfo05BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field(GeneralInfo06BusinessField; Rec.GeneralInfo06BusinessField)
                {
                    ToolTip = 'Specifies the value of the General Info 01 BusinessField field.', Comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
                    ApplicationArea = All;
                }
                field("RKST Bankaccount"; Rec."RKST Bankaccount")
                {
                    ToolTip = 'Specifies the value of the RKST Bankaccount field.', Comment = 'DEA="Angabe RKST Bankkonto"';
                    ApplicationArea = All;
                }
                field(ReminderSetupExtension; Rec.ReminderSetupExtension)
                {
                    ToolTip = 'Specifies the value of the ReminderSetup Extension field.', Comment = 'DEA="Mahnung Erweiterung"';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = 'DEA="Dim.2: ProfitCenter"';
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Name"; Rec."Shortcut Dimension 2 Name")
                {
                    ToolTip = 'Specifies the value of the Shortcut Dimension 2 Name field.', Comment = 'DEA="Dim.2: ProfitCenter"';
                    ApplicationArea = All;
                }
            }
        }
    }

    trigger OnOpenPage()
    begin
        if Rec.IsEmpty() then begin
            Rec.Init();
            Rec.ReminderSetupExtension := Rec.ReminderSetupExtension::PC;
            Rec.Insert();
        end;
    end;
}
