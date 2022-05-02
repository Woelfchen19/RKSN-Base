pageextension 50055 "PostedSalesShipmentsNVX" extends "Posted Sales Shipments"
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
            field(ShortcutDimCode3NVX; ShortcutDimCode[3])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,3';
                Editable = DimEditable3;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.';
                Visible = DimVisible4;
            }
            field(ShortcutDimCode4NVX; ShortcutDimCode[4])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,4';
                Editable = DimEditable4;
                ToolTip = 'Specifies the value of the Shortcut Dimension 4 Code field.';
                Visible = DimVisible5;
            }
            field(ShortcutDimCode5NVX; ShortcutDimCode[5])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                Editable = DimEditable5;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimVisible5;
            }
            field(ShortcutDimCode6NVX; ShortcutDimCode[6])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,6';
                Editable = DimEditable6;
                ToolTip = 'Specifies the value of the Shortcut Dimension 6 Code field.';
                Visible = DimVisible6;
            }
            field(ShortcutDimCode7NVX; ShortcutDimCode[7])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,7';
                Editable = DimEditable7;
                ToolTip = 'Specifies the value of the Shortcut Dimension 7 Code field.';
                Visible = DimVisible7;
            }
            field(ShortcutDimCode8NVX; ShortcutDimCode[8])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,8';
                Editable = DimEditable8;
                ToolTip = 'Specifies the value of the Shortcut Dimension 8 Code field.';
                Visible = DimVisible8;
            }
            field(ShortcutDimCode9NVX; ShortcutDimCode[9])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,9';
                Editable = DimEditable9;
                ToolTip = 'Specifies the value of the Shortcut Dimension 9 Code field.';
                Visible = DimVisible9;
            }
            field(ShortcutDimCode10NVX; ShortcutDimCode[10])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,10';
                Editable = DimEditable10;
                ToolTip = 'Specifies the value of the Shortcut Dimension 10 Code field.';
                Visible = DimVisible10;
            }
        }
    }

    var
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
        ShortcutDimCode: array[10] of Code[20];

    trigger OnOpenPage()
    begin
        SetDimensionsVisibility();
    end;

    trigger OnAfterGetRecord()
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;

    local procedure SetDimensionsVisibility()
    var
        GLSetup: Record "General Ledger Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        PageID: Integer;
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
    begin
        GLSetup.Get();
        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);

        PageID := Page::"Posted Sales Shipments";

        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 1 Code");
        DimVisible1 := DimVisible1 and SetupPropertyForFields.IsVisible;
        DimEditable1 := DimEditable1 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 2 Code");
        DimVisible2 := DimVisible2 and SetupPropertyForFields.IsVisible;
        DimEditable2 := DimEditable2 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 3 Code");
        DimVisible3 := DimVisible3 and SetupPropertyForFields.IsVisible;
        DimEditable3 := DimEditable3 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 4 Code");
        DimVisible4 := DimVisible4 and SetupPropertyForFields.IsVisible;
        DimEditable4 := DimEditable4 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 5 Code");
        DimVisible5 := DimVisible5 and SetupPropertyForFields.IsVisible;
        DimEditable5 := DimEditable5 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 6 Code");
        DimVisible6 := DimVisible6 and SetupPropertyForFields.IsVisible;
        DimEditable6 := DimEditable6 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 7 Code");
        DimVisible7 := DimVisible7 and SetupPropertyForFields.IsVisible;
        DimEditable7 := DimEditable7 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 8 Code");
        DimVisible8 := DimVisible8 and SetupPropertyForFields.IsVisible;
        DimEditable8 := DimEditable8 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension9CodeNVX);
        DimVisible9 := DimVisible9 and SetupPropertyForFields.IsVisible;
        DimEditable9 := DimEditable9 and SetupPropertyForFields.IsEditable;
        SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension10CodeNVX);
        DimVisible10 := DimVisible10 and SetupPropertyForFields.IsVisible;
        DimEditable10 := DimEditable10 and SetupPropertyForFields.IsEditable;

        Clear(DimMgt);
    end;

}