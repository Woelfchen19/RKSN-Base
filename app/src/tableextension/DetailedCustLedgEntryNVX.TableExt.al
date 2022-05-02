tableextension 50007 DetailedCustLedgEntryNVX extends "Detailed Cust. Ledg. Entry"
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
                DimensionManagement.ValidateShortcutDimValues(3, ShortcutDimension3CodeNVX, DimensionSetIDNVX);
            end;
        }
        field(50001; ShortcutDimension4CodeNVX; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(4, ShortcutDimension4CodeNVX, DimensionSetIDNvx);
            end;
        }
        field(50002; ShortcutDimension5CodeNVX; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(5, ShortcutDimension5CodeNVX, DimensionSetIDNVX);
            end;
        }
        field(50003; ShortcutDimension6CodeNVX; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(6, ShortcutDimension6CodeNVX, DimensionSetIDNVX);
            end;
        }
        field(50004; ShortcutDimension7CodeNVX; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(7, ShortcutDimension7CodeNVX, DimensionSetIDNVX);
            end;
        }
        field(50005; ShortcutDimension8CodeNVX; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(8, ShortcutDimension8CodeNVX, DimensionSetIDNVX);
            end;
        }

        field(50006; ShortcutDimension9CodeNVX; Code[20])
        {
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(9, ShortcutDimension9CodeNVX, DimensionSetIDNVX);
            end;
        }
        field(50007; ShortcutDimension10CodeNVX; Code[20])
        {
            CaptionClass = '1,2,10';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(10), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(10, ShortcutDimension10CodeNVX, DimensionSetIDNVX);

            end;
        }
        field(50010; DimensionSetIDNVX; Integer)
        {
            Caption = 'Dimension Set ID';
            Editable = false;
            TableRelation = "Dimension Set Entry";
        }
    }

    procedure CopyShortCutDimensionsFromDimensionValuesNVX()
    VAR
        ShortcutDimCode: ARRAY[10] OF Code[20];
    begin
        GetShortcutDimensionsNVX(DimensionSetIDNVX, ShortcutDimCode);
        ShortcutDimension3CodeNVX := ShortcutDimCode[3];
        ShortcutDimension4CodeNVX := ShortcutDimCode[4];
        ShortcutDimension5CodeNVX := ShortcutDimCode[5];
        ShortcutDimension6CodeNVX := ShortcutDimCode[6];
        ShortcutDimension7CodeNVX := ShortcutDimCode[7];
        ShortcutDimension8CodeNVX := ShortcutDimCode[8];
        ShortcutDimension9CodeNVX := ShortcutDimCode[9];
        ShortcutDimension10CodeNVX := ShortcutDimCode[10];
    end;

    procedure GetShortcutDimensionsNVX(DimSetID: Integer; VAR ShortcutDimCode: ARRAY[10] OF Code[20])
    begin
        DimensionManagement.GetShortcutDimensions(DimSetID, ShortcutDimCode);
    end;

    procedure SortByNVX(Index: Integer)
    begin
        case index of
            1:
                begin
                    SetCurrentKey("Posting Date", "Document No.");
                    SetAscending("Posting Date", false);
                end;
            2:
                begin
                    SetCurrentKey("Document No.", "Posting Date");
                    SetAscending("Document No.", false);
                end;
            3:
                begin
                    SetCurrentKey("Initial Entry Global Dim. 2", "Posting Date", "Document No.");
                    SetAscending("Initial Entry Global Dim. 2", false);
                end;
            4:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, "Posting Date", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
            5:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, "Posting Date", "Initial Entry Global Dim. 2", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
            6:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, ShortcutDimension9CodeNVX, "Initial Entry Global Dim. 2", "Posting Date", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
        end;
    end;

    var
        DimensionManagement: Codeunit DimensionManagement;
}