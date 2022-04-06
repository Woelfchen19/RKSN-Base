table 50001 AllocationHeaderNVX
{
    DataClassification = CustomerContent;
    Caption = 'Allocation Header', comment = 'DEA="Verteilungskopf"';
    DataCaptionFields = "Allocation Code", "Start Date";
    LookupPageId = AllocationListNVX;
    DrillDownPageId = AllocationListNVX;

    fields
    {
        field(1; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
            trigger OnValidate();
            var
                AllocationCode: Record AllocationCodeNVX;
            begin
                if Description = '' then begin
                    AllocationCode.Get("Allocation Code");
                    Description := AllocationCode.Description;
                end;
            end;
        }
        field(2; "Start Date"; Date)
        {
            DataClassification = CustomerContent;
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
        }
        field(10; Description; Text[250])
        {
            DataClassification = CustomerContent;
            Caption = 'Description', comment = 'DEA="Beschreibung"';
        }
    }

    keys
    {
        key(PK; "Allocation Code", "Start Date")
        {
            Clustered = true;
        }
    }

    trigger OnDelete();
    var
        AllocationLine: Record AllocationLineNVX;
    begin
        AllocationLine.SetRange("Allocation Code", "Allocation Code");
        AllocationLine.DeleteAll();
    end;

}