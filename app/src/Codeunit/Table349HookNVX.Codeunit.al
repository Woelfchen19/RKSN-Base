codeunit 50014 Table349HookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecInAccompaniedTable(Rec: Record "Dimension Value")
    var
        DimValueNVX: Record DimValueNVX;
    begin
        if Rec.IsTemporary then
            exit;
        if DimValueNVX.Get(Rec."Dimension Code", Rec.Code) then
            DimValueNVX.Delete(true);
    end;
}