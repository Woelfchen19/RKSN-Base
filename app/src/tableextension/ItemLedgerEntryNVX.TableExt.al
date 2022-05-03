tableextension 50009 "ItemLedgerEntryNVX" extends "Item Ledger Entry"
{
    fields
    {
        field(50000; ShortcutDimension3CodeNVX; Code[20])
        {
            CaptionClass = '1,2,3';
            Caption = 'Shortcut Dimension 3 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(3, ShortcutDimension3CodeNVX, "Dimension Set ID");
            end;
        }
        field(50001; ShortcutDimension4CodeNVX; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(4, ShortcutDimension4CodeNVX, "Dimension Set ID");
            end;
        }
        field(50002; ShortcutDimension5CodeNVX; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(5, ShortcutDimension5CodeNVX, "Dimension Set ID");
            end;
        }
        field(50003; ShortcutDimension6CodeNVX; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(6, ShortcutDimension6CodeNVX, "Dimension Set ID");
            end;
        }
        field(50004; ShortcutDimension7CodeNVX; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(7, ShortcutDimension7CodeNVX, "Dimension Set ID");
            end;
        }
        field(50005; ShortcutDimension8CodeNVX; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(8, ShortcutDimension8CodeNVX, "Dimension Set ID");
            end;
        }

        field(50006; ShortcutDimension9CodeNVX; Code[20])
        {
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(9, ShortcutDimension9CodeNVX, "Dimension Set ID");
            end;
        }
        field(50007; ShortcutDimension10CodeNVX; Code[20])
        {
            CaptionClass = '1,2,10';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(10), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimMgt.ValidateShortcutDimValues(10, ShortcutDimension10CodeNVX, "Dimension Set ID");

            end;
        }
    }
    procedure CopyShortCutDimensionsFromDimensionValuesNVX()
    VAR
        ShortcutDimCode: ARRAY[10] OF Code[20];
    begin
        GetShortcutDimensionsNVX(ShortcutDimCode);
        ShortcutDimension3CodeNVX := ShortcutDimCode[3];
        ShortcutDimension4CodeNVX := ShortcutDimCode[4];
        ShortcutDimension5CodeNVX := ShortcutDimCode[5];
        ShortcutDimension6CodeNVX := ShortcutDimCode[6];
        ShortcutDimension7CodeNVX := ShortcutDimCode[7];
        ShortcutDimension8CodeNVX := ShortcutDimCode[8];
        ShortcutDimension9CodeNVX := ShortcutDimCode[9];
        ShortcutDimension10CodeNVX := ShortcutDimCode[10];
    end;

    procedure GetShortcutDimensionsNVX(VAR ShortcutDimCode: ARRAY[10] OF Code[20])
    begin
        DimMgt.GetShortcutDimensions("Dimension Set ID", ShortcutDimCode);
    end;

    var
        DimMgt: Codeunit DimensionManagement;
}
