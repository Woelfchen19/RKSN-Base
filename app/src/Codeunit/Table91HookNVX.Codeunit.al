codeunit 50003 "Table91HookNVX"
{
[EventSubscriber(ObjectType::Table, Database::"User Setup", 'OnAfterInsertEvent', '', false, false)]
local procedure InsertRecordInAccompaniedTable(var Rec: Record "User Setup")
var
    UserSetupNVX: Record UserSetupNVX;
begin
    IF not UserSetupNVX.Get(Rec."User ID") then begin
        UserSetupNVX.Init();
        UserSetupNVX."User ID" := Rec."User ID";
        UserSetupNVX.Insert();
    end;
end;

[EventSubscriber(ObjectType::Table, Database::"User Setup", 'OnBeforeDeleteEvent', '', false, false)]
local procedure DeleteRecordInAccompaniedTable(var Rec: Record "User Setup")
var
    UserSetupNVX: Record UserSetupNVX;
begin
    If UserSetupNVX.Get(Rec."User ID") then
        UserSetupNVX.Delete();
end;
}