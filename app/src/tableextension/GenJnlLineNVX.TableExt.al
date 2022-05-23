tableextension 50014 "GenJnlLineNVX" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; ShortcutDimension10CodeNVX; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="ShortcutDimensionscode 10"';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(10, ShortcutDimension10CodeNVX);
            end;
        }
        field(50001; AllocCodeNVX; Code[10])
        {
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002; VATPostingTypeNVX; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50003; AssociatedNVX; Text[10])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            DataClassification = CustomerContent;
        }
        field(50004; DoNotSplitNVX; Boolean)
        {
            Caption = 'Do Not Split', comment = 'DEA="Nicht aufsplitten"';
            DataClassification = CustomerContent;
        }
        field(50005; FixedGBPGNVX; Code[20])
        {
            Caption = 'FixedGBPG', comment = 'DEA="FixedGBPG"';
            DataClassification = CustomerContent;
        }
        field(50006; IsRetrospectPostingNVX; Boolean)
        {
            Caption = 'IsRetrospectPosting', comment = 'DEA="Ist eine Retrobuchung"';
            DataClassification = CustomerContent;
        }
        field(50007; ApplyDocumentNoNVX; Boolean)
        {
            Caption = 'Apply Document No.', comment = 'DEA="„Ausziff.Beleg“"';
            DataClassification = ToBeClassified;
        }
    }
    procedure SetBusinessFieldNVX()
    var
        AssosiatedDepartment: Record AssosiatedDepartmentNVX;
    begin
        AssosiatedDepartment.Reset();
        AssosiatedDepartment.SetRange("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if AssosiatedDepartment.FindFirst() then
            Rec.ValidateShortcutDimCode(5, AssosiatedDepartment."Shortcut Dimension 5 Code");
    end;

    procedure SetAssociatedNVX()
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        if Rec."Shortcut Dimension 1 Code" = '' then
            exit;

        GLSetup.Get();
        DimensionValue.Get(GLSetup."Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        Rec.AssociatedNVX := Dimensionvalue.AssociatedNVX;
        Rec.Modify();
    end;

}