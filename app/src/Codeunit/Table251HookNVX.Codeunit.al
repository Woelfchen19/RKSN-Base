codeunit 50004 "Table251HookNVX"
{
    // [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterInsertEvent', '', false, false)]
    // local procedure InsertRecordInAccompaniedTable(var Rec: Record "Gen. Product Posting Group")
    // var
    //     GenPrdPstGrp: Record GenPrdPstGrpNVX;
    // begin
    //     IF not GenPrdPstGrp.Get(Rec."Code") then begin
    //         GenPrdPstGrp.Init();
    //         GenPrdPstGrp."Code" := Rec."Code";
    //         GenPrdPstGrp.Insert();
    //     end;
    // end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnBeforeDeleteEvent', '', false, false)]
    local procedure DeleteRecordInAccompaniedTable(var Rec: Record "Gen. Product Posting Group")
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
    begin
        If GenPrdPstGrp.Get(Rec."Code") then
            GenPrdPstGrp.Delete();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Gen. Product Posting Group", 'OnAfterRenameEvent', '', false, false)]
    local procedure RenameRecordInAccompaniedTable(var Rec: Record "Gen. Product Posting Group"; var xRec: Record "Gen. Product Posting Group")
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
    begin
        If not GenPrdPstGrp.Get(xRec."Code") then
            exit;
        
        GenPrdPstGrp.Code := Rec.Code;
        GenPrdPstGrp.Modify();
    end;
}