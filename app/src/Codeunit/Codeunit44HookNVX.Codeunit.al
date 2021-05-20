codeunit 50020 Codeunit44HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure SubstituteItemCopyReport(ReportId: Integer; var NewReportId: Integer)
    begin
        IF ReportId = 11511 then
            NewReportId := 50000;
    end;
}