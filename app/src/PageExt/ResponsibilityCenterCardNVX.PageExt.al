pageextension 50045 "ResponsibilityCenterCardNVX" extends "Responsibility Center Card"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field("Shortcut Dimension 3 CodeNVX"; ShortcutDimCode3)
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
                CaptionClass = '1,2,3';
                trigger OnValidate();
                var
                    DimMgt: Codeunit DimensionManagement;
                begin
                    DimMgt.ValidateDimValueCode(3,ShortcutDimCode3);
                    DimMgt.SaveDefaultDim(DATABASE::"Responsibility Center",Code,3,ShortcutDimCode3);
                end;
            }
            
        }
    }

    var
        ShortcutDimCode3: Code[20];

    trigger OnAfterGetRecord();
    var
        DefaultDim: Record "Default Dimension";
        GLSetup: Record "General Ledger Setup";
    begin
        GLSetup.Get();
        DefaultDim.SetRange("Table ID", Database::"Responsibility Center");
        DefaultDim.SetRange("No.",Rec.Code);
        DefaultDim.SetRange("Dimension Code",GLSetup."Shortcut Dimension 3 Code");
        IF DefaultDim.FindFirst() then
            ShortcutDimCode3 := DefaultDim."Dimension Value Code"
        else
            Clear(ShortcutDimCode3);
    end;
}