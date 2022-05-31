codeunit 50026 "AppMgtNVX"
{

    var
        GLSetup: Record "General Ledger Setup";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        SetupReminderExtension: Record SetupReminderExtensionNVX;
        UserSetup: Record "User Setup";
        DimMgt: codeunit DimensionManagement;
        DimensionEditable: array[10] of Boolean;
        DimensionVisible: array[10] of Boolean;
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
        GLSetupShortcutDimCode: array[10] of Code[20];
        NotAllowdBusinessFieldsForUserErr: Label 'You are not authorized to create a business area!\Please contact your Systemadministrator', comment = 'DEA="Sie haben keine Berechtigung, um ein Geschäftsfeld anzulegen!\Bitte kontaktieren Sie Ihren Systemadministrator."';
        PipeTok: Label '|';
        ShortcutDimension9CodeTxt: Label 'SAMMELKto';
        ShortcutDimension10CodeTxt: Label 'VERTEILUNG';
        PageList: List of [integer];

    procedure AllowdBusinessFieldsForUser(BusinessFilter: Code[20]; BusinessFieldValue: Code[20]): Boolean
    var
        RegEx: Codeunit DotNet_Regex;
    begin
        if BusinessFieldValue = '' then
            exit(false);

        Regex.Regex(BusinessFilter);

        if RegEx.IsMatch(BusinessFieldValue) then
            exit(true);

        Error(NotAllowdBusinessFieldsForUserErr);
    end;

    procedure AllowdBusinessFieldsForUser()
    begin
        if not UserHasNoBusinessField() then
            Error(NotAllowdBusinessFieldsForUserErr);
    end;


    procedure AllowEmptyFilterinPages(): Boolean
    begin
        exit(SetupReminderExtension.Get() and SetupReminderExtension.AllowEmptyfilter);
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

    procedure CreateBusinessFieldFilter(var Rec: Record "User Setup")
    begin
        CreateBusinessFieldFilter(Rec, false);
    end;

    procedure CreateBusinessFieldFilter(var Rec: Record "User Setup"; InclusiveEmptyEntries: Boolean): Boolean
    var
        c: char;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
        TextBuilder: TextBuilder;
    begin
        c := 39;

        if not (Rec.PBSetupNVX or Rec.RDSetupNVX or Rec.RHSetupNVX or Rec.EASetupNVX or Rec.SOSetupNVX or Rec.EVSetupNVX) then begin
            if AllowEmptyFilterinPages() then
                Rec.BusinessFieldFilterNVX := format(c) + format(c);
            exit(false);
        end;

        if Rec.PBSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::PB) + PipeTok);
        if Rec.RDSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::RD) + PipeTok);
        if Rec.RHSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::RH) + PipeTok);
        if Rec.EASetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::EA) + PipeTok);
        if Rec.SOSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::SO) + PipeTok);
        if Rec.EVSetupNVX then
            TextBuilder.Append(Format(DimShortcutBusinessField::EV) + PipeTok);
        if InclusiveEmptyEntries then
            TextBuilder.Append(format(c) + Format(c))
        else
            TextBuilder.Remove(StrLen(TextBuilder.ToText()), 1);

        Rec.BusinessFieldFilterNVX :=
            CopyStr(
                TextBuilder.ToText(), 1, TextBuilder.Capacity(MaxStrLen(Rec.BusinessFieldFilterNVX)));

        Rec.Modify();

        exit(true);
    end;

    procedure GetActivateBusinessFilterInPages(): Boolean
    begin
        exit(SetupReminderExtension.Get() and SetupReminderExtension.ActivateBusinessFilterInPages);
    end;

    procedure GetActiveCustBusinessFieldFilter(CustomerNo: Code[20]; var CustomerBusinessField: Record CustomerBusinessFieldNVX): Boolean
    begin
        CustomerBusinessField.Reset();
        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField.SetRange("Dimension Value Type", CustomerBusinessField."Dimension Value Type"::Standard);
        CustomerBusinessField.SetRange(Active, true);
    end;

    procedure GetBusinessFieldFilterNVX(): Code[20];
    begin
        GetUserSetup(UserSetup, true);
        exit(UserSetup.BusinessFieldFilterNVX);
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

    /// <summary>
    /// ToDo
    /// </summary>
    procedure GetPermissionUserSetup()
    begin

    end;

    procedure GetUserSetup(var UserSetup2: Record "User Setup")
    begin
        GetUserSetup(UserSetup2, false);
    end;

    procedure GetUserSetup(var UserSetup2: Record "User Setup"; UseTestUser: Boolean)
    begin
        if UseTestUser then begin
            if SetupReminderExtension.Get() then
                if SetupReminderExtension."Test User Activate" and (SetupReminderExtension."Test User ID" <> '') then
                    UserSetup2.Get(SetupReminderExtension."Test User ID")
                else
                    UserSetup2.Get(UserId);
        end else
            UserSetup2.Get(UserId);
    end;

    procedure HasValue(FieldRef: FieldRef): Boolean
    var
        FieldRec: Record Field;
        HasValueBoolean: Boolean;
        D: Date;
        Dec: Decimal;
        Int: Integer;
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

    procedure Initialize()
    begin
        GetGLSetup();

        PageList.AddRange(
            20, 25, 29, 38, 39, 40, 41, 42, 43, 44, 46, 47, 54, 55, 62, 95, 96, 97, 98, 131, 132, 133, 135, 137, 139, 141, 142, 143, 144,
            171, 176, 232, 251, 253, 254, 255, 256, 380, 508, 510, 516, 517, 518, 519, 536, 537, 573, 574, 752, 755, 901, 921, 931, 941, 5160,
            5163, 5165, 5168, 5628, 5629, 5741, 5744, 5746, 5802, 5877, 5885, 5934, 5936, 5956, 5973, 5979, 6621, 6624, 6628, 6631, 6641, 6645,
            9300, 9301, 9302, 9305
        );
    end;

    procedure InitializeDimensionCustomer()
    var
        Customer: Record Customer;
    begin
        if Customer.FindSet() then
            repeat
                InsertPKShortCutdimension(Customer);
                InsertPKDefaultDim(Customer);
            until customer.Next() = 0;
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

    procedure InsertPKShortCutdimension(Customer: Record Customer)
    var
        DimensionValue: Record "Dimension Value";
    begin
        Glsetup.GetRecordOnce();

        IF NOT DimensionValue.Get(GLSetup."Shortcut Dimension 7 Code", Customer."No.") then begin
            DimensionValue.Init();
            DimensionValue."Dimension Code" := GLSetup."Shortcut Dimension 7 Code";
            DimensionValue.Code := Customer."No.";
            DimensionValue.Name := CopyStr(Customer.Name, 1, MaxStrLen(DimensionValue.Name));
            DimensionValue.Insert(true);
        END else
            ModifyPKShortCutdimension(Customer);
    end;

    procedure InsertSetupPropertyForField()
    var
        Dimension: Record Dimension;
        index: Integer;
        PageID: Integer;
        ConfirmDeleteMsg: Label 'Do you realy want to delete data from the Setuptable and insert new?', comment = 'DEA="Wollen Sie wirklich die Einrichtungstabelle löschen und neu befüllen? "';
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System";
    begin
        if not SetupPropertyForFields.IsEmpty() then
            if Confirm(ConfirmDeleteMsg, true) then
                SetupPropertyForFields.DeleteAll();

        Initialize();

        foreach PageID in Pagelist do begin
            if Dimension.FindSet() then
                repeat
                    SetupPropertyForFields.Init();
                    SetupPropertyForFields."Object ID" := PageID;
                    SetupPropertyForFields.Dimension := Dimension.Code;
                    SetupPropertyForFields.Insert();
                until Dimension.Next() = 0;
            for index := 1 to ArrayLen(GLSetupShortcutDimCode) do begin
                SetupPropertyForFields.Get(ObjectType::Page, PageID, GLSetupShortcutDimCode[index]);
                SetupPropertyForFields.IsVisible := true;
                SetupPropertyForFields.Modify();
            end;
        end;
    end;

    procedure IsNormalField(FieldRef: FieldRef): Boolean
    begin
        if Format(FieldRef.Class) = 'Normal' then
            exit(true);

        exit(false);
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

    procedure OpenIBANWebSite()
    begin
        SetupReminderExtension.Get();
        Hyperlink(SetupReminderExtension.WebSiteIBAN);
    end;

    procedure SetActiveAndStateCustomerBusinessLines(CustomerNo: code[20])
    var
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        IsHandled: Boolean;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
        Counter: Integer;
    begin
        OnBeforeGetGetBusinessLines(CustomerBusinessField, IsHandled);
        if IsHandled then
            exit;

        GetUserSetup(UserSetup, true);

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
        DimEditable: array[10] of Boolean;
        DimVisible: array[10] of Boolean;
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

    procedure ShowCustBusinessFieldFactBox(): Boolean
    begin
        exit(UserHasNoBusinessField());
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

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, CustLedgerEntry."Dimension Set ID");
        CustLedgerEntry.Modify();

        OnAfterValidateShortcutDimCode(CustLedgerEntry, ShortcutDimCode);
    end;

    local procedure GetGLSetup()
    begin
        GLSetup.GetRecordOnce();

        GLSetupShortcutDimCode[1] := GLSetup."Shortcut Dimension 1 Code";
        GLSetupShortcutDimCode[2] := GLSetup."Shortcut Dimension 2 Code";
        GLSetupShortcutDimCode[3] := GLSetup."Shortcut Dimension 3 Code";
        GLSetupShortcutDimCode[4] := GLSetup."Shortcut Dimension 4 Code";
        GLSetupShortcutDimCode[5] := GLSetup."Shortcut Dimension 5 Code";
        GLSetupShortcutDimCode[6] := GLSetup."Shortcut Dimension 6 Code";
        GLSetupShortcutDimCode[7] := GLSetup."Shortcut Dimension 7 Code";
        GLSetupShortcutDimCode[8] := GLSetup."Shortcut Dimension 8 Code";
        if GLSetup.ShortcutDimension9CodeNVX = '' then
            GLSetup.ShortcutDimension9CodeNVX := ShortcutDimension9CodeTxt;
        if GLSetup.ShortcutDimension10CodeNVX = '' then
            GLSetup.ShortcutDimension10CodeNVX := ShortcutDimension10CodeTxt;
        GLSetupShortcutDimCode[9] := GLSetup.ShortcutDimension9CodeNVX;
        GLSetupShortcutDimCode[10] := GLSetup.ShortcutDimension10CodeNVX;
    end;

    local procedure ModifyPKShortCutdimension(Customer: Record Customer)
    var
        DimensionValue: Record "Dimension Value";
    begin
        GetGLSetup();

        IF DimensionValue.Get(GLSetup."Shortcut Dimension 7 Code", Customer."No.") then
            if DimensionValue.Name <> Customer.Name then begin
                DimensionValue.Name := CopyStr(Customer.Name, 1, MaxStrLen(DimensionValue.Name));
                DimensionValue.Modify();
            END;
    end;

    local procedure UserHasNoBusinessField(): Boolean
    begin
        GetUserSetup(UserSetup, true);
        if not (UserSetup.PBSetupNVX or UserSetup.RDSetupNVX or UserSetup.RHSetupNVX or UserSetup.EASetupNVX or UserSetup.SOSetupNVX or UserSetup.EVSetupNVX) then
            exit(false)
        else
            exit(true);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterValidateShortcutDimCode(var CustLedgerEntry: Record "Cust. Ledger Entry"; VAR ShortcutDimCode: Code[20])
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetGetBusinessLines(var SetupBusinessField: record CustomerBusinessFieldNVX; var IsHandled: Boolean);
    begin
    end;
}