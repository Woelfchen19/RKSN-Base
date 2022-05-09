codeunit 50011 "Table251HookNVX"
{
    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(var Rec: Record "Gen. Product Posting Group")
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
    begin
        if GenPrdPstGrp.Get(Rec."Code") then
            GenPrdPstGrp.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(var Rec: Record "Gen. Product Posting Group"; var xRec: Record "Gen. Product Posting Group")
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
    begin
        if not GenPrdPstGrp.Get(xRec."Code") then
            exit;

        GenPrdPstGrp.Code := Rec.Code;
        GenPrdPstGrp.Modify();
    end;
}