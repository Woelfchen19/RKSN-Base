codeunit 50001 "Table37HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnBeforeValidateEvent', 'Gen. Bus. Posting Group', false, false)]
    local procedure SetStatusCheckSuspended(var Rec: Record "Sales Line")
    begin
        Rec.SuspendStatusCheck(true);
    end;

    [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(Rec: Record "Sales Line")
    var
        SalesLineNVX: Record SalesLineNVX;
    begin
        If SalesLineNVX.Get(Rec."Document Type",Rec."Document No.",Rec."Line No.") then
            SalesLineNVX.Delete();
    end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'Type', false, false)]
    // local procedure ValidateQuantityOnAfterValidateType(Rec: Record "Sales Line")
    // begin
    //     If Rec.Type = Rec.Type::"G/L Account" then begin
    //         Rec.Validate(Quantity,1);
    //         IF Rec.Modify() then;
    //     end;
    // end;

    // [EventSubscriber(ObjectType::Table, Database::"Sales Line", 'OnAfterValidateEvent', 'No.', false, false)]
    // local procedure ValidateQuantityOnAfterValidateNo(Rec: Record "Sales Line")
    // begin
    //     If Rec.Type = Rec.Type::"G/L Account" then begin
    //         Rec.Validate(Quantity,1);
    //         If Rec.Modify() then;
    //     end;
    // end;
}