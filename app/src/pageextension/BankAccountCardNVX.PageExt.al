pageextension 50071 "BankAccountCardNVX" extends "Bank Account Card"
{
    layout
    {
        addlast(Content)
        {
            Group(ReminderBankInformationNVX)
            {
                Caption = 'Reminder Bankinformation', comment = 'DEA="Angaben Bankinformation Mahnwesen"';

                field(BankAccountReminderBankInfo1NVX; BankAccount.ReminderBankInfo1)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
                field(BankAccountReminderBankInfo2NVX; BankAccount.ReminderBankInfo2)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
                field(BankAccountReminderBankInfo3NVX; BankAccount.ReminderBankInfo3)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
                field(BankAccountReminderBankInfo4NVX; BankAccount.ReminderBankInfo4)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
                field(BankAccountReminderBankInfo5NVX; BankAccount.ReminderBankInfo5)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
                field(BankAccountReminderBankInfo6NVX; BankAccount.ReminderBankInfo6)
                {
                    ApplicationArea = All;
                    Caption = 'Bankinfo Reminder', comment = 'DEA="Bankinformation Mahnwesen"';
                    ShowCaption = false;
                }
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        BankAccount.GetDefinition(Rec."No.");
    end;

    trigger OnClosePage()
    begin
        BankAccount.ModifyBankaccount();
    end;

    var
        BankAccount: Record BankAccountNVX;
}