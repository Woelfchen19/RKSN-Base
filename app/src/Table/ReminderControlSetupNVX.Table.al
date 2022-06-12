table 50050 "ReminderControlSetupNVX"
{
    fields
    {
        field(1; ReminderSetupExtension; enum ReminderSetupExtensionNVX)
        {
            Caption = 'ReminderSetup Extension', comment = 'DEA="Mahnung Erweiterung"';
        }
        field(2; Activ; Boolean)
        {
            Caption = 'Activ', comment = 'DEA="Aktiv"';
        }
        field(3; Address1BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(4; Address2BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(5; Address3BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(6; Address4BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(7; Address5BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(8; Address6BusinessField; Text[50])
        {
            Caption = 'Reminder Address Businessfield', comment = 'DEA="Mahnadresse Geschäftsfeld"';
        }
        field(9; CityBusinessField; Text[20])
        {
            Caption = 'Reminder City Businessfield', comment = 'DEA="Mahnort Geschäftsfeld"';
        }
        field(10; GeneralInfo01BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(11; GeneralInfo02BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(12; GeneralInfo03BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(13; GeneralInfo04BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(14; GeneralInfo05BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(15; GeneralInfo06BusinessField; Text[30])
        {
            Caption = 'General Info 01 BusinessField', comment = 'DEA="Allgem. Info 01 Geschäftsfeld"';
        }
        field(16; GeneralInfo001BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(17; GeneralInfo002BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(18; GeneralInfo0003BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(19; GeneralInfo0042BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(20; GeneralInfo0005BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(21; GeneralInfo0006BusinessField; Text[45])
        {
            Caption = 'General Info 02 BusinessField', comment = 'DEA="Allgem. Info 02 Geschäftsfeld"';
        }
        field(22; "Shortcut Dimension 2 Name"; Text[50])
        {
            Caption = 'Shortcut Dimension 2 Name', comment = 'DEA="Dim.2: ProfitCenter"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where(Code = field("Shortcut Dimension 2 Code")));
        }
        field(23; "Shortcut Dimension 2 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 2 Code', comment = 'DEA="Dim.2: ProfitCenter"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2), Blocked = CONST(false));
        }
        field(24; "RKST Bankaccount"; Code[20])
        {
            TableRelation = "Bank Account";
            Caption = 'RKST Bankaccount', comment = 'DEA="Angabe RKST Bankkonto"';
        }
        field(25; "Reminder Associated"; Code[10])
        {
            Caption = 'Reminder Assosiated', comment = 'DEA="Mahnung zugehörig"';
            DataClassification = CustomerContent;
            TableRelation = SetupAssociatedNVX;
        }
    }

    keys
    {
        key(key1; ReminderSetupExtension)
        {
            Clustered = true;
        }
    }
}