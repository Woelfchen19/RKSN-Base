tableextension 50004 GLAccountNVX extends "G/L Account"
{
    fields
    {
        field(50001; "Hidden NVX"; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Hidden', comment = 'DEA="Sachkonto ausblenden"';

            trigger OnValidate()
            var
                GLAccount: Record "G/L Account";
                Balance_Err: Label 'You can not hide the G/L Account because Balance ist <> 0.', comment = 'DEA="Das Sachkonto kann nicht ausgeblendet werden, weil der Saldo <>0 ist!"';
            begin
                TestField("No.");
                GLAccount.get("No.");
                GLAccount.CalcFields(Balance);
                if GLAccount.Balance <> 0 then
                    error(Balance_Err);
            end;
        }
    }
}



