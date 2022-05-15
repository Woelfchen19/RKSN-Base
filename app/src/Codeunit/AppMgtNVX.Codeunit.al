codeunit 50026 "AppMgtNVX"
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

    procedure OnLookupByBusinessFieldDimension(BusinessFieldDimension: Code[20]; GlobalDimensionNo: integer): Code[20]
    var
        DimensionValue: Record "Dimension Value";
    begin
        DimensionValue.Reset();
        DimensionValue.FilterGroup(2);
        DimensionValue.SetRange("Global Dimension No.", GlobalDimensionNo);
        DimensionValue.SetRange(Blocked, false);
        DimensionValue.SetRange(ShortcutDimension5CodeNVX, BusinessFieldDimension);
        if GlobalDimensionNo <> 9 then
            DimensionValue.SetRange("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
        DimensionValue.FilterGroup(0);

        if PAGE.RUNMODAL(PAGE::"Dimension Value List", DimensionValue) = Action::LookupOK then
            exit(DimensionValue.Code);
    end;

    procedure ShowPagePaymentTerms(Token: Code[20]): Code[10]
    var
        PaymentTerms: Record "Payment Terms";
        PaymentTermsPage: Page "Payment Terms";
    begin
        PaymentTerms.Reset();
        PaymentTerms.FilterGroup(2);
        PaymentTerms.SetFilter(Code, '%1', Token + '*');
        PaymentTerms.FilterGroup(0);
        PaymentTerms.FindSet();

        PaymentTermsPage.SetTableView(PaymentTerms);
        PaymentTermsPage.Editable(false);
        PaymentTermsPage.LookupMode(true);

        if PaymentTermsPage.RunModal() = Action::LookupOK then
            PaymentTermsPage.GetRecord(PaymentTerms);

        exit(PaymentTerms.Code)
    end;

    procedure ShowPagePaymentMethods(Token: Code[20]): Code[10]
    var
        PaymentMethod: Record "Payment Method";
        PaymentMethodPage: Page "Payment Methods";
    begin
        PaymentMethod.Reset();
        PaymentMethod.FilterGroup(2);
        PaymentMethod.SetFilter(Code, '%1', Token + '*');
        PaymentMethod.FilterGroup(0);
        PaymentMethod.FindSet();

        PaymentMethodPage.SetTableView(PaymentMethod);
        PaymentMethodPage.Editable(false);
        PaymentMethodPage.LookupMode(true);

        if PaymentMethodPage.RunModal() = Action::LookupOK then
            PaymentMethodPage.GetRecord(PaymentMethod);

        exit(PaymentMethod.Code)
    end;

    procedure ShowPageReminderTerms(ShortCutDimension5: Code[20]): Code[10]
    var
        ReminderTerms: Record "Reminder Terms";
        ReminderTermsPage: Page "Reminder Terms";
    begin
        ReminderTerms.Reset();
        ReminderTerms.FilterGroup(2);
        ReminderTerms.SetRange(ShortcutDimension5CodeNVX, ShortCutDimension5);
        ReminderTerms.FilterGroup(0);

        ReminderTermsPage.SetTableView(ReminderTerms);
        ReminderTermsPage.Editable(false);
        ReminderTermsPage.LookupMode(true);

        if ReminderTermsPage.RunModal() = Action::LookupOK then
            ReminderTermsPage.GetRecord(ReminderTerms);

        exit(ReminderTerms.Code)
    end;

    procedure ShowPageCustomerBankAccount(CodeFilter: Text): Code[20]
    var
        CustomerBankAccount: Record "Customer Bank Account";
        CustomerBankAccountPage: Page "Customer Bank Account List";
    begin
        CustomerBankAccount.Reset();
        CustomerBankAccount.FilterGroup(2);
        CustomerBankAccount.SetFilter(Code, CodeFilter);
        CustomerBankAccount.FilterGroup(0);

        CustomerBankAccountPage.SetTableView(CustomerBankAccount);
        CustomerBankAccountPage.Editable(false);
        CustomerBankAccountPage.LookupMode(true);

        if CustomerBankAccountPage.RunModal() = Action::LookupOK then
            CustomerBankAccountPage.GetRecord(CustomerBankAccount);

        exit(CustomerBankAccount.Code)
    end;

    procedure SetActiveAndStateCustomerBusinessLines(CustomerNo: code[20]; _UserID: Text)
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
        IsHandled: Boolean;
        Counter: Integer;
    begin
        OnBeforeGetGetBusinessLines(CustomerBusinessField, IsHandled);
        if IsHandled then
            exit;

        if not UserSetup.Get(_UserId) then
            exit;

        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField.SetRange("Dimension Value Type", CustomerBusinessField."Dimension Value Type"::Standard);
        if CustomerBusinessField.FindSet() then
            repeat
                case CustomerBusinessField."Shortcut Dimension 5 Code" of
                    Format(DimShortcutBusinessField::PB):
                        if UserSetup.PBSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::PB);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::RD):
                        if UserSetup.RDSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::RD);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::RH):
                        if UserSetup.RHSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::RH);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::EA):
                        if UserSetup.EASetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::EA);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::SO):
                        if UserSetup.SOSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::SO);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::EV):
                        if UserSetup.EVSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::EV);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::All):
                        if counter > 1 then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::All);
                            CustomerBusinessField.Active := true;
                            CustomerBusinessField.Modify();
                        end;
                end
            until CustomerBusinessField.Next() = 0;
    end;

    procedure HasValue(FieldRef: FieldRef): Boolean
    var
        FieldRec: Record Field;
        HasValueBoolean: Boolean;
        Int: Integer;
        Dec: Decimal;
        D: Date;
        T: Time;
    begin
        Evaluate(FieldRec.Type, Format(FieldRef.Type));

        case FieldRec.Type of
            FieldRec.Type::Boolean:
                HasValueBoolean := FieldRef.Value;
            FieldRec.Type::Option:
                HasValueBoolean := true;
            FieldRec.Type::Integer:
                begin
                    Int := FieldRef.Value;
                    HasValueBoolean := Int <> 0;
                end;
            FieldRec.Type::Decimal:
                begin
                    Dec := FieldRef.Value;
                    HasValueBoolean := Dec <> 0;
                end;
            FieldRec.Type::Date:
                begin
                    D := FieldRef.Value;
                    HasValueBoolean := D <> 0D;
                end;
            FieldRec.Type::Time:
                begin
                    T := FieldRef.Value;
                    HasValueBoolean := T <> 0T;
                end;
            FieldRec.Type::BLOB:
                HasValueBoolean := false;
            else
                HasValueBoolean := Format(FieldRef.Value) <> '';
        end;

        exit(HasValueBoolean);
    end;

    procedure IsNormalField(FieldRef: FieldRef): Boolean
    begin
        if Format(FieldRef.Class) = 'Normal' then
            exit(true);

        exit(false);
    end;

    procedure ShowCustBusinessFieldFactBox(_UserID: Text): Boolean
    begin
        if not UserSetup.Get(_UserID) then
            exit(false)
        else
            if not (UserSetup.PBSetupNVX or UserSetup.RDSetupNVX or UserSetup.RHSetupNVX or UserSetup.EASetupNVX or UserSetup.SOSetupNVX or UserSetup.EVSetupNVX) then
                exit(false);

        exit(true);
    end;

    procedure CreateBusinessFieldFilter(var Rec: Record "User Setup")
    begin
        CreateBusinessFieldFilter(Rec, false);
    end;

    procedure CreateBusinessFieldFilter(var Rec: Record "User Setup"; InclusiveEmptyEntries: Boolean)
    var
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
        TextBuilder: TextBuilder;
    begin
        if not (Rec.PBSetupNVX or Rec.RDSetupNVX or Rec.RHSetupNVX or Rec.EASetupNVX or Rec.SOSetupNVX or Rec.EVSetupNVX) then
            exit;

        if Rec.PBSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::PB) + '|');
        if Rec.RDSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::RD) + '|');
        if Rec.RHSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::RH) + '|');
        if Rec.EASetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::EA) + '|');
        if Rec.SOSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::SO) + '|');
        if Rec.EVSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::EV) + '|');
        if InclusiveEmptyEntries and AllowEmptyFilterinPages() then
            TextBuilder.Append(EmptyFilterTxt)
        else
            TextBuilder.Remove(StrLen(TextBuilder.ToText()), 1);

        Rec.BusinessFieldFilterNVX := (CopyStr(TextBuilder.ToText(), 1, TextBuilder.Capacity(20)));
    end;

    procedure GetBusinessFieldFilterNVX(_UserID: Text): Code[20];
    begin
        exit(UserSetup.BusinessFieldFilterNVX);
    end;

    procedure GetActiveCustBusinessFieldFilter(CustomerNo: Code[20]; var CustomerBusinessField: Record CustomerBusinessFieldNVX): Boolean
    begin
        CustomerBusinessField.Reset();
        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField.SetRange("Dimension Value Type", CustomerBusinessField."Dimension Value Type"::Standard);
        CustomerBusinessField.SetRange(Active, true);
    end;

    procedure GetActivateBusinessFilterInPages(): Boolean
    begin
        exit(SetupReminderExtension.Get() and SetupReminderExtension.ActivateBusinessFilterInPages);
    end;

    procedure AllowEmptyFilterinPages(): Boolean
    begin
        exit(SetupReminderExtension.Get() and SetupReminderExtension.AllowEmptyfilter);
    end;

    procedure OpenIBANWebSite()
    begin
        SetupReminderExtension.Get();
        Hyperlink(SetupReminderExtension.WebSiteIBAN);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetGetBusinessLines(var SetupBusinessField: record CustomerBusinessFieldNVX; var IsHandled: Boolean);
    begin
    end;

    var
        GLSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        SetupReminderExtension: Record SetupReminderExtensionNVX;
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
        EmptyFilterTxt: Label '''''';
}