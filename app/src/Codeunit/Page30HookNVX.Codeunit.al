codeunit 50020 "Page30HookNVX"
{
    // [EventSubscriber(ObjectType::Page, Page::"Item Card", 'OnBeforeCopyItem', '', false, false)]
    // local procedure SubstitueItemCopyReport(var Item: Record Item; var IsHandled: Boolean)
    // var
    //     NewItem: Record Item;
    //     ItemCopyNVX: Report ItemCopyNVX;
    //     Text11500: Label 'Do you want to edit the new item?', comment = 'DEA="Möchten Sie den neuen Artikel bearbeiten?"';
    // begin
    //     ItemCopyNVX.ItemDef(Item);
    //     ItemCopyNVX.RUNMODAL;
    //     IF ItemCopyNVX.ItemReturn(NewItem) THEN
    //         IF CONFIRM(Text11500,TRUE) THEN BEGIN
    //             PAGE.RUNMODAL(PAGE::"Item Card",NewItem);
    //         END;
    //     IsHandled := true;
    // end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure SubstituteItemCopyReport(ReportId: Integer; var NewReportId: Integer)
    begin
        IF ReportId = 11511 then
            NewReportId := 50000;
    end;
}