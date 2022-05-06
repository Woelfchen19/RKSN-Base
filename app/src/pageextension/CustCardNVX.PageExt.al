pageextension 50002 "CustCardNVX" extends "Customer Card"
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


                field(PBSetupNVX; UserSetup.PBSetupNVX)
                {
                    ToolTip = 'PBSetup', comment = 'DEA="PBSetup"';
                    ApplicationArea = All;
                }
            }
            group(SetupBusinessFieldEVNVX)
            {
                Caption = 'Evidence - EV', comment = 'DEA="Evidenz - EV"';
                Visible = EVSetupVisible;


                field(EVSetupNVX; UserSetup.EVSetupNVX)
                {
                    ToolTip = 'EVSetup', comment = 'DEA="EVSetup"';
                    ApplicationArea = All;
                }
            }

        }
    }

    trigger OnOpenPage()
    begin
        UserSetup.Get(userid);
        PBSetupVisible := UserSetup.PBSetupNVX;
        EVSetupVisible := UserSetup.EVSetupNVX;
        // Message((format(PBSetupVisible)));
    end;

    var
        UserSetup: Record "User Setup";
        PBSetupVisible: Boolean;
        EVSetupVisible: Boolean;
}
