page 50004 AllocationCardNVX
{
    PageType = Card;
    SourceTable = AllocationHeaderNVX;
    // UsageCategory = Administration;
    Caption = 'Allocation Card', comment = 'DEA="Verteilungskarte"';
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                field("Allocation Code"; "Allocation Code")
                {
                    ApplicationArea = All;
                }
                field("Description"; "Description")
                {
                    ApplicationArea = All;
                }                
                field("Start Date";"Start Date")
                {
                    ApplicationArea = All;
                }                
            }
            part(Lines;AllocationSubPageNVX)
            {
                SubPageLink = "Allocation Code"= field("Allocation Code"),"Start Date" = field("Start Date");
            }
        }
    }
}