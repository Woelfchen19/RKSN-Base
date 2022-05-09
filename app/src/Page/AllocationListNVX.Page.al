page 50002 "AllocationListNVX"
{
    Caption = 'Allocations', comment = 'DEA="Verteilungen"';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = AllocationHeaderNVX;
    CardPageId = AllocationCardNVX;
    InsertAllowed = false;
    Editable = false;
    SourceTableView = sorting("Allocation Code", "Start Date");

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Allocation Code"; "Allocation Code")
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
        {

        }
    }
}