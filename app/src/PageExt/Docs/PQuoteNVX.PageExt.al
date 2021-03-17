pageextension 50012 PQuoteNVX extends "Purchase Quote"
{
    layout
    {
        
        addfirst("Invoice Details")
        {
            field(GenBsnPstGrpNVX;"Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                trigger OnLookup(Text : Text) : Boolean;
                var
                    GBPGRec: Record "Gen. Business Posting Group";
                    GenBsnPstGrpNVX: Record GenBsnPstGrpNVX;
                    GBPGPage: Page "Gen. Business Posting Groups";
                begin
                    Clear(GBPGPage);
                    GBPGRec.Reset();
                    repeat
                        if GenBsnPstGrpNVX.Get(GBPGRec.Code) and GenBsnPstGrpNVX."Filter Purchase Quote" then
                            GBPGRec.Mark(true);
                    until GBPGRec.Next() = 0;
                    GBPGRec.MarkedOnly(true);
                    GBPGPage.SetRecord(GBPGRec);
                    GBPGPage.SetTableView(GBPGRec);
                    GBPGPage.LookupMode(true);
                    if GBPGPage.RunModal() = "Action"::LookupOK then begin
                        GBPGPage.GetRecord(GBPGRec);
                        "Gen. Bus. Posting Group" := GBPGRec.Code;
                    end;
                end;
            }
            field("Shortcut Dimension 1 Code NVX"; DocInfoNVX."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    DocInfoNVX.Modify();
                end;
            }            
            field("Shortcut Dimension 3 Code NVX"; DocInfoNVX."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    DocInfoNVX.Modify();
                end;
            }
            field("Interim Gen.Bus.Posting Group"; DocInfoNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group";
                Editable = PageEditable;
                trigger OnValidate();
                begin
                    DocInfoNVX.Modify();
                end;
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(PreviewDimDistribution)
            {
                Caption = 'Preview dimensional distribution', comment = 'DEA="Vorschau dimensionaler Verteilungsprozess"';
                Image = PreviewChecks;
                Promoted = true;
                PromotedIsBig = true;
                PromotedCategory = Process;
                trigger OnAction();
                var
                    DistrPurchLine: Record DistrPurchLineNVX;
                    PreviewPurchDimDistrPage: Page PreviewPurchDimDistrNVX;
                begin
                    OnPreviewDimDistribution(Rec);
                    DistrPurchLine.SetRange("Document Type",Rec."Document Type");
                    DistrPurchLine.SetRange("Document No.",Rec."No.");
                    PreviewPurchDimDistrPage.SetRecord(DistrPurchLine);
                    PreviewPurchDimDistrPage.SetTableView(DistrPurchLine);
                    PreviewPurchDimDistrPage.Run();
                end;
            }
        }
    }
    
    var
        DocInfoNVX: Record DocInfoNVX;
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        If not DocInfoNVX.Get(DocInfoNVX.Department::Purchase,"Document Type","No.") then begin
            DocInfoNVX.Init();
            DocInfoNVX.Department := DocInfoNVX.Department::Purchase;
            DocInfoNVX."Document Type" := "Document Type";
            DocInfoNVX."Document No." := "No.";
            DocInfoNVX.Insert();
        end;
        PageEditable := CurrPage.Editable;
    end;

    trigger OnOpenPage();
    begin
        PageEditable := CurrPage.Editable;
    end;

    [IntegrationEvent(false,false)]
    local procedure OnPreviewDimDistribution(var PurchaseHeader: Record "Purchase Header")
    begin
    end;
}