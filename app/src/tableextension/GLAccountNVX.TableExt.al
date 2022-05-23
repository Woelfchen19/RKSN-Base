tableextension 50001 "GLAccountNVX" extends "G/L Account"
{
    fields
    {
        field(50001; HiddenNVX; Boolean)
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
        field(50002; NoOfClassificationsNVX; Integer)
        {
            Editable = false;
            Caption = 'No. of Classifications', comment = 'DEA="Anzahl Gliederungsgruppen"';
            FieldClass = FlowField;
            CalcFormula = count("NCB Classification G/L Acc." where("G/L Account No." = field("No.")));
        }
        field(50003; ReorgDimCollectedAccountNVX; Code[20])
        {
            Caption = 'Reorganize Dimension collected Account', comment = 'DEA="Umbelast.Dim.Sammelkto"';
            DataClassification = CustomerContent;
            TableRelation = "G/L Account";
        }
    }
}