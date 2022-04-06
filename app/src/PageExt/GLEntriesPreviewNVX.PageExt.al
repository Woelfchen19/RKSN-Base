pageextension 50039 GLEntriesPreviewNVX extends "G/L Entries Preview"
{
    layout
    {
        addafter("Global Dimension 2 Code")
        {
            field(ShortcutDimension3CodeNVX; ShortcutDims[3])
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                ToolTip = 'Specifies the value of the Shortcut Dimension 3 Code field.', Comment = 'DEA="Shortcutdimensionscode 3"';
                Editable = false;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                CaptionClass = '1,2,3';
            }
        }
    }

    var
        DimMgt: Codeunit DimensionManagement;
        ShortcutDims: array[8] of Code[20];

    trigger OnAfterGetRecord()
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;
}