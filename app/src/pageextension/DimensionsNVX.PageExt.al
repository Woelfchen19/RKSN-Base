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
                    DimensionValue: Record "Dimension Value";
                    UserSetup: Record "User Setup";
                    AppMgt: Codeunit AppMgtNVX;
                begin
                    GLSetup.GetRecordOnce();
                    AppMgt.AllowdBusinessFieldsForUser();
                    AppMgt.GetUserSetup(UserSetup, true);
                    DimensionValue.FilterGroup(2);
                    DimensionValue.SetRange("Dimension Code", GLSetup.ShortcutDimension9CodeNVX);
                    DimensionValue.SetFilter(ShortcutDimension5CodeNVX, AppMgt.GetBusinessFieldFilterNVX());
                    DimensionValue.FilterGroup(0);
                    Page.Run(Page::"Dimension Values", DimensionValue);
                end;
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        GLSetup.GetRecordOnce();
        SetupReminderExtension.GetRecordOnce();

        StandardPageDimensionValuesVisible := Rec.Code <> GlSetup.ShortcutDimension9CodeNVX;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SetupReminderExtension: Record SetupReminderExtensionNVX;
        StandardPageDimensionValuesVisible: Boolean;
}