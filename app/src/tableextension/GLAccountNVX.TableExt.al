tableextension 50001 GLAccountNVX extends "G/L Account"
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
                GLAccount.Get("No.");
                GLAccount.CalcFields(Balance);
                if GLAccount.Balance <> 0 then
                    Error(Balance_Err);
            end;
        }
        field(50002; "No. of Classifications NVX"; Integer)
        {
            Editable = false;
            Caption = 'No. of Classifications', comment = 'DEA="Anzahl Gliederungsgruppen"';
            FieldClass = FlowField;
            CalcFormula = count("NCB Classification G/L Acc." where("G/L Account No." = field("No.")));
        }
    }
}