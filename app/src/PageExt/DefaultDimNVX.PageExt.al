pageextension 50039 DefaultDimNVX extends "Default Dimensions"
{
    layout
    {
        // Add changes to page layout here
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        Item: Record Item;
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
        InvSetupNVX: Record InvSetupNVX;
        Dim1Present: Boolean;
        Dim3Present: Boolean;
        InvValueZeroErr: Label 'This item has no inventory value. Cost Center and Section are obligatory. Values set up in the inventory setup are not allowed for items without inventory value.',
                                comment = 'DEA="Der Artikel ist nicht lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte ist pflichtig. Darüber hinaus dürfen die Dimensionswerte aus der Lager-Einrichtung für nicht lagerbewertete Artikel nicht zugeordnet werden!"';
        InvValueErr: Label 'This item has inventory value. Cost Center and Section are obligatory. Only values set up in the inventory setup are allowed for items with inventory value., ',
                                comment = 'DEA="Der Artikel ist lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte muss der Lager-Einrichtung entsprechen"';
    begin
        GLSetup.Get();
        InvSetupNVX.Get();
        Item.Get(Rec."No.");

        DefaultDim.SetRange("Table ID", Rec."Table ID");
        DefaultDim.SetRange("No.", Rec."No.");


        If DefaultDim.FindSet(false, false) then
            repeat

                case DefaultDim."Dimension Code" of

                    GLSetup."Global Dimension 1 Code" :
            begin

                Dim1Present := true;

                case Item."Inventory Value Zero" of
                    true :
                        IF DefaultDim."Dimension Value Code" = InvSetupNVX."Inventory Cost Center" then
                    Error(InvValueZeroErr);
false :
                        IF DefaultDim."Dimension Value Code" <> InvSetupNVX."Inventory Cost Center" then
                    Error(InvValueErr);
                end; //of case
            end;

            GLSetup."Shortcut Dimension 3 Code" :
            begin

                Dim3Present := true;

                case Item."Inventory Value Zero" of
                    true :
                        IF DefaultDim."Dimension Value Code" = InvSetupNVX."Inventory Section" then
                    Error(InvValueZeroErr);
false :
                        IF DefaultDim."Dimension Value Code" <> InvSetupNVX."Inventory Section" then
                    Error(InvValueErr);
                end; // of case
            end;

            end; //of case


            until DefaultDim.Next = 0;

        IF(not Dim1Present) OR(not Dim3Present) then
            case Item."Inventory Value Zero" of
            true :
                Error(InvValueZeroErr);
            false :
                Error(InvValueErr);
            end; // of case



        exit(true);
    end;
}