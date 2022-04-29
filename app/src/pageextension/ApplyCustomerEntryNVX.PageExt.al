pageextension 50053 ApplyCustomerEntryNVX extends "Apply Customer Entries"
{
    layout
    {
        modify("Global Dimension 1 Code")
        {
            Editable = false;
            Visible = DimVisible1;
        }

        modify("Global Dimension 2 Code")
        {
            Editable = false;
            Visible = DimVisible2;
        }

        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; Rec.ShortcutDimension3CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                Visible = DimVisible3;
            }
            field(ShortcutDimension4CodeNVX; Rec.ShortcutDimension4CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                Visible = DimVisible4;
            }
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimVisible5;
            }
            field(ShortcutDimension6CodeNVX; Rec.ShortcutDimension6CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                Visible = DimVisible6;
            }
            field(ShortcutDimension7CodeNVX; Rec.ShortcutDimension7CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
                Visible = DimVisible7;
            }
            field(ShortcutDimension8CodeNVX; Rec.ShortcutDimension8CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
                Visible = DimVisible8;
            }
            field(ShortcutDimension9CodeNVX; Rec.ShortcutDimension9CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                Visible = DimVisible9;
            }
            field(ShortcutDimension10CodeNVX; Rec.ShortcutDimension10CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
                Visible = DimVisible10;
            }
        }
    }
    var
        /*
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
        */
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

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    local procedure SetDimensionsVisibility()
    var
        DimensionManagement: Codeunit DimensionManagement;
    begin
        DimVisible1 := false;
        DimVisible2 := false;
        DimVisible3 := false;
        DimVisible4 := false;
        DimVisible5 := false;
        DimVisible6 := false;
        DimVisible7 := false;
        DimVisible8 := false;
        DimVisible9 := false;
        DimVisible10 := false;

        DimensionManagement.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);

        DimVisible1 := false;
        DimVisible3 := false;
        DimVisible7 := false;
        DimVisible8 := false;
        DimVisible10 := false;

        /*
        DimEditable1 := false;
        DimEditable2 := false;
        DimEditable3 := false;
        DimEditable4 := false;
        DimEditable5 := false;
        DimEditable6 := false;
        DimEditable7 := false;
        DimEditable8 := false;
        DimEditable9 := false;
        DimEditable10 := false;
        */

        Clear(DimensionManagement);
    end;
}