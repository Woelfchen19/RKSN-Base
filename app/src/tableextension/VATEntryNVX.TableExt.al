tableextension 50006 "VATEntryNVX" extends "VAT Entry"
{
    fields
    {
        field(50000; GlobalDimension2CodeNVX; Code[20])
        {
            Caption = 'Global Dimension 2 Code';
            CaptionClass = '1,2,2';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(2));
        }
        field(50001; GlobalDimension5CodeNVX; Code[20])
        {
            Caption = 'Global Dimension 5 Code';
            CaptionClass = '1,2,5';
            Editable = false;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
        }
        field(50002; DimensionSetIDNVX; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";

            trigger OnLookup()
            begin
                ShowDimensionsNVX();
            end;
        }
    }
    var
        DimensionManagement: Codeunit DimensionManagement;

    procedure CopyShortCutDimensionsFromDimensionValuesNVX()
    VAR
        ShortcutDimCode: ARRAY[10] OF Code[20];
    begin
        GetShortcutDimensionsNVX(DimensionSetIDNVX, ShortcutDimCode);
        GlobalDimension2CodeNVX := ShortcutDimCode[2];
        GlobalDimension5CodeNVX := ShortcutDimCode[5];
    end;

    procedure GetShortcutDimensionsNVX(DimSetID: Integer; VAR ShortcutDimCode: ARRAY[10] OF Code[20])
    begin
        DimensionManagement.GetShortcutDimensions(DimSetID, ShortcutDimCode);
    end;

    procedure ShowDimensionsNVX()
    begin
        DimensionManagement.ShowDimensionSet(DimensionSetIDNVX, CopyStr(StrSubstNo('%1 %2', TableCaption, "Entry No."), 1, 250))
    end;
}