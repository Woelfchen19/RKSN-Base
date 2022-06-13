table 50048 "SetupAssociatedNVX"
{
    Caption = 'Setup Associated', comment = 'DEA="Einrichtung Zugehörigkeit"';
    DataClassification = ToBeClassified;
    LookupPageId = SetupAssociatedNVX;
    fields
    {
        field(1; "Code"; Code[10])
        {
            Caption = 'Code', comment = 'DEA="Code"';
            DataClassification = CustomerContent;
        }
        field(2; Description; Text[250])
        {
            Caption = 'Description', comment = 'DEA="Beschreibung"';
            DataClassification = CustomerContent;
        }
    }
    keys
    {
        key(Key1; Code)
        {
            Clustered = true;
        }
    }
}