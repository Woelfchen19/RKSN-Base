pageextension 50037 "GLAccountCardNVX" extends "G/L Account Card"
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
        modify("Gen. Posting Type")
        {
            trigger OnAfterValidate();
            begin
                CurrPage.Update();
            end;
        }
        addafter(Blocked)
        {
            field("Hidden NVX"; "Hidden NVX")
            {
                ApplicationArea = All;
            }
        }
        addlast(General)
        {
            field("Disc. Dim. DetectionNVX"; GLAccountNVX."Disc. Dim. Detection")
            {
                ApplicationArea = All;
                Caption = 'Discount Dimension Detection', comment = 'DEA="Skonto-Dim.Findung"';
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
                end;
            }
            field("No dim distributionNVX"; GLAccountNVX."No dim distribution")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                Caption = 'No dimensional distribution', comment = 'DEA="Dim.Aufbereitung nicht erlaubt"';
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
                end;
            }
            field("Gen. Bsn. Posting Group TypeNVX"; GLAccountNVX."Gen. Bsn. Posting Group Type")
            {
                ApplicationArea = All;
                Editable = PageEditable;
                Caption = 'Gen. Bsn. Posting Group Type', comment = 'DEA="Art Steuerschlüssel"';
                OptionCaption = 'Standard,Exchange', comment = 'DEA="Standard,Wechsel Steuerschlüssel"';
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
                end;
            }
            field("No. of Classifications NVX"; Rec."No. of Classifications NVX")
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
                    Page.RunModal(Page::"NCB Classification G/L Acc.", NCBCLassification)
                end;
            }
        }
    }
    var
        GLAccountNVX: Record GLAccountNVX;
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        if not GLAccountNVX.Get("No.") then begin
            GLAccountNVX.Init();
            GLAccountNVX."G/L Account No." := "No.";
            GLAccountNVX.Insert();
        end;
        PageEditable := CurrPage.Editable();
    end;
}