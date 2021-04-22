pageextension 50033 "FACardNVX" extends "Fixed Asset Card"
{
    layout
    {
        addlast(General)
        {
            field("Global Dimension 1 CodeNVX"; Rec."Global Dimension 1 Code")
            {
                ApplicationArea = All;
            }
            field("Global Dimension 2 CodeNVX"; Rec."Global Dimension 2 Code")
            {
                ApplicationArea = All;
            }            
            field("Allocation CodeNVX"; FixedAssetNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                Editable = PageEditable;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    // FixedAsset: Record "Fixed Asset";
                    AllocationCode: Record AllocationCodeNVX;
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup!', 
                        comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Stammdaten der Anlagenkarte! Überprüfen Sie bitte das Setup."';
                    OverwriteDim2Qst: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Do you want to overwrite the Profitcenter?', 
                        comment = 'DEA=Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Stammdaten der Anlagenkarte! Wollen Sie das Profitcenter mit dem Wert aus dem Verteilungscode überschreiben?"';                    
                begin
                    if FixedAssetNVX."Allocation Code" = '' then begin
                        FixedAssetNVX.Modify();
                        exit;
                    end;

                    AllocationCode.Get(FixedAssetNVX."Allocation Code");

                    IF Rec."Global Dimension 2 Code" = '' then begin
                        Rec."Global Dimension 2 Code" := AllocationCode."Shortcut Dimension 2 Code";
                        Rec.Modify();
                    end else 
                        if Rec."Global Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                            If not Confirm(OverwriteDim2Qst) then
                                error(WrongDimErr)
                            else begin
                                Rec.Validate("Global Dimension 2 Code",AllocationCode."Shortcut Dimension 2 Code");
                                Rec.Modify(true);
                            end;

                    FixedAssetNVX.Modify();
                end;
            }
        }
    }

    var
        FixedAssetNVX : Record FixedAssetNVX;
        PageEditable: Boolean;

    trigger OnAfterGetRecord();
    begin
        IF not FixedAssetNVX.Get(Rec."No.") then begin
            FixedAssetNVX.Init();
            FixedAssetNVX."No." := Rec."No.";
            FixedAssetNVX.Insert();
        end;
        PageEditable := CurrPage.Editable;
    end;

    trigger OnOpenPage();
    begin
        PageEditable := CurrPage.Editable;
    end;

    trigger OnDeleteRecord() : Boolean;
    begin
        Rec.Delete(true);
        Rec.Init();
        CurrPage.Close();
    end;

    trigger OnQueryClosePage(CloseAction : Action) : Boolean;
    begin

        IF Rec."No." = '' then 
            exit(true);

        IF FixedAssetNVX."Allocation Code" = '' then
            Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");

        exit(true);
    end;
}