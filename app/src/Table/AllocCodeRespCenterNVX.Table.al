table 50003 AllocCodeRespCenterNVX
{
    DataClassification = CustomerContent;
    DrillDownPageId = AllocCodeRespCenterNVX;
    LookupPageId = AllocCodeRespCenterNVX;

    fields
    {
        field(1; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX;
        }
        field(2; "Allocation Code Description"; Text[50])
        {
            Caption = 'Allocation Code Description', comment = 'DEA="Verteilungscodebeschreibung"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup(AllocationCodeNVX.Description where(Code = field("Allocation Code")));
        }
        field(5; "Resp. Center"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Responsibility Center', comment = 'DEA="Zuständigkeitseinheitencode"';
            TableRelation = "Responsibility Center";
        }
    }

    keys
    {
        key(PK; "Allocation Code", "Resp. Center")
        {
            Clustered = true;
        }
    }

    procedure InsertResponsibilityCenter();
    var
        RespCenter: Record "Responsibility Center";
        RespCenterList: Page "Responsibility Center List";
    begin
        RespCenterList.LookupMode(true);
        if RespCenterList.RunModal() = "Action"::LookupOK then begin
            RespCenterList.SetSelectionFilter(RespCenter);
            if RespCenter.FindSet() then
                repeat
                    if not Get("Allocation Code", RespCenter.Code) then begin
                        Init();
                        "Allocation Code" := "Allocation Code";
                        "Resp. Center" := RespCenter.Code;
                        Insert();
                    end;
                until RespCenter.Next() = 0;
        end;
    end;
}