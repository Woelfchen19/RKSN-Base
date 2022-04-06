pageextension 50028 FACardNVX extends "Fixed Asset Card"
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
            field("Shortcut Dimension 3 CodeNVX"; ShortcutDimCode3)
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                CaptionClass = '1,2,3';
                trigger OnValidate();
                var
                    DimMgt: Codeunit DimensionManagement;
                begin
                    DimMgt.ValidateDimValueCode(3, ShortcutDimCode3);
                    DimMgt.SaveDefaultDim(Database::"Fixed Asset", Rec."No.", 3, ShortcutDimCode3);
                end;
            }
            field("Allocation CodeNVX"; FixedAssetNVX."Allocation Code")
            {
                ApplicationArea = All;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                Editable = PageEditable;
                TableRelation = AllocationCodeNVX.Code;
                trigger OnValidate();
                var
                    AllocationCode: Record AllocationCodeNVX;
                    OverwriteDim2Qst: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Do you want to overwrite the Profitcenter?',
                        comment = 'DEA=Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Stammdaten der Anlagenkarte! Wollen Sie das Profitcenter mit dem Wert aus dem Verteilungscode überschreiben?"';
                    WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup!',
                        comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Stammdaten der Anlagenkarte! Überprüfen Sie bitte das Setup."';
                begin
                    if FixedAssetNVX."Allocation Code" = '' then begin
                        FixedAssetNVX.Modify();
                        exit;
                    end;

                    AllocationCode.Get(FixedAssetNVX."Allocation Code");

                    if Rec."Global Dimension 2 Code" = '' then begin
                        Rec."Global Dimension 2 Code" := AllocationCode."Shortcut Dimension 2 Code";
                        Rec.Modify();
                    end else
                        if Rec."Global Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                            if not Confirm(OverwriteDim2Qst) then
                                Error(WrongDimErr)
                            else begin
                                Rec.Validate("Global Dimension 2 Code", AllocationCode."Shortcut Dimension 2 Code");
                                Rec.Modify(true);
                            end;

                    FixedAssetNVX.Modify();
                end;
            }
        }
    }

    var
        FixedAssetNVX: Record FixedAssetNVX;
        PageEditable: Boolean;
        ShortcutDimCode3: Code[20];

    trigger OnAfterGetRecord();
    var
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        FixedAssetNVX.GetDefinition(Rec."No.");
        PageEditable := CurrPage.Editable;

        GLSetup.Get();
        DefaultDim.SetRange("Table ID", Database::"Fixed Asset");
        DefaultDim.SetRange("No.", Rec."No.");
        DefaultDim.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
        if DefaultDim.FindFirst() then
            ShortcutDimCode3 := DefaultDim."Dimension Value Code"
        else
            Clear(ShortcutDimCode3);
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    begin
        if Rec."No." = '' then
            exit(true);

        if FixedAssetNVX."Allocation Code" = '' then
            Rec.TestField("Global Dimension 1 Code");
        Rec.TestField("Global Dimension 2 Code");

        exit(true);
    end;
}