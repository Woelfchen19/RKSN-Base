table 50051 "BankAccountNVX"
{
    Caption = 'Bank Account';
    DataCaptionFields = "No.";

    fields
    {
        field(1; "No."; Code[20])
        {
            Caption = 'No.', comment = 'DEA="Nr."';
        }
        field(2; ReminderBankInfo1; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
        field(3; ReminderBankInfo2; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
        field(4; ReminderBankInfo3; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
        field(5; ReminderBankInfo4; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
        field(6; ReminderBankInfo5; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
        field(7; ReminderBankInfo6; Text[100])
        {
            Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
        }
    }

    keys
    {
        key(Key1; "No.")
        {
            Clustered = true;
        }
    }
    procedure GetDefinition(No: Code[20])
    begin
        if No = "No." then
            exit;
        if Get(No) then
            exit;

        Init();
        "No." := No;
        Insert();
    end;

    procedure ModifyBankaccount()
    var
        BankAccount: record BankAccountNVX;
    begin
        BankAccount.Get(Rec."No.");
        BankAccount.TransferFields(Rec);
        BankAccount.Modify();
    end;
}