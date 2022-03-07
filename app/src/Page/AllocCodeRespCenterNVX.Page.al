page 50005 AllocCodeRespCenterNVX
{
    Caption = 'Allocation Codes/ Resp. Center', comment = 'DEA="Verteilungscodes/ Zuständigkeitseinh."';
    PageType = List;
    UsageCategory = Lists;
    ApplicationArea = All;
    SourceTable = AllocCodeRespCenterNVX;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Allocation Code"; Rec."Allocation Code")
                {
                    ApplicationArea = All;
                }
                field("Allocation Code Description"; Rec."Allocation Code Description")
                {
                    ApplicationArea = All;
                }
                field("Resp. Center"; Rec."Resp. Center")
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
            action(InsertRespCenter)
            {
                Caption = 'Insert Responsibility Center', comment = 'DEA="Zuständigkeitseinheiten einfügen"';
                ApplicationArea = All;
                Image = Insert;
                trigger OnAction();
                begin
                    InsertResponsibilityCenter();
                end;
            }
        }
    }
}