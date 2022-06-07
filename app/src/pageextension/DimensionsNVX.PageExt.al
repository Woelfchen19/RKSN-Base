pageextension 50004 "DimensionsNVX" extends Dimensions
{
    actions
    {
        modify("Dimension &Values")
        {
            Visible = StandardPageDimensionValuesVisible;
        }

        addafter("Dimension &Values")
        {
            action(DimensionValuesNVX)
            {
                ApplicationArea = Dimensions;
                Caption = 'Dimension &Values', comment = 'DEA="Dimensionswerte"';
                Image = Dimensions;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedOnly = true;
                ToolTip = 'View or edit the dimension values for the current dimension.';
                Visible = not StandardPageDimensionValuesVisible;

                trigger OnAction()
                var
                    AppMgt: Codeunit AppMgtNVX;
                begin
                    AppMgt.OnLookupShortcutDimension5Code(Rec.Code);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    var
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.GetRecordOnce();
        StandardPageDimensionValuesVisible := Rec.Code <> GlSetup."Shortcut Dimension 5 Code";
    end;

    var
        StandardPageDimensionValuesVisible: Boolean;
}