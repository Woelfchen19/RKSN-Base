pageextension 50028 "GLAccountCardNVX" extends "G/L Account Card"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
            Enabled = false;
        }
        modify("Gen. Posting Type")
        {
            trigger OnAfterValidate();
            begin
                CurrPage.Update();
            end;
        }
        addafter("Gen. Posting Type")
        {
            field(GenBsnPstGrpNVX; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                trigger OnLookup(var Text: Text): Boolean;
                var
                    GBPGRec: Record "Gen. Business Posting Group";
                    GenBsnPstGrpNVX: Record GenBsnPstGrpNVX;
                    GBPGPage: Page "Gen. Business Posting Groups";
                begin
                    Clear(GBPGPage);
                    GBPGRec.Reset();
                    repeat
                        if GenBsnPstGrpNVX.Get(GBPGRec.Code) and GenBsnPstGrpNVX."Filter G/L Account" then
                            GBPGRec.Mark(true);
                    until GBPGRec.Next() = 0;
                    GBPGRec.MarkedOnly(true);
                    GBPGPage.SetRecord(GBPGRec);
                    GBPGPage.SetTableView(GBPGRec);
                    GBPGPage.LookupMode(true);
                    if GBPGPage.RunModal() = "Action"::LookupOK then begin
                        GBPGPage.GetRecord(GBPGRec);
                        Rec.Validate("Gen. Bus. Posting Group", GBPGRec.Code);
                    end;
                end;
            }
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
                    NCBCLassification.SetRange("G/L Account No.", rec."No.");
                    page.RunModal(1011161, NCBCLassification)
                end;
            }
        }
    }
    var
        GLAccountNVX: Record GLAccountNVX;
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        IF not GLAccountNVX.Get("No.") then begin
            GLAccountNVX.Init();
            GLAccountNVX."G/L Account No." := "No.";
            GLAccountNVX.Insert();
        end;
        PageEditable := CurrPage.Editable();
    end;
}