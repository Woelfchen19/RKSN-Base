codeunit 50030 "ChangeLogMgtDimensionNVX"
{
    Permissions = TableData ChangeLogEntryDimensionNVX = r;
    SingleInstance = true;

    trigger OnRun()
    begin
    end;

    var
        SetupReminderExtension: Record SetupReminderExtensionNVX;
        ChangeLogSetupRead: Boolean;


    local procedure IsLogActive(): Boolean
    begin
        if not ChangeLogSetupRead then begin
            if SetupReminderExtension.Get() then begin
                ChangeLogSetupRead := true;
                exit(SetupReminderExtension.AcitveChangeLogEntryDim);
            end;
        end else
            exit(false);
    end;

    local procedure InsertLogEntry(var FldRef: FieldRef; var xFldRef: FieldRef; var RecRef: RecordRef; TypeOfChange: Option Insertion,Modification,Deletion; IsReadable: Boolean)
    var
        ChangeLogEntryDimension: Record ChangeLogEntryDimensionNVX;
        KeyFldRef: FieldRef;
        KeyRef1: KeyRef;
        i: Integer;
    begin
        if RecRef.CurrentCompany <> ChangeLogEntryDimension.CurrentCompany then
            ChangeLogEntryDimension.ChangeCompany(RecRef.CurrentCompany);
        ChangeLogEntryDimension.Init();
        ChangeLogEntryDimension."Date and Time" := CurrentDateTime;
        ChangeLogEntryDimension.Time := DT2Time(ChangeLogEntryDimension."Date and Time");

        ChangeLogEntryDimension."User ID" := CopyStr(UserId, 1, 50);

        ChangeLogEntryDimension."Table No." := RecRef.Number;
        ChangeLogEntryDimension."Field No." := FldRef.Number;
        ChangeLogEntryDimension."Type of Change" := TypeOfChange;
        if (RecRef.Number = DATABASE::"User Property") and (FldRef.Number in [2 .. 5]) then begin // Password like
            ChangeLogEntryDimension."Old Value" := '*';
            ChangeLogEntryDimension."New Value" := '*';
        end else begin
            if TypeOfChange <> TypeOfChange::Insertion then
                if IsReadable then
                    ChangeLogEntryDimension."Old Value" := Format(xFldRef.Value, 0, 9)
                else
                    ChangeLogEntryDimension."Old Value" := '';
            if TypeOfChange <> TypeOfChange::Deletion then
                ChangeLogEntryDimension."New Value" := Format(FldRef.Value, 0, 9);
        end;

        ChangeLogEntryDimension."Record ID" := RecRef.RecordId;
        ChangeLogEntryDimension."Primary Key" := CopyStr(RecRef.GetPosition(false), 1, MaxStrLen(ChangeLogEntryDimension."Primary Key"));

        KeyRef1 := RecRef.KeyIndex(1);
        for i := 1 to KeyRef1.FieldCount do begin
            KeyFldRef := KeyRef1.FieldIndex(i);

            case i of
                1:
                    begin
                        ChangeLogEntryDimension."Primary Key Field 1 No." := KeyFldRef.Number;
                        ChangeLogEntryDimension."Primary Key Field 1 Value" :=
                          CopyStr(Format(KeyFldRef.Value, 0, 9), 1, MaxStrLen(ChangeLogEntryDimension."Primary Key Field 1 Value"));
                    end;
                2:
                    begin
                        ChangeLogEntryDimension."Primary Key Field 2 No." := KeyFldRef.Number;
                        ChangeLogEntryDimension."Primary Key Field 2 Value" :=
                          CopyStr(Format(KeyFldRef.Value, 0, 9), 1, MaxStrLen(ChangeLogEntryDimension."Primary Key Field 2 Value"));
                    end;
                3:
                    begin
                        ChangeLogEntryDimension."Primary Key Field 3 No." := KeyFldRef.Number;
                        ChangeLogEntryDimension."Primary Key Field 3 Value" :=
                          CopyStr(Format(KeyFldRef.Value, 0, 9), 1, MaxStrLen(ChangeLogEntryDimension."Primary Key Field 3 Value"));
                    end;
            end;
        end;
        ChangeLogEntryDimension.Insert(true);
    end;

    procedure LogModification(var RecRef: RecordRef)
    var
        xRecRef: RecordRef;
        FldRef: FieldRef;
        xFldRef: FieldRef;
        i: Integer;
        IsReadable: Boolean;
    begin
        if RecRef.IsTemporary then
            exit;

        IsLogActive();

        if RecRef.Number <> Database::"Cust. Ledger Entry" then
            exit;

        xRecRef.Open(RecRef.Number);
        xRecRef."SecurityFiltering" := SECURITYFILTER::Filtered;
        if xRecRef.ReadPermission then begin
            IsReadable := true;
            if not xRecRef.Get(RecRef.RecordId) then
                exit;
        end;

        for i := 1 to RecRef.FieldCount do begin
            FldRef := RecRef.FieldIndex(i);
            xFldRef := xRecRef.FieldIndex(i);
            if IsNormalField(FldRef) then
                if Format(FldRef.Value) <> Format(xFldRef.Value) then
                    if SetupReminderExtension.AcitveChangeLogEntryDim then
                        InsertLogEntry(FldRef, xFldRef, RecRef, 1, IsReadable);
        end;
    end;

    local procedure IsNormalField(FieldRef: FieldRef): Boolean
    begin
        exit(Format(FieldRef.Class) = 'Normal')
    end;

    procedure EvaluateTextToFieldRef(InputText: Text; var FieldRef: FieldRef): Boolean
    var
        DateFormulaVar: DateFormula;
        BigIntVar: BigInteger;
        BoolVar: Boolean;
        DateVar: Date;
        DateTimeVar: DateTime;
        DecimalVar: Decimal;
        DurationVar: Duration;
        GUIDVar: Guid;
        IntVar: Integer;
        TimeVar: Time;
    begin
        if (Format(FieldRef.Class) = 'FlowField') or (Format(FieldRef.Class) = 'FlowFilter') then
            exit(true);

        case Format(FieldRef.Type) of
            'Integer', 'Option':
                if Evaluate(IntVar, InputText) then begin
                    FieldRef.Value := IntVar;
                    exit(true);
                end;
            'Decimal':
                if Evaluate(DecimalVar, InputText, 9) then begin
                    FieldRef.Value := DecimalVar;
                    exit(true);
                end;
            'Date':
                if Evaluate(DateVar, InputText, 9) then begin
                    FieldRef.Value := DateVar;
                    exit(true);
                end;
            'Time':
                if Evaluate(TimeVar, InputText, 9) then begin
                    FieldRef.Value := TimeVar;
                    exit(true);
                end;
            'DateTime':
                if Evaluate(DateTimeVar, InputText, 9) then begin
                    FieldRef.Value := DateTimeVar;
                    exit(true);
                end;
            'Boolean':
                if Evaluate(BoolVar, InputText, 9) then begin
                    FieldRef.Value := BoolVar;
                    exit(true);
                end;
            'Duration':
                if Evaluate(DurationVar, InputText, 9) then begin
                    FieldRef.Value := DurationVar;
                    exit(true);
                end;
            'BigInteger':
                if Evaluate(BigIntVar, InputText) then begin
                    FieldRef.Value := BigIntVar;
                    exit(true);
                end;
            'GUID':
                if Evaluate(GUIDVar, InputText, 9) then begin
                    FieldRef.Value := GUIDVar;
                    exit(true);
                end;
            'Code', 'Text':
                begin
                    if StrLen(InputText) > FieldRef.Length then begin
                        FieldRef.Value := PadStr(InputText, FieldRef.Length);
                        exit(false);
                    end;
                    FieldRef.Value := InputText;
                    exit(true);
                end;
            'DateFormula':
                if Evaluate(DateFormulaVar, InputText, 9) then begin
                    FieldRef.Value := DateFormulaVar;
                    exit(true);
                end;
        end;

        exit(false);
    end;
}
