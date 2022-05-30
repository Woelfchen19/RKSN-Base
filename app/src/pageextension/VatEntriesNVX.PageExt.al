pageextension 50052 "VatEntriesNVX" extends "VAT Entries"
{
    layout
    {
        addlast(Control1)
        {
            field(GlobalDimension2CodeNVX; Rec.GlobalDimension2CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
            }
            field(GlobalDimension5CodeNVX; Rec.GlobalDimension5CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Global Dimension 2 Code field.';
            }
        }
    }
    actions
    {
        addafter("&Navigate")
        {
            action(DimensionsNVX)
            {
                AccessByPermission = TableData Dimension = R;
                ApplicationArea = Dimensions;
                Caption = 'Dimensions';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Process;
                Scope = Repeater;
                ShortCutKey = 'Alt+D';
                ToolTip = 'View or edit dimensions, such as area, project, or department, that you can assign to sales and purchase documents to distribute costs and analyze transaction history.';

                trigger OnAction()
                begin
                    ShowDimensionsNVX();
                end;
            }
        }
    }
}