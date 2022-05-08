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

    procedure SetFieldsPropertyVisibleEditableBySetup(PageID: integer)
    begin
        SetFieldsPropertyVisibleEditableBySetup(8, PageID);
    end;

    procedure SetFieldsPropertyVisibleEditableBySetup(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: integer
        )
    var
        DimVisible: array[10] of Boolean;
        DimEditable: array[10] of Boolean;
    begin
        SetFieldsPropertyVisibleEditableBySetup(ObjectType, PageID, DimVisible, DimEditable);
    end;

    procedure SetFieldsPropertyVisibleEditableBySetup(
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
        PageID: integer;
        DimVisible: array[10] of Boolean;
        DimEditable: array[10] of Boolean)
    var
        i: integer;
    begin
        GLSetup.Get();

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
    end;

    procedure GetFieldsPropertyVisibleEditableBySetup(
        var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean; var Dimension4Visible: Boolean; var Dimension5Visible: Boolean;
            var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean; var Dimension9Visible: Boolean; var Dimension10Visible: Boolean;
                var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean; var Dimension4Editable: Boolean; var Dimension5Editable: Boolean;
                    var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
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
    end;

    procedure InsertDimValue(AllocationCode: Record AllocationCodeNVX)
    var
        Dimvalue: Record "Dimension Value";
    begin
        GLSetup.Get();
        if not Dimvalue.Get(Glsetup.ShortcutDimension10CodeNVX, AllocationCode.Code) then begin
            Dimvalue.Init();
            Dimvalue.Validate("Dimension Code", Glsetup.ShortcutDimension10CodeNVX);
            Dimvalue.Validate(Code, AllocationCode.Code);
            dimvalue.Validate(Name, AllocationCode.Description);
            Dimvalue.insert(true);
        end;
    end;

    procedure BlockDimValue(AllocationCode: Code[10])
    var
        Dimvalue: Record "Dimension Value";
    begin
        GLSetup.Get();
        if Dimvalue.Get(Glsetup.ShortcutDimension10CodeNVX, AllocationCode) then begin
            Dimvalue.Blocked := true;
            Dimvalue.Modify(true);
        end;
    end;

    procedure ModifyDimensionSetEntry(var GenJnlLine: Record "Gen. Journal Line"; AllocationCode: Code[20])
    VAR
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        GLSetup.Get();
        DimMgt.GetDimensionSet(TempDimSetEntry, GenJnlLine."Dimension Set ID");

        TempDimSetEntry.Init();
        TempDimSetEntry.Validate("Dimension Code", GLSetup.ShortcutDimension10CodeNVX);
        TempDimSetEntry.Validate("Dimension Value Code", AllocationCode);
        if TempDimSetEntry.Insert() then;

        GenJnlLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        GenJnlLine.ValidateShortcutDimCode(10, AllocationCode);
    end;

    procedure ModifyDimensionSetEntry(var PurchaseLine: Record "Purchase Line"; AllocationCode: Code[20])
    VAR
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        GLSetup.Get();
        DimMgt.GetDimensionSet(TempDimSetEntry, PurchaseLine."Dimension Set ID");

        TempDimSetEntry.Init();
        TempDimSetEntry.Validate("Dimension Code", GLSetup.ShortcutDimension10CodeNVX);
        TempDimSetEntry.Validate("Dimension Value Code", AllocationCode);
        if TempDimSetEntry.Insert() then;

        PurchaseLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        PurchaseLine.ValidateShortcutDimCode(10, AllocationCode);
    end;

    procedure ModifyDimensionSetEntry(var SalesLine: Record "Sales Line"; AllocationCode: Code[20])
    VAR
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        GLSetup.Get();
        DimMgt.GetDimensionSet(TempDimSetEntry, SalesLine."Dimension Set ID");

        TempDimSetEntry.Init();
        TempDimSetEntry.Validate("Dimension Code", GLSetup.ShortcutDimension10CodeNVX);
        TempDimSetEntry.Validate("Dimension Value Code", AllocationCode);
        if TempDimSetEntry.Insert() then;

        SalesLine."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        SalesLine.ValidateShortcutDimCode(10, AllocationCode);
    end;

    procedure InsertPKShortCutdimension(Customer: Record Customer)
    var
        DimensionValue: Record "Dimension Value";
    begin
        Glsetup.Get();
        IF NOT DimensionValue.Get(GLSetup."Shortcut Dimension 7 Code", Customer."No.") then begin
            DimensionValue.Init();
            DimensionValue."Dimension Code" := GLSetup."Shortcut Dimension 7 Code";
            DimensionValue.Code := Customer."No.";
            DimensionValue.Name := CopyStr(Customer.Name, 1, 50);
            DimensionValue.Insert(true);
        END else
            ModifyPKShortCutdimension(Customer);
    end;

    local procedure ModifyPKShortCutdimension(Customer: Record Customer)
    var
        DimensionValue: Record "Dimension Value";
    begin
        Glsetup.Get();
        IF DimensionValue.Get(GLSetup."Shortcut Dimension 7 Code", Customer."No.") then
            if DimensionValue.Name <> Customer.Name then begin
                DimensionValue.Name := CopyStr(Customer.Name, 1, 50);
                DimensionValue.Modify();
            END;
    end;


    procedure InsertPKDefaultDim(Customer: Record Customer)
    var
        DefaultDimension: Record "Default Dimension";
    begin
        GLSetup.Get();
        DefaultDimension.SetRange("Table ID", DATABASE::Customer);
        DefaultDimension.SetRange("No.", Customer."No.");
        DefaultDimension.SetRange("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
        IF DefaultDimension.IsEmpty THEN begin
            DefaultDimension.Init();
            DefaultDimension."Table ID" := DATABASE::Customer;
            DefaultDimension."No." := Customer."No.";
            DefaultDimension."Dimension Code" := GLSetup."Shortcut Dimension 7 Code";
            DefaultDimension."Dimension Value Code" := Customer."No.";
            DefaultDimension."Value Posting" := DefaultDimension."Value Posting"::"Same Code";
            DefaultDimension.Insert();
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        DimMgt: codeunit DimensionManagement;
        DimensionVisible: array[10] of Boolean;
        DimensionEditable: array[10] of Boolean;
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
}