codeunit 50015 Table5600HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Fixed Asset", 'OnAfterValidateEvent', 'Global Dimension 2 Code', false, false)]
    local procedure CheckAllocationCodeDimension(var Rec: Record "Fixed Asset"; var xRec: Record "Fixed Asset")
    var
        AllocationCode: Record AllocationCodeNVX;
        FixedAssetNVX: Record FixedAssetNVX;
        WrongDimErr: Label 'The Profitcenter differs from the assigned Allocation Code Profitcenter! Please check the setup!',
            comment = 'DEA="Der Dimensionswert Profitcenter aus dem Setup des zugerodneten Verteilungscodes ist nicht identisch zum zugeordneten Profitcenter in den Stammdaten der Anlagenkarte! Überprüfen Sie bitte das Setup."';
    begin
        if (Rec."Global Dimension 2 Code" = xRec."Global Dimension 2 Code") then
            exit;

        if FixedAssetNVX.Get(Rec."No.") and (FixedAssetNVX."Allocation Code" <> '') then begin
            AllocationCode.Get(FixedAssetNVX."Allocation Code");
            if Rec."Global Dimension 2 Code" <> AllocationCode."Shortcut Dimension 2 Code" then
                Error(WrongDimErr);
        end;
    end;
}