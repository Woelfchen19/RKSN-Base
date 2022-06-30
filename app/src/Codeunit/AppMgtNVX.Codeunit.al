codeunit 50026 "AppMgtNVX"
{
    var
        GLSetup: Record "General Ledger Setup";
        ReminderExtensionSetup: Record "ReminderExtensionSetupNVX";
        SetupPropertyForFields: Record SetupPropertyForFieldsNVX;
        UserSetup: Record "User Setup";
        CustomerBusinessField: Record CustomerBusinessFieldNVX;
        AppMgt: Codeunit AppMgtNVX;
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
        OldParentDimSetID: Integer;
        RecordHasBeenRead: Boolean;
        NotAllowdBusinessFieldForUserErr: Label 'You are not authorized to choice the business area %1! Please contact your Systemadministrator', comment = 'DEA="Sie haben keine Berechtigung, das Geschäftsfeld %1 auszuwählen! Bitte kontaktieren Sie Ihren Systemadministrator."', Locked = true;
        NotAllowdBusinessFieldsForUserErr: Label 'You are not authorized to choice business areas %1! Please contact your Systemadministrator', comment = 'DEA="Sie haben keine Berechtigung, Geschäftsfelder auszuwählen! Bitte kontaktieren Sie Ihren Systemadministrator."', Locked = true;
        PipeTok: Label '|';
        ShortcutDimension9CodeTxt: Label 'SAMMELKto';
        ShortcutDimension10CodeTxt: Label 'VERTEILUNG';
        PageList: List of [integer];

    procedure AllowdBusinessFieldsForUser(BusinessFilter: Code[40]; BusinessFieldValue: Code[20]; ShowError: Boolean): Boolean
    var
        RegEx: Codeunit DotNet_Regex;
    begin
        if BusinessFieldValue = '' then
            exit(false);

        Regex.Regex(BusinessFilter);

        if RegEx.IsMatch(BusinessFieldValue) then
            exit(true);

        if ShowError then
            Error(NotAllowdBusinessFieldForUserErr, BusinessFieldValue);

        exit(false);
    end;

    procedure AllowdBusinessFieldsForUser()
    begin
        if UserHasNoBusinessField() then
            Error(NotAllowdBusinessFieldsForUserErr);
    end;


    procedure AllowEmptyFilterinPages(): Boolean
    begin
        if GetActivatedReminderExtensionSetup() then
            exit(ReminderExtensionSetup.Get() and ReminderExtensionSetup.AllowEmptyfilter);
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
        if not GetActivatedReminderExtensionSetup() then
            exit;

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

        TextBuilder.Append(Format(DimShortcutBusinessField::All) + PipeTok);

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

    procedure ChangeShortcutDimension5CodeSalesHeader(var Rec: Record "Sales Header"; CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        Rec.ShortcutDimension5CodeNVX := CustLedgerEntry.ShortcutDimension5CodeNVX;
        Rec.ValidateShortcutDimCode(5, Rec.ShortcutDimension5CodeNVX);
    end;

    procedure ChangeShortcutDimension5CodeGenJnlLine(var Rec: Record "Gen. Journal Line")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
    // GenJnlLine: Record "Gen. Journal Line";
    begin
        if Rec."Applies-to ID" = '' then
            exit;

        CustLedgerEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
        if CustLedgerEntry.FindFirst() then
            if Rec.ShortcutDimension5CodeNVX <> CustLedgerEntry.ShortcutDimension5CodeNVX then begin
                Rec.ShortcutDimension5CodeNVX := CustLedgerEntry.ShortcutDimension5CodeNVX;
                Rec.ValidateShortcutDimCode(5, Rec.ShortcutDimension5CodeNVX);
                Rec.Modify();
            end;

        //ToDo Call Wagi
        // CustLedgerEntry.SetRange("Applies-to ID", Rec."Applies-to ID");
        // if not CustLedgerEntry.FindSet() then
        //     exit;

        // GenJnlLine := Rec;
        // repeat
        //     GenJnlLine.ModifyAll(ShortcutDimension5CodeNVX, CustLedgerEntry.ShortcutDimension5CodeNVX);

        //     .ShortcutDimension5CodeNVX := CustLedgerEntry.ShortcutDimension5CodeNVX;
        //     Rec.ValidateShortcutDimCode(5, Rec.ShortcutDimension5CodeNVX);
        // until CustLedgerEntry.Next() = 0;
    end;

    procedure GetActivatedReminderExtensionSetup(): Boolean
    begin
        ReminderExtensionSetup.GetRecordOnce();
        exit(ReminderExtensionSetup.ActivateReminderExtension);
    end;

    procedure GetActiveCustBusinessFieldFilter(CustomerNo: Code[20]; var CustomerBusinessField2: Record CustomerBusinessFieldNVX): Boolean
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        CustomerBusinessField2.Reset();
        CustomerBusinessField2.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField2.SetRange("Dimension Value Type", CustomerBusinessField."Dimension Value Type"::Standard);
    end;

    procedure GetBusinessFieldFilterNVX(): Code[40];
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        GetUserSetup(UserSetup, true);
        exit(UserSetup.BusinessFieldFilterNVX);
    end;

    procedure GetCustomerBusinessDimension9(CustomerNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]): Code[20]
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        if CustomerBusinessField.Get(CustomerNo, ShortcutDimension5CodeNVX) then
            exit(CustomerBusinessField."Shortcut Dimension 9 Code");
        exit('');
    end;

    procedure GetFieldsPropertyVisibleEditableBySetup(
        var Dimension1Visible: Boolean; var Dimension2Visible: Boolean; var Dimension3Visible: Boolean; var Dimension4Visible: Boolean; var Dimension5Visible: Boolean;
            var Dimension6Visible: Boolean; var Dimension7Visible: Boolean; var Dimension8Visible: Boolean; var Dimension9Visible: Boolean; var Dimension10Visible: Boolean;
                var Dimension1Editable: Boolean; var Dimension2Editable: Boolean; var Dimension3Editable: Boolean; var Dimension4Editable: Boolean; var Dimension5Editable: Boolean;
                    var Dimension6Editable: Boolean; var Dimension7Editable: Boolean; var Dimension8Editable: Boolean; var Dimension9Editable: Boolean; var Dimension10Editable: Boolean)
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

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

    procedure GetShortcutDimension5FromAssignmentDepartment(ShortcutDimension1Code: Code[20]): Code[20]
    var
        AssignmentDepartment: Record AssignmentDepartmentNVX;
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        if ShortcutDimension1Code = '' then
            exit;

        AssignmentDepartment.SetRange("Shortcut Dimension 1 Code", ShortcutDimension1Code);
        if AssignmentDepartment.FindFirst() then
            exit(AssignmentDepartment."Shortcut Dimension 5 Code");
    end;

    procedure GetUserSetup(var UserSetup2: Record "User Setup")
    begin
        GetUserSetup(UserSetup2, false);
    end;

    procedure GetUserSetup(var UserSetup2: Record "User Setup"; UseTestUser: Boolean)
    begin
        if UseTestUser then begin
            if ReminderExtensionSetup.Get() then
                if ReminderExtensionSetup."Test User Activate" and (ReminderExtensionSetup."Test User ID" <> '') then
                    UserSetup2.Get(ReminderExtensionSetup."Test User ID")
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

    procedure InitializeDimensionCustomer()
    var
        Customer: Record Customer;
    begin
        if Customer.FindSet() then
            repeat
                InsertPKShortCutdimension(Customer);
                InsertPKDefaultDim(Customer);
            until Customer.Next() = 0;
    end;

    procedure InitializePages()
    begin
        GetGLSetup();

        PageList.AddRange(
            20, 25, 29, 39, 40, 41, 42, 43, 44, 46, 47, 54, 55, 62, 95, 96, 97, 98, 131, 133, 135, 137, 139, 141, 143, 144,
            171, 176, 232, 251, 253, 254, 255, 256, 380, 434, 436, 438, 440, 480, 508, 510, 516, 517, 518, 519, 536, 537, 573, 574, 752, 755, 901,
            921, 931, 941, 5160, 5163, 5165, 5168, 5628, 5629, 5741, 5744, 5746, 5802, 5877, 5885, 5934, 5936, 5956, 5973, 5979, 6621, 6624,
            6628, 6631, 6641, 6645, 9300, 9301, 9302, 9305
        );
    end;

    procedure InitializeReminderExtensionSetup()
    var
        UpgradeMgt: Codeunit UpgradeMgtNVX;
        ReadyMsg: Label 'Initialize finished', comment = 'DEA="Initialisierung abgeschlossen"';
    begin
        UpgradeMgt.Upgrade();
        Message(ReadyMsg);
    end;

    procedure InsertAllocationDimValue(AllocationCode: Record AllocationCodeNVX)
    var
        Dimvalue: Record "Dimension Value";
    begin
        GLSetup.GetRecordOnce();

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
        GLSetup.GetRecordOnce();

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

    procedure InsertSetupBusinessField(OnlyAll: Boolean)
    var
        Customer: Record Customer;
    begin
        if Customer.Findset() then
            repeat
                CustomerBusinessField.InsertSetupBusinessField(Customer."No.");
            until Customer.Next() = 0;
    end;

    procedure InsertSetupBusinessFieldsForCustomer()
    begin
        InsertSetupBusinessField(false);
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

        InitializePages();

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

    procedure ValidateShortcutDimCodes(var Rec: Record "Gen. Journal Line")
    var
        GenJournalBatch: Record GenJournalBatchNVX;
        AllocationCode: Record AllocationCodeNVX;
        AssignmentDepartment: Record AssignmentDepartmentNVX;
        ShortcutDimCode: Array[10] of Code[20];
    begin
        GLSetup.GetRecordOnce();

        DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDimCode);

        if GenJournalBatch.Get(Rec."Journal Template Name", Rec."Journal Batch Name") then
            if GenJournalBatch.ShortcutDimension5CodeNVX <> '' then begin
                ShortcutDimCode[5] := GenJournalBatch.ShortcutDimension5CodeNVX;
                Rec.ValidateShortcutDimCode(5, ShortcutDimCode[5]);
            end;

        AssignmentDepartment.Reset();
        AssignmentDepartment.SetRange("Shortcut Dimension 5 Code", ShortcutDimCode[5]);
        if AssignmentDepartment.FindFirst() then begin
            ShortcutDimCode[1] := AssignmentDepartment."Shortcut Dimension 1 Code";
            Rec.ValidateShortcutDimCode(1, ShortcutDimCode[1]);
        end;

        AllocationCode.SetRange("Shortcut Dimension 2 Code", ShortcutDimCode[2]);
        if AllocationCode.FindFirst() then begin
            ShortcutDimCode[10] := AllocationCode.Code;
            Rec.ValidateShortcutDimCode(10, ShortcutDimCode[10]);
        end;
    end;

    procedure ModifyDimension5SetEntry(var SalesHeader: Record "Sales Header"; var ShortcutDimension5Code: Code[20])
    VAR
        TempDimSetEntry: Record "Dimension Set Entry" temporary;
    begin
        GLSetup.Get();
        DimMgt.GetDimensionSet(TempDimSetEntry, SalesHeader."Dimension Set ID");

        TempDimSetEntry.Reset();
        TempDimSetEntry.DeleteAll();

        TempDimSetEntry.Init();
        TempDimSetEntry.Validate("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
        TempDimSetEntry.Validate("Dimension Value Code", ShortcutDimension5Code);
        TempDimSetEntry.Insert();

        SalesHeader."Dimension Set ID" := DimMgt.GetDimensionSetID(TempDimSetEntry);
        SalesHeader.ValidateShortcutDimCode(5, ShortcutDimension5Code);
    end;

    //ToDo
    procedure ModifyDimensionSetEntry(var GenJnlLine: Record "Gen. Journal Line"; AllocationCode: Code[20])
    begin
        OldParentDimSetID := GenJnlLine."Dimension Set ID";
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

    procedure OnAfterLookupshortcutDimension5Code(var Rec: Record "Sales Header")
    begin
        OnValidateShortcutDimension(Rec);
    end;

    procedure OnAfterLookupshortcutDimension5Code(var Rec: Record "Reminder Header"; xRec: Record "Reminder Header"; DimensionShortcutDimension5Code: Code[20])
    begin
        OldParentDimSetID := xRec."Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(5, DimensionShortcutDimension5Code, Rec."Dimension Set ID");
    end;

    procedure OnAfterLookupshortcutDimension5Code(var Rec: Record "Reminder Terms")
    begin
    end;

    procedure OnAfterLookupshortcutDimension5Code(var Rec: Record "Dimension Value")
    begin
    end;

    procedure OnLookupByBusinessField9Dimension(BusinessFieldDimension: Code[20]; GlobalDimensionNo: integer; var DimensionValueCode: Code[20]): Boolean
    var
        DimensionValue: Record "Dimension Value";
        DimensionValues: Page "Dimension Values";
    begin
        DimensionValue.Reset();
        DimensionValue.FilterGroup(2);
        DimensionValue.SetRange("Global Dimension No.", GlobalDimensionNo);
        DimensionValue.SetRange(Blocked, false);
        DimensionValue.SetRange(ShortcutDimension5CodeNVX, BusinessFieldDimension);
        if GlobalDimensionNo <> 9 then
            DimensionValue.SetRange("Dimension Value Type", DimensionValue."Dimension Value Type"::Standard);
        DimensionValue.FilterGroup(0);

        DimensionValues.SetTableView(DimensionValue);
        DimensionValues.LookupMode(true);
        if DimensionValues.RunModal() = Action::LookupOK then begin
            DimensionValues.GetRecord(DimensionValue);
            DimensionValueCode := DimensionValue.Code;
            exit(true);
        end else
            exit(false);
    end;

    procedure OnLookupShortcutDimension5Code(var DimensionValueCode: Code[20]): Boolean
    var
        DimensionValue: Record "Dimension Value";
        DimensionValues: Page "Dimension Values";
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            AppMgt.GetUserSetup(UserSetup, true);
            AppMgt.AllowdBusinessFieldsForUser();
            DimensionValue.FilterGroup(2);
            DimensionValue.SetRange("Global Dimension No.", 5);
            DimensionValue.SetFilter(Code, UserSetup.BusinessFieldFilterNVX);
            DimensionValue.SetRange(Blocked, false);
            DimensionValue.FilterGroup(0);
            DimensionValues.LookupMode(true);
            DimensionValues.SetTableView(DimensionValue);
            DimensionValues.Editable(UserSetup.AllowedDimension5CodeChangeNVX);
            if (DimensionValues.RunModal() = Action::LookupOK) then begin
                DimensionValues.GetRecord(DimensionValue);
                DimensionValueCode := DimensionValue.Code;
                exit(true);
            end else
                exit(false);
        end else
            exit(false);
    end;

    procedure SetVendLedgEntryFilter(var VendLedgerEntry: Record "Vendor Ledger Entry"; WithAssociated: Boolean)
    var
        DimensionValue: Record "Dimension Value";
        GlobalDimension2Code: Code[20];
    begin
        if not AppMgt.GetActivatedReminderExtensionSetup() then
            exit;

        GlobalDimension2Code := VendLedgerEntry."Global Dimension 2 Code";
        if GlobalDimension2Code = '' then
            exit;

        GLSetup.GetRecordOnce();

        DimensionValue.Get(GLSetup."Global Dimension 2 Code", VendLedgerEntry."Global Dimension 2 Code");
        DimensionValue.TestField(AssociatedNVX);
        VendLedgerEntry.FilterGroup(2);
        VendLedgerEntry.Setrange("Global Dimension 2 Code", VendLedgerEntry."Global Dimension 2 Code");
        if WithAssociated then
            VendLedgerEntry.SetFilter(AssociatedNVX, DimensionValue.AssociatedNVX);
        VendLedgerEntry.FilterGroup(0);
    end;

    procedure SetVendLedgEntryFilter(var VendLedgerEntry: Record "Vendor Ledger Entry"; PurchHeader: Record "Purchase Header")
    begin
        SetVendLedgEntryFilter(VendLedgerEntry, PurchHeader, false);
    end;

    procedure SetVendLedgEntryFilter(var VendLedgerEntry: Record "Vendor Ledger Entry"; PurchHeader: Record "Purchase Header"; WithAssociated: Boolean)
    var
        DimensionValue: Record "Dimension Value";
        GlobalDimension2Code: Code[20];
    begin
        if not AppMgt.GetActivatedReminderExtensionSetup() then
            exit;

        GlobalDimension2Code := VendLedgerEntry."Global Dimension 2 Code";
        if GlobalDimension2Code = '' then
            exit;
        DimensionValue.Get(GLSetup."Global Dimension 2 Code", PurchHeader."Shortcut Dimension 2 Code");
        DimensionValue.TestField(AssociatedNVX);
        VendLedgerEntry.FilterGroup(2);
        VendLedgerEntry.Setrange("Global Dimension 2 Code", PurchHeader."Shortcut Dimension 2 Code");
        if WithAssociated then
            VendLedgerEntry.SetFilter(AssociatedNVX, DimensionValue.AssociatedNVX);
        VendLedgerEntry.FilterGroup(0);
    end;

    procedure SetCustLedgEntryFilter(var CustLedgerEntry: Record "Cust. Ledger Entry"; WithAssociated: Boolean)
    begin
        SetCustLedgEntryFilter(CustLedgerEntry, CustLedgerEntry."Dimension Set ID", WithAssociated);
    end;

    procedure SetCustLedgEntryFilter(var CustLedgerEntry: Record "Cust. Ledger Entry"; DimensionSetID: Integer; WithAssociated: Boolean)
    var
        DimensionValue: Record "Dimension Value";
        BusinessFieldFilter: Code[40];
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            GLSetup.GetRecordOnce();

            AppMgt.GetUserSetup(UserSetup, true);
            AppMgt.AllowdBusinessFieldsForUser();
            DimMgt.GetShortcutDimensions(DimensionSetID, GLSetupShortcutDimCode);
            AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, GLSetupShortcutDimCode[5], false);

            if GLSetupShortcutDimCode[5] <> '' then
                BusinessFieldFilter := GLSetupShortcutDimCode[5];
            // else
            //     BusinessFieldFilter := UserSetup.BusinessFieldFilterNVX;
            CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, BusinessFieldFilter);

            CustLedgerEntry.FilterGroup(2);
            CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
            if WithAssociated then
                if GLSetupShortcutDimCode[2] <> '' then begin
                    DimensionValue.Get(GLSetup."Global Dimension 2 Code", GLSetupShortcutDimCode[2]);
                    DimensionValue.TestField(AssociatedNVX);
                    CustLedgerEntry.SetFilter(AssociatedNVX, DimensionValue.AssociatedNVX);
                end;
            CustLedgerEntry.FilterGroup(0);
        end;
    end;

    procedure GetCustLedgEntryFilterForApply(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        CustLedgerEntry2: Record "Cust. Ledger Entry";
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            GLSetup.GetRecordOnce();

            AppMgt.GetUserSetup(UserSetup, true);
            AppMgt.AllowdBusinessFieldsForUser();
            AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, CustLedgerEntry.ShortcutDimension5CodeNVX, false);

            CustLedgerEntry2.SetCurrentKey("Customer No.", Open, "Global Dimension 2 Code", ShortcutDimension5CodeNVX);
            CustLedgerEntry2.SetRange(Open, true);
            CustLedgerEntry2.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
            CustLedgerEntry2.SetFilter(AssociatedNVX, CustLedgerEntry.AssociatedNVX);
            CustLedgerEntry.CopyFilters(CustLedgerEntry2);
        end;
    end;

    procedure SetDetailedCustLedgEntryFilter(var DetailedCustLedgerEntry: Record "Detailed Cust. Ledg. Entry")
    var
        BusinessFieldFilter: Code[40];
    begin
        if AppMgt.GetActivatedReminderExtensionSetup() then begin
            GLSetup.GetRecordOnce();

            AppMgt.GetUserSetup(UserSetup, true);
            AppMgt.AllowdBusinessFieldsForUser();
            DimMgt.GetShortcutDimensions(DetailedCustLedgerEntry.DimensionSetIDNVX, GLSetupShortcutDimCode);
            AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, GLSetupShortcutDimCode[5], false);

            DetailedCustLedgerEntry.FilterGroup(2);

            DetailedCustLedgerEntry.SetCurrentKey("Customer No.", ShortcutDimension5CodeNVX);
            DetailedCustLedgerEntry.SetRange("Customer No.", DetailedCustLedgerEntry."Customer No.");

            if GLSetupShortcutDimCode[5] <> '' then
                BusinessFieldFilter := GLSetupShortcutDimCode[5]
            else
                BusinessFieldFilter := UserSetup.BusinessFieldFilterNVX;
            DetailedCustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, BusinessFieldFilter);

            DetailedCustLedgerEntry.FilterGroup(0);
        end;
    end;

    procedure OpenCustomerLedgerEntries(Customer: Record Customer; FilterOnDueEntries: Boolean; CustomerBusinessField2: Record CustomerBusinessFieldNVX)
    var
        DetailedCustLedgEntry: Record "Detailed Cust. Ledg. Entry";
        CustLedgerEntry: Record "Cust. Ledger Entry";
    begin
        DetailedCustLedgEntry.SetRange("Customer No.", Customer."No.");
        Customer.CopyFilter("Global Dimension 1 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 1");
        Customer.CopyFilter("Global Dimension 2 Filter", DetailedCustLedgEntry."Initial Entry Global Dim. 2");
        if FilterOnDueEntries and (Customer.GetFilter("Date Filter") <> '') then begin
            Customer.CopyFilter("Date Filter", DetailedCustLedgEntry."Initial Entry Due Date");
            DetailedCustLedgEntry.SetFilter("Posting Date", '<=%1', Customer.GetRangeMax("Date Filter"));
        end;
        if CustomerBusinessField2."Shortcut Dimension 5 Code" <> '' then
            CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, CustomerBusinessField2."Shortcut Dimension 5 Code");
        Customer.CopyFilter("Currency Filter", DetailedCustLedgEntry."Currency Code");
        DrillDownOnEntries(DetailedCustLedgEntry, CustomerBusinessField2."Shortcut Dimension 5 Code");
    end;

    procedure DrillDownOnEntries(VAR DtldCustLedgEntry: Record "Detailed Cust. Ledg. Entry"; ShortcutDimension5CodeNVX: Code[20])
    var
        CustLedgentry: Record "Cust. Ledger Entry";
    begin
        AppMgt.GetUserSetup(UserSetup, true);

        CustLedgEntry.Reset();
        DtldCustLedgEntry.CopyFilter("Currency Code", CustLedgEntry."Currency Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 1", CustLedgEntry."Global Dimension 1 Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Global Dim. 2", CustLedgEntry."Global Dimension 2 Code");
        DtldCustLedgEntry.CopyFilter("Initial Entry Due Date", CustLedgEntry."Due Date");
        CustLedgentry.FilterGroup(2);
        CustLedgEntry.SetCurrentKey("Customer No.", "Posting Date");
        CustLedgentry.SetRange("Customer No.", DtldCustLedgEntry.Getfilter("Customer No."));
        CustLedgEntry.SetRange(Open, true);
        CustLedgentry.FilterGroup(0);
        if ShortcutDimension5CodeNVX <> '' then
            CustLedgentry.SetFilter(ShortcutDimension5CodeNVX, ShortcutDimension5CodeNVX)
        else
            CustLedgentry.SetFilter(ShortcutDimension5CodeNVX, AppMgt.GetBusinessFieldFilterNVX());

        PAGE.RUN(0, CustLedgEntry);
    end;

    procedure OnValidateShortcutDimension(var DimensionValue: Record "Dimension Value")
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();
        case DimensionValue."Global Dimension No." of
            5:
                AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, DimensionValue.Code, true);
            9:
                AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, DimensionValue.ShortcutDimension5CodeNVX, true);
        end;
    end;

    procedure ValidateCustLedgerEntryFilter(GenJnlLine: Record "Gen. Journal Line"; var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        DocumentNoNotFoundErr: Label 'Documentno. not found!', comment = 'DEA="Belegnummer nicht gefunden!"';
        NotAllowedErr: Label 'You have no permission for this Ledger entry!', comment = 'DEA="Sie sind zum gefundenen offenen Posten nicht berechtigt. Der offene Posten kann nicht angezeigt werden!"';
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        CustLedgerEntry.SetCurrentKey("Document No.");
        CustLedgerEntry.SetRange("Document No.", GenJnlLine.ApplyDocumentNoNVX);
        if CustLedgerEntry.IsEmpty then
            Error(DocumentNoNotFoundErr);
        CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
        if CustLedgerEntry.IsEmpty then
            Error(NotAllowedErr);
    end;

    procedure OnValidateApplyDocumentNo(var Rec: Record "Gen. Journal Line")
    var
        CustLedgerEntry: Record "Cust. Ledger Entry";
        VendorLedgerEntry: Record "Vendor Ledger Entry";
        CustomerLedgerEntries: Page "Customer Ledger Entries";
        VendorLedgerEntries: page "Vendor Ledger Entries";
    begin
        if Rec.ApplyDocumentNoNVX <> '' then begin
            Rec.Testfield("Posting Date");
            Rec.TestField("Document Type");

            ValidateVendortLedgerEntryFilter(VendorLedgerEntry, Rec.ApplyDocumentNoNVX);
            if VendorLedgerEntry."Vendor No." <> '' then begin
                VendorLedgerEntries.LookupMode(true);
                VendorLedgerEntries.SetTableView(VendorLedgerEntry);
                if VendorLedgerEntries.RunModal() = action::LookupOK then begin
                    VendorLedgerEntries.GetRecord(CustLedgerEntry);
                    Rec.Validate("Account Type", Rec."Account Type"::Vendor);
                    Rec.Validate("Account No.", VendorLedgerEntry."Vendor No.");
                end;
            end else begin
                ValidateCustLedgerEntryFilter(Rec, CustLedgerEntry);
                CustomerLedgerEntries.LookupMode(true);
                CustomerLedgerEntries.SetTableView(CustLedgerEntry);
                if CustomerLedgerEntries.RunModal() = action::LookupOK then begin
                    CustomerLedgerEntries.GetRecord(CustLedgerEntry);
                    Rec.Validate("Account Type", Rec."Account Type"::Customer);
                    Rec.Validate("Account No.", CustLedgerEntry."Customer No.");
                end;
            end;
            Rec.ApplyDocumentNoNVX := '';
        end;
    end;

    procedure ValidateVendortLedgerEntryFilter(var VendorLedgerEntry: Record "Vendor Ledger Entry"; ExternalDocumentNo: Code[35]): Boolean
    begin
        VendorLedgerEntry.Reset();
        VendorLedgerEntry.SetCurrentKey("External Document No.");
        VendorLedgerEntry.SetRange("External Document No.", ExternalDocumentNo);
        exit(VendorLedgerEntry.FindFirst());
    end;

    procedure SetBusinessFieldNVX(var Rec: Record "Gen. Journal Line")
    var
        AssignmentDepartment: Record AssignmentDepartmentNVX;
    begin
        AssignmentDepartment.Reset();
        AssignmentDepartment.SetRange("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if AssignmentDepartment.FindFirst() then
            Rec.ValidateShortcutDimCode(5, AssignmentDepartment."Shortcut Dimension 5 Code");
    end;

    procedure OnValidateShortcutDimension(var Rec: Record "Sales Header")
    var
        // AssignmentDepartment: Record AssignmentDepartmentNVX;
        ShortcutDimension9CodeNVX: Code[20];
    begin
        GetGLSetup();

        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();
        AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, Rec.ShortcutDimension5CodeNVX, true);

        OldParentDimSetID := Rec."Dimension Set ID";
        DimMgt.ValidateShortcutDimValues(5, Rec.ShortcutDimension5CodeNVX, Rec."Dimension Set ID");
        ShortcutDimension9CodeNVX := GetCustomerBusinessDimension9(Rec."Bill-to Customer No.", Rec.ShortcutDimension5CodeNVX);
        DimMgt.ValidateShortcutDimValues(9, ShortcutDimension9CodeNVX, Rec."Dimension Set ID");
        //ToDo
        // AssignmentDepartment.Reset();
        // AssignmentDepartment.SetRange("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        // if AssignmentDepartment.FindFirst() then
        //     Rec.ValidateShortcutDimCode(5, AssignmentDepartment."Shortcut Dimension 5 Code");

        if (OldParentDimSetID <> Rec."Dimension Set ID") and Rec.SalesLinesExist() then
            Rec.UpdateAllLineDim(Rec."Dimension Set ID", OldParentDimSetID);
    end;

    procedure OnValidateShortcutDimension(var Rec: Record "Reminder Header"; ShortcutDimension5Code: Code[20])
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();
        AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, ShortcutDimension5Code, true);
        DimMgt.ValidateShortcutDimValues(5, ShortcutDimension5Code, Rec."Dimension Set ID");
    end;

    procedure OnValidateShortcutDimension(var Rec: Record "Reminder Terms");
    begin
        AppMgt.GetUserSetup(UserSetup, true);
        AppMgt.AllowdBusinessFieldsForUser();
        AppMgt.AllowdBusinessFieldsForUser(UserSetup.BusinessFieldFilterNVX, Rec.ShortcutDimension5CodeNVX, true);
    end;

    procedure OpenIBANWebSite()
    begin
        ReminderExtensionSetup.GetRecordOnce();
        Hyperlink(ReminderExtensionSetup.WebSiteIBAN);
    end;

    procedure SetActiveAndStateCustomerBusinessLines(CustomerNo: code[20])
    var
        IsHandled: Boolean;
        DimShortcutBusinessField: Enum DimShortcutBusinessFieldNVX;
        Counter: Integer;
    begin
        OnBeforeGetGetBusinessLines(CustomerBusinessField, IsHandled);
        if IsHandled then
            exit;

        GetUserSetup(UserSetup, true);

        CustomerBusinessField.Reset();
        CustomerBusinessField.SetRange("Customer No.", CustomerNo);
        CustomerBusinessField.SetRange("Dimension Value Type", CustomerBusinessField."Dimension Value Type"::Standard);
        if CustomerBusinessField.FindSet() then
            repeat
                case CustomerBusinessField."Shortcut Dimension 5 Code" of
                    Format(DimShortcutBusinessField::PB):
                        if UserSetup.PBSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::PB);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::RD):
                        if UserSetup.RDSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::RD);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::RH):
                        if UserSetup.RHSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::RH);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::EA):
                        if UserSetup.EASetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::EA);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::SO):
                        if UserSetup.SOSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::SO);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::EV):
                        if UserSetup.EVSetupNVX then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::EV);
                            CustomerBusinessField.Modify();
                            counter += 1;
                        end;
                    Format(DimShortcutBusinessField::All):
                        if counter > 1 then begin
                            CustomerBusinessField.State := CustomerBusinessField.SetStatusSetup(CustomerNo, DimShortcutBusinessField::All);
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
        ObjectType: Option "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query","System"; PageID: integer)
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
        if not GetActivatedReminderExtensionSetup() then
            exit;

        GLSetup.GetRecordOnce();

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
        exit(not UserHasNoBusinessField());
    end;

    procedure ShowPageCustomerBankAccount(CustomerNo: Code[20]; CodeFilter: Code[20]; var CustomerBankAccountCode: Code[20]): Boolean
    var
        CustomerBankAccount: Record "Customer Bank Account";
        CustomerBankAccountPage: Page "Customer Bank Account List";
    begin
        CustomerBankAccount.Reset();
        CustomerBankAccount.FilterGroup(2);
        CustomerBankAccount.SetRange("Customer No.", CustomerNo);
        CustomerBankAccount.SetFilter(Code, CodeFilter);
        CustomerBankAccount.FilterGroup(0);

        CustomerBankAccountPage.SetTableView(CustomerBankAccount);
        CustomerBankAccountPage.Editable(false);
        CustomerBankAccountPage.LookupMode(true);

        if CustomerBankAccountPage.RunModal() = Action::LookupOK then begin
            CustomerBankAccountPage.GetRecord(CustomerBankAccount);
            CustomerBankAccountCode := CustomerBankAccount.Code;
            exit(true)
        end else
            exit(false);
    end;

    procedure ShowPagePaymentMethods(Token: Code[10]; var PaymentMethodCode: Code[10]): Boolean
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

        if PaymentMethodPage.RunModal() = Action::LookupOK then begin
            PaymentMethodPage.GetRecord(PaymentMethod);
            PaymentMethodCode := PaymentMethod.Code;
            exit(true);
        end else
            exit(false);
    end;

    procedure ShowPagePaymentTerms(Token: Code[20]; var PaymentTermsCode: Code[10]): Boolean
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

        if PaymentTermsPage.RunModal() = Action::LookupOK then begin
            PaymentTermsPage.GetRecord(PaymentTerms);
            PaymentTermsCode := PaymentTerms.Code;
            exit(true);
        end else
            exit(false);
    end;

    procedure GetPaymentTermsCode(CustomerNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]; var PaymentTermsCode: Code[10])
    begin
        if GetActivatedReminderExtensionSetup() then
            if GetCustomerBusinessField(CustomerNo, ShortcutDimension5CodeNVX) then
                PaymentTermsCode := CustomerBusinessField."Payment Terms Code";
    end;

    procedure GetPaymentMethodCodeCustomer(CustomerNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]; var PaymentMethodCode: Code[10])
    begin
        if GetActivatedReminderExtensionSetup() then
            if GetCustomerBusinessField(CustomerNo, ShortcutDimension5CodeNVX) then
                PaymentMethodCode := CustomerBusinessField."Payment Method Code";
    end;

    procedure GetPaymentMethodCodeVendor(VendorNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]; var PaymentMethodCode: Code[10])
    begin
        if GetActivatedReminderExtensionSetup() then
            if GetCustomerBusinessField(VendorNo, ShortcutDimension5CodeNVX) then
                PaymentMethodCode := CustomerBusinessField."Payment Method Code";
    end;

    procedure GetReminderTermsCodeCode(CustomerNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]; var ReminderTermsCode: Code[10])
    begin
        if GetActivatedReminderExtensionSetup() then
            if GetCustomerBusinessField(CustomerNo, ShortcutDimension5CodeNVX) then
                ReminderTermsCode := CustomerBusinessField."Reminder Terms Code";
    end;

    procedure GetCustomerBusinessField(CustomerNo: Code[20]; ShortcutDimension5CodeNVX: Code[20]): Boolean
    begin
        if GetActivatedReminderExtensionSetup() then
            exit(CustomerBusinessField.Get(CustomerNo, ShortcutDimension5CodeNVX));
    end;

    procedure ShowPageReminderTerms(ShortCutDimension5: Code[20]; var ReminderTermsCode: Code[10]): Boolean
    var
        ReminderTerms: Record "Reminder Terms";
        ReminderTermsPage: Page "Reminder Terms";
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        ReminderTerms.Reset();
        ReminderTerms.FilterGroup(2);
        ReminderTerms.SetRange(ShortcutDimension5CodeNVX, ShortCutDimension5);
        ReminderTerms.FilterGroup(0);

        ReminderTermsPage.SetTableView(ReminderTerms);
        ReminderTermsPage.Editable(false);
        ReminderTermsPage.LookupMode(true);

        if ReminderTermsPage.RunModal() = Action::LookupOK then begin
            ReminderTermsPage.GetRecord(ReminderTerms);
            ReminderTermsCode := ReminderTerms.Code;
            exit(true);
        end else
            exit(false);
    end;

    procedure ValidateShortcutDimCode(FieldNumber: Integer; VAR ShortcutDimCode: Code[20]; var CustLedgerEntry: Record "Cust. Ledger Entry")
    begin
        DimMgt.ValidateShortcutDimValues(FieldNumber, ShortcutDimCode, CustLedgerEntry."Dimension Set ID");
        CustLedgerEntry.Modify();

        OnAfterValidateShortcutDimCode(CustLedgerEntry, ShortcutDimCode);
    end;

    procedure GetGLSetup()
    begin
        if not RecordHasBeenRead then begin
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

            RecordHasBeenRead := true;
        end;
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
            exit(true)
        else
            exit(false);
    end;

    procedure SetCustomerPostingGroup(var Rec: Record Customer)
    var
        SalesReceivablesSetup: Record SalesReceivablesSetupNVX;
    begin
        if not GetActivatedReminderExtensionSetup() then
            exit;

        SalesReceivablesSetup.Get();
        Rec.Validate("Customer Posting Group", SalesReceivablesSetup."Customer Posting Group");
    end;

    //ToDo
    procedure ReorganizeDimensionCollectedAccount()
    var
        GenJournalLine: Record "Gen. Journal Line";
    begin
        GenJournalLine.Init();
        GenJournalLine.Insert();
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