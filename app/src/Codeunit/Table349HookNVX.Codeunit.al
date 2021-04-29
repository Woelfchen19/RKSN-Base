codeunit 50010 Table349HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecInAccompaniedTable(Rec: Record "Dimension Value")
    var
        DimValueNVX: Record DimValueNVX;
    begin
        IF Rec.IsTemporary then
            exit;
        If DimValueNVX.Get(Rec."Dimension Code",Rec.Code) then
            DimValueNVX.Delete(true);
    end;
}