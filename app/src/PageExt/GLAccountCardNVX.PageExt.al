pageextension 50028 GLAccountCardNVX extends "G/L Account Card"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            Visible = false;
            Enabled = false;
        }
        addafter("Gen. Posting Type")
        {
            field(GenBsnPstGrpNVX; "Gen. Bus. Posting Group")
            {
                ApplicationArea = All;
                trigger OnLookup(Text: Text): Boolean;
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
                        "Gen. Bus. Posting Group" := GBPGRec.Code;
                    end;
                end;
            }
        }
        addlast(General)
        {
            field("Disc. Dim. Detection"; GLAccountNVX."Disc. Dim. Detection")
            {
                ApplicationArea = All;
                Caption = 'Discount Dimension Detection', comment = 'DEA="Skonto-Dim.Findung"';
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
                end;
            }
            field("No dim distribution"; GLAccountNVX."No dim distribution")
            {
                ApplicationArea = All;
                Caption = 'No dimensional distribution', comment = 'DEA="Dim.Aufbereitung nicht erlaubt"';
                trigger OnValidate();
                begin
                    GLAccountNVX.Modify();
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