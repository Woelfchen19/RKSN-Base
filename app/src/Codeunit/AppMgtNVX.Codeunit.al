codeunit 50026 AppMgtNVX
{
    procedure SetDimensionsVisibility(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: integer;
        DimVisible: array[10] of Boolean;
        DimEditable: array[10] of Boolean)
    begin
        SetFieldsPropertyVisibleEditableBySetup(ObjectType, PageID, DimVisible, DimEditable);
    end;

    procedure SetFieldsPropertyVisibleEditableBySetup(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: integer;
        DimVisible: array[10] of Boolean;
        DimEditable: array[10] of Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        DimMgt: codeunit DimensionManagement;
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
    begin
        GLSetup.Get();

        DimMgt.UseShortcutDims(
          DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10);

        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 1 Code") then begin
            DimVisible1 := DimVisible1 and SetupPropertyForFields.IsVisible;
            DimEditable1 := DimEditable1 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 2 Code") then begin
            DimVisible2 := DimVisible2 and SetupPropertyForFields.IsVisible;
            DimEditable2 := DimEditable2 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 3 Code") then begin
            DimVisible3 := DimVisible3 and SetupPropertyForFields.IsVisible;
            DimEditable3 := DimEditable3 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 4 Code") then begin
            DimVisible4 := DimVisible4 and SetupPropertyForFields.IsVisible;
            DimEditable4 := DimEditable4 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 5 Code") then begin
            DimVisible5 := DimVisible5 and SetupPropertyForFields.IsVisible;
            DimEditable5 := DimEditable5 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 6 Code") then begin
            DimVisible6 := DimVisible6 and SetupPropertyForFields.IsVisible;
            DimEditable6 := DimEditable6 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 7 Code") then begin
            DimVisible7 := DimVisible7 and SetupPropertyForFields.IsVisible;
            DimEditable7 := DimEditable7 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup."Shortcut Dimension 8 Code") then begin
            DimVisible8 := DimVisible8 and SetupPropertyForFields.IsVisible;
            DimEditable8 := DimEditable8 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension9CodeNVX) then begin
            DimVisible9 := DimVisible9 and SetupPropertyForFields.IsVisible;
            DimEditable9 := DimEditable9 and SetupPropertyForFields.IsEditable;
        end;
        if SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetup.ShortcutDimension10CodeNVX) then begin
            DimVisible10 := DimVisible10 and SetupPropertyForFields.IsVisible;
            DimEditable10 := DimEditable10 and SetupPropertyForFields.IsEditable;
        end;

        Clear(DimMgt);

        dimvisible[1] := DimVisible1;
        dimvisible[2] := DimVisible2;
        dimvisible[3] := DimVisible3;
        dimvisible[4] := DimVisible4;
        dimvisible[5] := DimVisible5;
        dimvisible[6] := DimVisible6;
        dimvisible[7] := DimVisible7;
        dimvisible[8] := DimVisible8;
        dimvisible[9] := DimVisible9;
        dimvisible[10] := DimVisible10;

        DimEditable[1] := DimEditable1;
        DimEditable[2] := DimEditable2;
        DimEditable[3] := DimEditable3;
        DimEditable[4] := DimEditable4;
        DimEditable[5] := DimEditable5;
        DimEditable[6] := DimEditable6;
        DimEditable[7] := DimEditable7;
        DimEditable[8] := DimEditable8;
        DimEditable[9] := DimEditable9;
        DimEditable[10] := DimEditable10;
    end;
}