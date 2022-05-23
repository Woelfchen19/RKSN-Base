pageextension 50038 "GLAccountListNVX" extends "G/L Account List"
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
                NewGBPG := RKSMgt.LookupGenBusinessPostingGroup(FilterOptionNVX::GLAccount);
                if (NewGBPG <> '') then
                    Rec.Validate("Gen. Bus. Posting Group", NewGBPG);
            end;
        }
        addlast(Control1)
        {
            field("No. of Classifications NVX"; Rec.NoOfClassificationsNVX)
            {
                ApplicationArea = All;
                Caption = 'No. of Classifications', comment = 'DEA="Anzahl Gliederungsgruppen"';
                BlankZero = true;
            }
            field(ReorgDimCollectedAccountNVX; Rec.ReorgDimCollectedAccountNVX)
            {
                ToolTip = 'Specifies the value of the Reorganize Dimension collected Account field.', Comment = 'DEA="Umbelast.Dim.Sammelkto"';
                ApplicationArea = All;
            }
        }
    }
}