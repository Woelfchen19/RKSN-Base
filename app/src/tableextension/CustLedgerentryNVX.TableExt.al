tableextension 50005 "CustLedgerentryNVX" extends "Cust. Ledger Entry"
{

    fields
    {
        field(50000; ShortcutDimension9CodeNVX; Code[20])
        {
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCodeNVX(9, ShortcutDimension9CodeNVX);
            end;
        }
        field(50001; "ShortcutDimension10CodeNVX"; Code[20])
        {
            CaptionClass = '1,2,10';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(10),
                                                          Blocked = CONST(false));

            trigger OnValidate()
            begin
                ValidateShortcutDimCodeNVX(10, ShortcutDimension10CodeNVX);
            end;
        }
    }
    procedure ValidateShortcutDimCodeNVX(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeValidateShortcutDimCodeNVX(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");

        OnAfterValidateShortcutDimCodeNVX(Rec, xRec, FieldNumber, ShortcutDimCode);
    end;

    procedure LookupShortcutDimCodeNVX(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeLookupShortcutDimCodeNVX(Rec, xRec, FieldNumber, ShortcutDimCode, IsHandled);
        if IsHandled then
            exit;

        DimMgt.LookupDimValueCode(FieldNumber, ShortcutDimCode);
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, "Dimension Set ID");
    end;

    procedure ShowShortcutDimCodeNVX(var ShortcutDimCode: array[8] of Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    procedure ShowDimensionsNVX()
    var
        IsHandled: Boolean;
    begin
        IsHandled := false;
        OnBeforeShowDimensionsNVX(Rec, xRec, IsHandled);
        if IsHandled then
            exit;

        "Dimension Set ID" :=
          DimMgt.EditDimensionSet(
              Rec."Dimension Set ID", Rec.FieldCaption(ShortcutDimension9CodeNVX) + ' ' + Rec.FieldCaption(ShortcutDimension10CodeNVX));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeValidateShortcutDimCodeNVX(var CustLedgerEntry: Record "Cust. Ledger Entry"; xCustLedgerEntry: Record "Cust. Ledger Entry"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeShowDimensionsNVX(var CustLedgerEntry: Record "Cust. Ledger Entry"; xCustLedgerEntry: Record "Cust. Ledger Entry"; var IsHandled: Boolean)
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCodeNVX(var CustLedgerEntry: Record "Cust. Ledger Entry"; xCustLedgerEntry: Record "Cust. Ledger Entry"; FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeLookupShortcutDimCodeNVX(var CustLedgerEntry: Record "Cust. Ledger Entry"; xCustLedgerEntry: Record "Cust. Ledger Entry"; FieldNumber: Integer; var ShortcutDimCode: Code[20]; var IsHandled: Boolean)
    begin
    end;

    var
        DimMgt: Codeunit DimensionManagement;
}