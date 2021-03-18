pageextension 50023 SQuoteSubSubNVX extends "Sales Quote Subform"
{
    layout
    {
        modify("VAT Prod. Posting Group")
        {
            Enabled = false;
            Visible = false;
        }
        addlast(Control1)
        {
            field("Gen. Bus. Posting Group NVX";"Gen. Bus. Posting Group")
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
                        if GenBsnPstGrpNVX.Get(GBPGRec.Code) and GenBsnPstGrpNVX."Filter Sales Cr. Memo" then
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
            field("Gen. P Posting Group NVX"; "Gen. Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Bus. Posting Group NVX";"VAT Bus. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }
            field("VAT Prod. Posting Group NVX";"VAT Prod. Posting Group")
            {
                ApplicationArea = All;
                Editable = false;
            }          
            
            field("Allocation Code"; AllocationCodeVar)
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup or journal line!', 
                    comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter im Buchungsblatt! Überprüfen Sie bitte Ihre Angabe."';
                begin
                    IF Rec."Line No." > 0 then
                        IF not SalesLineNVX.Get(Rec."Document Type", Rec."Document No.", Rec."Line No.") then begin
                            SalesLineNVX.Init();
                            SalesLineNVX."Document Type" := Rec."Document Type";
                            SalesLineNVX."Document No." := Rec."Document No.";
                            SalesLineNVX."Line No." := Rec."Line No.";
                            SalesLineNVX."Allocation Code" := AllocationCodeVar;
                            SalesLineNVX.Insert();
                        end else begin
                            SalesLineNVX."Allocation Code" := AllocationCodeVar;
                            SalesLineNVX.Modify();
                        end;


                    If AllocationCodeVar <> '' then
                        If Rec."Shortcut Dimension 2 Code" = '' then begin
                            AllocationCode.Get(AllocationCodeVar);
                            Rec.Validate("Shortcut Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                            If Rec."Line No." > 0 then
                                Rec.Modify();
                        end else begin
                            AllocationCode.Get(AllocationCodeVar);
                            IF Rec."Shortcut Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                                Error(WrongDimErr);
                        end;
                end;
            }
        }
    }
    
    var
        SalesLineNVX: Record SalesLineNVX;
        AllocationCodeVar: Code[20];

    trigger OnAfterGetRecord()
    begin
        IF not SalesLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX.Insert();
            Clear(AllocationCodeVar);
        end else
            AllocationCodeVar := SalesLineNVX."Allocation Code";
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Clear(AllocationCodeVar);
    end;

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean;
    var
        BelowLineNo: Integer;
        AboveLineNo: Integer;
    begin
        If AllocationCodeVar <> '' then begin
            SalesLineNVX.Init();
            SalesLineNVX."Document Type" := Rec."Document Type";
            SalesLineNVX."Document No." := Rec."Document No.";
            SalesLineNVX."Line No." := Rec."Line No.";
            SalesLineNVX."Allocation Code" := AllocationCodeVar;
            SalesLineNVX.Insert();
        end;
        exit(true);
    end;
}