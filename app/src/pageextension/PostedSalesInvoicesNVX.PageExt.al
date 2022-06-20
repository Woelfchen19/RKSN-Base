pageextension 50069 "PostedSalesInvoicesNVX" extends "Posted Sales Invoices"
{
    layout
    {
        addlast(Control1)
        {
            field(ShortcutDimCode5NVX; ShortcutDims[5])
            {
                ApplicationArea = Dimensions;
                Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
                CaptionClass = '1,2,5';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5),
                                                                   "Dimension Value Type" = CONST(Standard),
                                                                   Blocked = CONST(false));
                Visible = DimVisible5;
            }
        }
        addbefore(IncomingDocAttachFactBox)
        {
            part(DimensionSetEntriesFactBoxNVX; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
            }
        }
    }

    trigger OnOpenPage()
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(ObjectType::Page, Page::"Posted Sales Invoices", DimVisible, DimEditable);
        AppMgt.GetFieldsPropertyVisibleEditableBySetup(
            DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10);
    end;

    trigger OnAfterGetRecord();
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;

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

}