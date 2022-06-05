codeunit 50033 "DimensionSetEntryHookNVX"
{

    [EventSubscriber(ObjectType::Table, Database::"Dimension Set Entry", 'OnBeforeValidateEvent', 'Dimension Value Code', true, true)]
    local procedure OnBeforeValidateEvent(var Rec: Record "Dimension Set Entry"; var xRec: Record "Dimension Set Entry"; CurrFieldNo: Integer)
    var
        DimensionValue: Record "Dimension Value";
        AppMgt: codeunit AppMgtNVX;
    begin
        DimensionValue.Get(Rec."Dimension Code", Rec."Dimension Value Code");
        AppMgt.OnValidateShortcutDimension(DimensionValue);
    end;
}