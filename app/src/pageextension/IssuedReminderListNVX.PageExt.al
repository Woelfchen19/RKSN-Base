pageextension 50065 "IssuedReminderListNVX" extends "Issued Reminder List"
{
    layout
    {
        modify("Shortcut Dimension 1 Code")
        {
            Editable = DimEditable1;
            Visible = DimVisible1;
        }
        modify("Shortcut Dimension 2 Code")
        {
            Editable = DimEditable2;
            Visible = DimVisible2;
        }
        addafter("Shortcut Dimension 2 Code")
        {
            field(Shortcutdimension5CodeNVX; ShortcutDims[5])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,5';
                Editable = DimEditable5;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(5));
                Visible = DimVisible5;
            }
            field(Shortcutdimension7CodeNVX; ShortcutDims[7])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,7';
                Editable = DimEditable7;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(7));
                Visible = DimVisible7;
            }
            field(Shortcutdimension9CodeNVX; ShortcutDims[9])
            {
                ApplicationArea = All;
                CaptionClass = '1,2,9';
                Editable = DimEditable9;
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(9));
                Visible = DimVisible9;
            }
        }
    }

    actions
    {
        addafter(Statistics)
        {
            action(IssuedReminderEditNVX)
            {
                Caption = 'Modify', comment = 'DEA="Bearbeiten"';
                ApplicationArea = All;
                Visible = IssuedReminderEditVisible;
                Image = Edit;
                Promoted = true;
                ShortCutKey = 'Ctrl+Shift+E';

                PromotedIsBig = true;
                PromotedCategory = Process;
                ToolTip = 'Open the Issued Reminder in modify modus.', comment = 'DEA="Ausgewählte Zeile im Bearbeitungsmodus öffnen."';
                RunObject = page IssuedReminderEditNVX;
                RunPageLink = "No." = FIELD("No.");
            }
        }
    }

    trigger OnOpenPage()
    begin
        if DimensionFieldManagement.GetFieldsPropertyVisibleEditableBySetup(
            Page::"Issued Reminder List",
                DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                    DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10)
        then begin
            AppMgt.GetUserSetup(UserSetup, true);
            IssuedReminderEditVisible := UserSetup.AllowedModifyIssuedReminderNVX;
        end;
    end;

    trigger OnAfterGetRecord();
    begin
        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    end;

    var
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
        DimensionFieldManagement: Codeunit DimensionFieldManagementNVX;
        DimMgt: Codeunit DimensionManagement;
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
        IssuedReminderEditVisible: Boolean;
        ShortcutDims: array[10] of Code[20];
}