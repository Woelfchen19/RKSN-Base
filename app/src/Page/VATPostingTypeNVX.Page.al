page 50028 "VATPostingTypeNVX"
{

    ApplicationArea = All;
    Caption = 'VAT Posting Types', comment = 'DEA="USt.-Buchungsarten"';
    PageType = List;
    SourceTable = VATPostingTypeNVX;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("Code"; Code)
                {
                    ApplicationArea = All;
                }
                field(Description; Description)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
