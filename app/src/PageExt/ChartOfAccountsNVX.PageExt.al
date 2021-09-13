pageextension 50016 "ChartOfAccountsNVX" extends "Chart of Accounts"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {              
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
        }
        addlast(Control1)
        {
            field("No. of Classifications NVX";"No. of Classifications NVX")
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
                    NCBCLassification.SetRange("G/L Account No.", rec."No.");
                    page.RunModal(1011161, NCBCLassification)
                end;
            }
        }
    }
    var
        GLAccountNVX: Record GLAccountNVX;

    trigger OnAfterGetRecord();
    begin
        IF not GLAccountNVX.Get("No.") then begin
            GLAccountNVX.Init();
            GLAccountNVX."G/L Account No." := "No.";
            GLAccountNVX.Insert();
        end;
    end;
}