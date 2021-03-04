page 50003 AllocationCodesNVX
{
    PageType = List;
    SourceTable = AllocationCodeNVX;
    Caption = 'Allocation Codes', comment = 'DEA="Verteilungscodes"';
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(Code; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; Rec."Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Resp. Center")
                {
                    ApplicationArea = All;
                }
                
                
            }
        }
        
    }

    actions
    {
        area(processing)
        {
            action(Allocations)
            {
                Caption = 'Allocations', comment = 'DEA="Verteilungen"';
                RunObject = page AllocationListNVX;
                RunPageLink = "Allocation Code" = field(Code);
                Image = Allocate;
            }
            action(ResponsibilityCenter)
            {
                Caption = 'Allocation Code / Responsibility Center', comment = 'DEA="Zuordnung Zuständigkeitseinheiten"';
                RunObject = page AllocCodeRespCenterNVX;
                RunPageLink = "Allocation Code" = field(Code);
                Image = Relationship;
            }
        }
    }

}