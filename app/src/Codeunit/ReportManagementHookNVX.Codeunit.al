codeunit 50003 ReportManagementHookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::ReportManagement, 'OnAfterSubstituteReport', '', false, false)]
    local procedure SubstituteItemCopyReport(ReportId: Integer; var NewReportId: Integer)
    begin
        if ReportId = Report::"Copy Item" then
            NewReportId := Report::ItemCopyNVX;
    end;
}