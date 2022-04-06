codeunit 50008 AllocationMgtNVX
{
    procedure LookupGenBusinessPostingGroup(FilterOption: Enum FilterOptionNVX): Code[20]
    var
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        GenBsnPstGrpNVX: Record GenBsnPstGrpNVX;
        PageGenBusinessPostingGroups: Page "Gen. Business Posting Groups";
    begin
        repeat
            if not GenBsnPstGrpNVX.Get(GenBusinessPostingGroup.Code) then
                GenBsnPstGrpNVX.Init();

            case FilterOption of
                FilterOption::Customer:
                    if GenBsnPstGrpNVX."Filter Customer" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::SalesQuote:
                    if GenBsnPstGrpNVX."Filter Sales Quote" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::SalesOrder:
                    if GenBsnPstGrpNVX."Filter Sales Order" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::SalesInvoice:
                    if GenBsnPstGrpNVX."Filter Sales Invoice" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::SalesCrMemo:
                    if GenBsnPstGrpNVX."Filter Sales Cr. Memo" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::Vendor:
                    if GenBsnPstGrpNVX."Filter Vendor" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::PurchaseQuote:
                    if GenBsnPstGrpNVX."Filter Purchase Quote" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::PurchaseOrder:
                    if GenBsnPstGrpNVX."Filter Purchase Order" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::PurchaseInvoice:
                    if GenBsnPstGrpNVX."Filter Purchase Invoice" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::PurchaseCrMemo:
                    if GenBsnPstGrpNVX."Filter Purchase Cr. Memo" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::GLAccount:
                    if GenBsnPstGrpNVX."Filter G/L Account" then
                        GenBusinessPostingGroup.Mark(true);
                FilterOption::ItemJournal:
                    if GenBsnPstGrpNVX."Filter Item Journal" then
                        GenBusinessPostingGroup.Mark(true);
            end; //of case

        until GenBusinessPostingGroup.Next() = 0;

        GenBusinessPostingGroup.MarkedOnly(true);
        PageGenBusinessPostingGroups.SetRecord(GenBusinessPostingGroup);
        PageGenBusinessPostingGroups.SetTableView(GenBusinessPostingGroup);
        PageGenBusinessPostingGroups.LookupMode(true);
        if PageGenBusinessPostingGroups.RunModal() = "Action"::LookupOK then begin
            PageGenBusinessPostingGroups.GetRecord(GenBusinessPostingGroup);
            exit(GenBusinessPostingGroup.Code);
        end;
    end;
}