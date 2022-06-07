pageextension 50064 "ReminderListNVX" extends "Reminder List"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Editable = DimEditable1;
            Visible = DimVisible1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = DimEditable2;
            Visible = DimVisible2;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(Shortcutdimension5CodeNVX; ShortcutDims[5])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                Editable = DimEditable5;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
                Visible = DimVisible5;

                trigger OnValidate()
                begin
                    AppMgt.OnValidateShortcutDimension(Rec, ShortcutDims[5]);
                end;

                trigger OnLookup(var Text: Text): Boolean
                begin
                    AppMgt.OnLookupShortcutDimension5Code(ShortcutDims[5]);
                    AppMgt.OnAfterLookupshortcutDimension5Code(Rec, xRec, ShortcutDims[5]);
                end;
            }
            field(Shortcutdimension7CodeNVX; ShortcutDims[7])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,7';
                Editable = DimEditable7;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
                Visible = DimVisible7;

                trigger OnValidate()
                begin
                    DimMgt.ValidateShortcutDimValues(7, ShortcutDims[7], Rec."Dimension Set ID");
                end;
            }
        }
    }
    var
        AppMgt: Codeunit AppMgtNVX;
        DimMgt: Codeunit DimensionManagement;
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
        ShortcutDims: array[10] of Code[20];
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;

    trigger OnOpenPage()
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"Reminder List", DimVisible, DimEditable);
        AppMgt.GetFieldsPropertyVisibleEditableBySetup(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10);
    end;

    trigger OnAfterGetRecord();
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;
}