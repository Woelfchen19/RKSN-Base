codeunit 50040 "DimensionFieldManagementNVX"
{
    var
        GLSetup: Record "General Ledger Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        AppMgt: Codeunit AppMgtNVX;
        DimMgt: codeunit DimensionManagement;
        DimensionEditable: array[10] of Boolean;
        DimensionVisible: array[10] of Boolean;
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

    procedure SetFieldsPropertyVisibleEditableBySetup(PageID: integer): Boolean
    begin
        SetFieldsPropertyVisibleEditableBySetup(8, PageID);
    end;

    procedure SetFieldsPropertyVisibleEditableBySetup(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System"; PageID: integer): Boolean
    var
        DimEditable: array[10] of Boolean;
        DimVisible: array[10] of Boolean;
    begin
        SetFieldsPropertyVisibleEditableBySetup(ObjectType, PageID, DimVisible, DimEditable);
    end;

    procedure SetFieldsPropertyVisibleEditableBySetup(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: integer;
        DimVisible: array[10] of Boolean;
        DimEditable: array[10] of Boolean): Boolean
    var
        i: integer;
    begin
        if not AppMgt.GetActivatedReminderExtensionSetup() then
            exit(false);

        GLSetup.GetRecordOnce();

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);

        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 1 Code") then begin
            Dimvisible[1] := DimVisible1 and SetupPropertyForFields.IsVisible;
            DimEditable[1] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 2 Code") then begin
            Dimvisible[2] := DimVisible2 and SetupPropertyForFields.IsVisible;
            DimEditable[2] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 3 Code") then begin
            Dimvisible[3] := DimVisible3 and SetupPropertyForFields.IsVisible;
            DimEditable[3] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 4 Code") then begin
            Dimvisible[4] := DimVisible4 and SetupPropertyForFields.IsVisible;
            DimEditable[4] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 5 Code") then begin
            Dimvisible[5] := DimVisible5 and SetupPropertyForFields.IsVisible;
            DimEditable[5] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 6 Code") then begin
            Dimvisible[6] := DimVisible6 and SetupPropertyForFields.IsVisible;
            DimEditable[6] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 7 Code") then begin
            Dimvisible[7] := DimVisible7 and SetupPropertyForFields.IsVisible;
            DimEditable[7] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 8 Code") then begin
            Dimvisible[8] := DimVisible8 and SetupPropertyForFields.IsVisible;
            DimEditable[8] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension9CodeNVX) then begin
            Dimvisible[9] := DimVisible9 and SetupPropertyForFields.IsVisible;
            DimEditable[9] := SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension10CodeNVX) then begin
            Dimvisible[10] := DimVisible10 and SetupPropertyForFields.IsVisible;
            DimEditable[10] := SetupPropertyForFields.IsEditable;
        end;

        for i := 1 to 10 do begin
            DimensionEditable[i] := DimEditable[i];
            DimensionVisible[i] := DimVisible[i];
        end;

        Clear(DimMgt);

        exit(true);
    end;

    procedure GetFieldsPropertyVisibleEditableBySetup(PageID: integer;
        var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean; var Dimension4Visible: Boolean; var Dimension5Visible: Boolean;
            var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean; var Dimension9Visible: Boolean; var Dimension10Visible: Boolean;
                var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean; var Dimension4Editable: Boolean; var Dimension5Editable: Boolean;
                    var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean): Boolean
    begin
        if not AppMgt.GetActivatedReminderExtensionSetup() then
            exit(false);

        SetFieldsPropertyVisibleEditableBySetup(PageID);

        Dimension1Visible := DimensionVisible[1];
        Dimension2Visible := DimensionVisible[2];
        Dimension3Visible := DimensionVisible[3];
        Dimension4Visible := DimensionVisible[4];
        Dimension5Visible := DimensionVisible[5];
        Dimension6Visible := DimensionVisible[6];
        Dimension7Visible := DimensionVisible[7];
        Dimension8Visible := DimensionVisible[8];
        Dimension9Visible := DimensionVisible[9];
        Dimension10Visible := DimensionVisible[10];
        Dimension1Editable := DimensionEditable[1];
        Dimension2Editable := DimensionEditable[2];
        Dimension3Editable := DimensionEditable[3];
        Dimension4Editable := DimensionEditable[4];
        Dimension5Editable := DimensionEditable[5];
        Dimension6Editable := DimensionEditable[6];
        Dimension7Editable := DimensionEditable[7];
        Dimension8Editable := DimensionEditable[8];
        Dimension9Editable := DimensionEditable[9];
        Dimension10Editable := DimensionEditable[10];

        exit(true);
    end;

    [EventSubscriber(ObjectType::Page, Page::"General Journal", 'OnAfterSetDimensionsVisibility', '', true, true)]
    local procedure OnAfterSetDimensionsVisibilityGeneralJournal(var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean;
        var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
        var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
        var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        SetDimensionsVisibility(Page::"General Journal", Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible, Dimension1Editable, Dimension2Editable, Dimension3Editable,
                Dimension4Editable, Dimension5Editable, Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable)
    end;

    local procedure SetDimensionsVisibility(
        PageID: Integer;
         var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean; var Dimension4Visible: Boolean; var Dimension5Visible: Boolean; var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean;
         var Dimension9Visible: Boolean; var Dimension10Visible: Boolean; var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean;
         var Dimension4Editable: Boolean; var Dimension5Editable: Boolean; var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        AppMgt.SetFieldsPropertyVisibleEditableBySetup(PageID);

        AppMgt.GetFieldsPropertyVisibleEditableBySetup(Dimension1Visible, Dimension2Visible, Dimension3Visible, Dimension4Visible, Dimension5Visible,
            Dimension6Visible, Dimension7Visible, Dimension8Visible, Dimension9Visible, Dimension10Visible,
            Dimension1Editable, Dimension2Editable, Dimension3Editable, Dimension4Editable, Dimension5Editable,
            Dimension6Editable, Dimension7Editable, Dimension8Editable, Dimension9Editable, Dimension10Editable);
    end;


}