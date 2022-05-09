table 50015 "FixedAssetNVX"
{
    fields
    {
        field(1; "No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(10; "Allocation Code"; Code[10])
        {
            DataClassification = CustomerContent;
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            TableRelation = AllocationCodeNVX.Code;
        }
    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
    }

    procedure GetDefinition(No: Code[20])
    begin
        if No = "No." then
            exit;
        if Get(No) then
            exit;

        Init();
        "No." := No;
        Insert();
    end;
}