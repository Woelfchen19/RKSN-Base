tableextension 50005 "CustLedgerentryNVX" extends "Cust. Ledger Entry"
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
                DimensionManagement.ValidateShortcutDimValues(3, ShortcutDimension3CodeNVX, "Dimension Set ID");
            end;
        }
        field(50001; ShortcutDimension4CodeNVX; Code[20])
        {
            CaptionClass = '1,2,4';
            Caption = 'Shortcut Dimension 4 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(4), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(4, ShortcutDimension4CodeNVX, "Dimension Set ID");
            end;
        }
        field(50002; ShortcutDimension5CodeNVX; Code[20])
        {
            CaptionClass = '1,2,5';
            Caption = 'Shortcut Dimension 5 Code';

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(5, ShortcutDimension5CodeNVX, "Dimension Set ID");
            end;
        }
        field(50003; ShortcutDimension6CodeNVX; Code[20])
        {
            CaptionClass = '1,2,6';
            Caption = 'Shortcut Dimension 6 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(6), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(6, ShortcutDimension6CodeNVX, "Dimension Set ID");
            end;
        }
        field(50004; ShortcutDimension7CodeNVX; Code[20])
        {
            CaptionClass = '1,2,7';
            Caption = 'Shortcut Dimension 7 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(7, ShortcutDimension7CodeNVX, "Dimension Set ID");
            end;
        }
        field(50005; ShortcutDimension8CodeNVX; Code[20])
        {
            CaptionClass = '1,2,8';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(8), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(8, ShortcutDimension8CodeNVX, "Dimension Set ID");
            end;
        }

        field(50006; ShortcutDimension9CodeNVX; Code[20])
        {
            CaptionClass = '1,2,9';
            Caption = 'Shortcut Dimension 9 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(9, ShortcutDimension9CodeNVX, "Dimension Set ID");
            end;
        }
        field(50007; ShortcutDimension10CodeNVX; Code[20])
        {
            CaptionClass = '1,2,10';
            Caption = 'Shortcut Dimension 10 Code';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(10), Blocked = CONST(false));

            trigger OnValidate()
            begin
                DimensionManagement.ValidateShortcutDimValues(10, ShortcutDimension10CodeNVX, "Dimension Set ID");
            end;
        }
        field(50010; AssociatedNVX; Code[20])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = Lookup("Dimension value".Code WHERE(Code = FIELD("Global Dimension 2 Code")));
        }
    }

    procedure SetAssociatedNVX()
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        if ("Global Dimension 2 Code" = '') or (Rec.AssociatedNVX <> '') then
            exit;

        GLSetup.Get();
        DimensionValue.Get(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
        Rec.AssociatedNVX := Dimensionvalue.AssociatedNVX;
    end;

    procedure SetAssociatedNVX(Upgrade: Boolean)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        if not Upgrade then
            exit;

        GLSetup.Get();

        if CustLedgerEntry.FindSet() then
            repeat
                if ("Global Dimension 2 Code" <> '') and (Rec.AssociatedNVX = '') then begin
                    DimensionValue.Get(GLSetup."Global Dimension 2 Code", Rec."Global Dimension 2 Code");
                    CustLedgerEntry.AssociatedNVX := Dimensionvalue.AssociatedNVX;
                    CustLedgerEntry.Modify();
                end;
            until CustLedgerEntry.Next() = 0;
    end;

    procedure CopyShortCutDimensionsFromDimensionValuesNVX()
    VAR
        ShortcutDimCode: ARRAY[10] OF Code[20];
    begin
        GetShortcutDimensionsNVX("Dimension Set ID", ShortcutDimCode);
        ShortcutDimension3CodeNVX := ShortcutDimCode[3];
        ShortcutDimension4CodeNVX := ShortcutDimCode[4];
        ShortcutDimension5CodeNVX := ShortcutDimCode[5];
        ShortcutDimension6CodeNVX := ShortcutDimCode[6];
        ShortcutDimension7CodeNVX := ShortcutDimCode[7];
        ShortcutDimension8CodeNVX := ShortcutDimCode[8];
        ShortcutDimension9CodeNVX := ShortcutDimCode[9];
        ShortcutDimension10CodeNVX := ShortcutDimCode[10];
        Modify();
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
                    SetCurrentKey("Global Dimension 2 Code", "Posting Date", "Document No.");
                    SetAscending("Global Dimension 2 Code", false);
                end;
            4:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, "Posting Date", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
            5:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, "Posting Date", "Global Dimension 2 Code", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
            6:
                begin
                    SetCurrentKey(ShortcutDimension5CodeNVX, ShortcutDimension9CodeNVX, "Global Dimension 2 Code", "Posting Date", "Document No.");
                    SetAscending(ShortcutDimension5CodeNVX, false);
                end;
        end;
    end;


    var
        DimensionManagement: Codeunit DimensionManagement;
}