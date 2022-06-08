pageextension 50040 "GLEntryNVX" extends "General Ledger Entries"
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
            field(ShortcutDimCode3NVX; Rec.ShortcutDimension3CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                Visible = DimVisible3;
            }
            field(ShortcutDimCode4NVX; Rec.ShortcutDimension4CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                Visible = DimVisible4;
            }
            field(ShortcutDimCode5NVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimVisible5;
            }
            field(ShortcutDimCode6NVX; Rec.ShortcutDimension6CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                Visible = DimVisible6;
            }
            field(ShortcutDimCode7NVX; Rec.ShortcutDimension7CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
                Visible = DimVisible7;
            }
            field(ShortcutDimCode8NVX; Rec.ShortcutDimension8CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
                Visible = DimVisible8;
            }
            field(ShortcutDimCode9NVX; Rec.ShortcutDimension9CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                Visible = DimVisible9;
            }
            field(ShortcutDimCode10NVX; Rec.ShortcutDimension10CodeNVX)
            {
                ApplicationArea = All;
                Editable = false;
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
                Visible = DimVisible10;
            }
        }
    }

    trigger OnOpenPage()
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();

        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"General Ledger Entries", DimVisible, DimEditable);
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