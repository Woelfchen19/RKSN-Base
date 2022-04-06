page 50000 AllocationCardNVX
{
    PageType = Card;
    SourceTable = AllocationHeaderNVX;
    Caption = 'Allocation Card', comment = 'DEA="Verteilungskarte"';
    layout
    {
        area(Content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
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
            part(Lines; AllocationSubPageNVX)
            {
                ApplicationArea = All;
                SubPageLink = "Allocation Code" = field("Allocation Code"), "Start Date" = field("Start Date");
            }
        }
    }
}