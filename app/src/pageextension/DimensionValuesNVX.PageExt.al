pageextension 50005 "DimensionValuesNVX" extends "Dimension Values"
{
    layout
    {
        addlast(Control1)
        {
            field(VATPostingTypeNVX; Rec.VATPostingTypeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VAT Posting Type field.', Comment = 'DEA="USt.-Buchungsart"';
                Visible = PostingTypeVisible;
            }
            field(VATPostingTypeDescNVX; Rec.VATPostingTypeDescNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the VATPostingTypeDesc field.', comment = 'DEA="Ust.-Buchungsartbeschreibung"';
                Visible = PostingTypeVisible;
                ;
            }
            field(DimValueNVXShortcutDimension1CodeNVX; Rec.ShortcutDimension1CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 1 Code field.', Comment = 'DEA="Shortcutdimensionscode 1"';
                Visible = IsOE;
            }
            field(DimValueNVXShortcutDimension2CodeNVX; Rec.ShortcutDimension2CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 2 Code field.', Comment = 'DEA="Shortcutdimensionscode 2"';
                Visible = IsOE;
            }
            field(AssociatedNVX; Rec.AssociatedNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assosiated field.', Comment = 'DEA="zugehörig"';
                Visible = AssosiatedVisible;
            }
            field(ShortcutDimension5CodeNVX; Rec.ShortcutDimension5CodeNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Shortcut Dimension 5 Code field.';
                Visible = DimValueNVXShortcutDimension5CodeVisible;
            }
            field(ReOrganizeAccountNVX; Rec.ReOrganizeAccountNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the ReorganizeAccount field.', Comment = 'DEA="Umbelastung Sachkto"';
                Visible = ReOrganizeAccountVisible;
            }
            field(DischargeAccountNVX; Rec.DischargeAccountNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Discharge Account field.', Comment = 'DEA="Entlastung Sachkto"';
                Visible = DischargeAccountVisible;
            }
            field(AssignedNVX; Rec.AssignedToBusinessFieldNVX)
            {
                ApplicationArea = All;
                ToolTip = 'Specifies the value of the Assigned field.', Comment = 'DEA="Zugeordnet"';
                Visible = AssignedVisible;
            }
        }
        addbefore(Control1900383207)
        {
            part(AssignmentDepartmentFBNVX; AssignmentDepartmentFactBoxNVX)
            {
                ApplicationArea = All;
                Caption = 'Assignment Department', comment = 'DEA="Zuordnung KST"';
                SubPageLink = "Shortcut Dimension 5 Code" = field(Code);
                Visible = AssignmentDepartmentFBNVXVisible;
            }
        }
    }
    actions
    {
        addlast("F&unctions")
        {
            action(AssignmentDepartmentNVX)
            {
                ApplicationArea = All;
                Caption = 'Assignment Department', comment = 'DEA="KST zuordnen"';
                Image = Apply;
                Promoted = true;
                PromotedOnly = true;
                RunObject = Page AssignmentDepartmentListNVX;
                RunPageLink = "Shortcut Dimension 5 Code" = FIELD(Code);
                ToolTip = 'Executes the Assignment Department action.';
                Visible = AssosiatedDepartment;
            }
            action(ReminderFieldsNVX)
            {
                ApplicationArea = Dimensions;
                Caption = 'Reminder Fields', comment = 'DEA="Felder Mahnbeleg"';
                image = Reminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = page ReminderControlBusFieldListNVX;
                RunPageLink = ReminderSetupExtension = filter(BusinessField);
                Visible = AssignmentDepartmentFBNVXVisible;
            }
            action(ReminderAssosiatedNVX)
            {
                ApplicationArea = Dimensions;
                Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
                image = Reminder;
                Promoted = true;
                PromotedOnly = true;
                PromotedIsBig = true;
                RunObject = page ReminderControlPCListNVX;
                RunPageLink = ReminderSetupExtension = filter(PC);
                Visible = AssosiatedVisible;
            }
        }
    }

    trigger OnOpenPage()
    begin
        AppMgt.GetUserSetup(UserSetup, true);
    end;

    trigger OnAfterGetRecord()
    begin
        SetFieldsVisible();

        if (GetFilter("Dimension Code") = GlSetup."Shortcut Dimension 5 Code") then begin
            AssosiatedDepartment := Rec."Dimension Value Type" = Rec."Dimension Value Type"::Standard;
            CurrPage.Editable := UserSetup.AllowedDimension5CodeChangeNVX;
        end;
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean
    var
        DimensionValue: Record "Dimension Value";
    begin
        if AssosiatedVisible then begin
            DimensionValue.Copy(Rec);
            DimensionValue.SetRange("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
            DimensionValue.SetRange(AssociatedNVX, '');
            if not DimensionValue.IsEmpty then
                Error(AssociationErrorMsg);

            exit(true);
        end;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AppMgt: Codeunit AppMgtNVX;
        AssignedVisible: Boolean;
        AssignmentDepartmentFBNVXVisible: Boolean;
        AssosiatedDepartment: Boolean;
        AssosiatedVisible: Boolean;
        DimValueNVXShortcutDimension5CodeVisible: Boolean;
        DischargeAccountVisible: Boolean;
        IsOE: Boolean;
        PostingTypeVisible: Boolean;
        ReOrganizeAccountVisible: Boolean;
        AssociationErrorMsg: Label 'You must assign to all Profitcenter the field associated!', comment = 'DEA="Sie müssen zu allen ProfitCenter im Feld zugehörig eine Zuordnung vornehmen!"';

    local procedure SetFieldsVisible()
    begin
        GLSetup.GetRecordOnce();
        PostingTypeVisible := "Dimension Code" = GLSetup."Shortcut Dimension 3 Code";
        IsOE := "Dimension Code" = GLSetup."Shortcut Dimension 6 Code";
        DimValueNVXShortcutDimension5CodeVisible := "Dimension Code" = GlSetup.ShortcutDimension9CodeNVX;
        ReOrganizeAccountVisible := "Dimension Code" = GlSetup.ShortcutDimension9CodeNVX;
        DischargeAccountVisible := "Dimension Code" = GlSetup.ShortcutDimension9CodeNVX;
        AssignedVisible := "Dimension Code" = GlSetup."Shortcut Dimension 1 Code";
        AssosiatedVisible := "Dimension Code" = GlSetup."Shortcut Dimension 2 Code";
        AssosiatedDepartment := "Dimension Code" = GlSetup."Shortcut Dimension 5 Code";
        AssignmentDepartmentFBNVXVisible := "Dimension Code" = GlSetup."Shortcut Dimension 5 Code";
    end;
}