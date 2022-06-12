pageextension 50001 "ChartOfAccountsNVX" extends "Chart of Accounts"
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
            field("Disc. Dim. DetectionNVX"; GLAccountNVX."Disc. Dim. Detection")
            {
                ApplicationArea = All;
                Caption = 'Discount Dimension Detection', comment = 'DEA="Skonto-Dim.Findung"';
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
                end;
            }
            field("No. of Classifications NVX"; Rec.NoOfClassificationsNVX)
            {
                ApplicationArea = All;
                Caption = 'No. of Classifications', comment = 'DEA="Anzahl Gliederungsgruppen"';
                BlankZero = true;
            }
        }
    }

    actions
    {
        addlast(Navigation)
        {
            action(NCBClassificationNVX)
            {
                ApplicationArea = All;
                Caption = 'Classification', comment = 'DEA="Gliederungsgruppen"';
                Image = ViewDetails;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    NCBCLassification: Record "NCB Classification G/L Acc.";
                begin
                    NCBCLassification.SetRange("G/L Account No.", Rec."No.");
                    Page.RunModal(Page::"NCB Classification G/L Acc.");
                end;
            }
        }
    }

    var
        GLAccountNVX: Record GLAccountNVX;

    trigger OnAfterGetRecord();
    begin
        if not GLAccountNVX.Get("No.") then begin
            GLAccountNVX.Init();
            GLAccountNVX."G/L Account No." := "No.";
            GLAccountNVX.Insert();
        end;
    end;
}