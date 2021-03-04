page 50000 VATPostingTypeNVX
{
    
    ApplicationArea = All;
    Caption = 'VAT Posting Types', comment = 'DEA="USt.-Buchungsarten"';
    PageType = List;
    SourceTable = VATPostingTypeNVX;
    UsageCategory = Administration;
    
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field(Code; Code)
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
