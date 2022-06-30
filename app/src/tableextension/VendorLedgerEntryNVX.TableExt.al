tableextension 50016 "VendorLedgerEntryNVX" extends "Vendor Ledger Entry"
{
    fields
    {
        field(50009; AssociatedNVX; Code[10])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            TableRelation = SetupAssociatedNVX;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".AssociatedNVX where("Global Dimension No." = const(2), Code = field("Global Dimension 2 Code")));
        }
    }
    procedure SetAssociatedNVX()
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        if ("Global Dimension 2 Code" = '') or (Rec.AssociatedNVX <> '') then
            exit;

        GLSetup.GetRecordOnce();
        DimensionValue.Get(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        Rec.AssociatedNVX := Dimensionvalue.AssociatedNVX;
    end;

    procedure SetAssociatedNVX(Upgrade: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        VendLedgerEntry: Record "Vendor Ledger Entry";
    begin
        if not Upgrade then
            exit;

        GLSetup.Get();

        if VendLedgerEntry.FindSet() then
            repeat
                    if ("Global Dimension 2 Code" <> '') and (Rec.AssociatedNVX = '') then begin
                        DimensionValue.Get(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                        VendLedgerEntry.AssociatedNVX := Dimensionvalue.AssociatedNVX;
                        VendLedgerEntry.Modify();
                    end;
            until VendLedgerEntry.Next() = 0;
    end;

    procedure GetShortcutDimensionsNVX(DimSetID: Integer; VAR ShortcutDimCode: ARRAY[10] OF Code[20])
    begin
        DimensionManagement.GetShortcutDimensions(DimSetID, ShortcutDimCode);
    end;

    var
        DimensionManagement: Codeunit DimensionManagement;
}