page 50004 AllocationCardNVX
{
    PageType = Card;
    SourceTable = AllocationHeaderNVX;
    // UsageCategory = Administration;
    Caption = 'Allocation Card', comment = 'DEA="Verteilungskarte"';
    AutoSplitKey = true;
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
                SubPageLink = "Allocation ID" = field("Allocation ID");
            }
        }
    }

    // actions
    // {
    //     area(processing)
    //     {
    //         action(ActionName)
    //         {
    //             trigger OnAction();
    //             begin
    //             end;
    //         }
    //     }
    // }
    
    var
        myInt : Integer;
}