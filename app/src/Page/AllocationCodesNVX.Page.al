page 50001 AllocationCodesNVX
{
    PageType = List;
    SourceTable = AllocationCodeNVX;
    Caption = 'Allocation Codes', comment = 'DEA="Verteilungscodes"';
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code"; Rec."Shortcut Dimension 1 Code")
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
        area(Processing)
        {
            action(Allocations)
            {
                ApplicationArea = All;
                Caption = 'Allocations', comment = 'DEA="Verteilungen"';
                RunObject = page AllocationListNVX;
                RunPageLink = "Allocation Code" = field(Code);
                Image = Allocate;
            }
            action(ResponsibilityCenter)
            {
                ApplicationArea = All;
                Caption = 'Allocation Code / Responsibility Center', comment = 'DEA="Zuordnung Zuständigkeitseinheiten"';
                RunObject = page AllocCodeRespCenterNVX;
                RunPageLink = "Allocation Code" = field(Code);
                Image = Relationship;
            }
        }
    }
}