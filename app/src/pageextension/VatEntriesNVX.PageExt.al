pageextension 50052 VatEntriesNVX extends "VAT Entries"
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
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
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
    trigger OnOpenPage()
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();

        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"VAT Entries", DimVisible, DimEditable);
        AppMgt.GetFieldsPropertyVisibleEditableBySetup(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10);

        Rec.FilterGroup(2);
        Rec.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
        Rec.FilterGroup(0);

    end;

    var
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
        DimEditable: array[10] of Boolean;
        DimEditable1: Boolean;
        DimEditable2: Boolean;
        DimEditable3: Boolean;
        DimEditable4: Boolean;
        DimEditable5: Boolean;
        DimEditable6: Boolean;
        DimEditable7: Boolean;
        DimEditable8: Boolean;
        DimEditable9: Boolean;
        DimEditable10: Boolean;
        DimVisible: array[10] of Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        DimVisible9: Boolean;
        DimVisible10: Boolean;
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
}