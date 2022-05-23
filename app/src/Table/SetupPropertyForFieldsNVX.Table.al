table 50044 "SetupPropertyForFieldsNVX"
{
    Caption = 'Setup Property for Fields', comment = 'DEA="Einrichtung Eigenschaften Felder"';
    DataClassification = SystemMetadata;
    fields
    {
        field(1; "Object Type"; Option)
        {
            Caption = 'Object Type';
            DataClassification = SystemMetadata;
            InitValue = 8;
            OptionCaption = 'Table Data,Table,,Report,,Codeunit,XMLport,MenuSuite,Page,Query,System';
            OptionMembers = "Table Data","Table",,"Report",,"Codeunit","XMLport",MenuSuite,"Page","Query",System;
        }
        field(2; "Object ID"; Integer)
        {
            Caption = 'Object ID';
            DataClassification = SystemMetadata;
            TableRelation = IF ("Object Type" = CONST("Table Data")) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Table)) AllObj."Object ID" WHERE("Object Type" = CONST(Table))
            ELSE
            IF ("Object Type" = CONST(Report)) AllObj."Object ID" WHERE("Object Type" = CONST(Report))
            ELSE
            IF ("Object Type" = CONST(Codeunit)) AllObj."Object ID" WHERE("Object Type" = CONST(Codeunit))
            ELSE
            IF ("Object Type" = CONST(XMLport)) AllObj."Object ID" WHERE("Object Type" = CONST(XMLport))
            ELSE
            IF ("Object Type" = CONST(MenuSuite)) AllObj."Object ID" WHERE("Object Type" = CONST(MenuSuite))
            ELSE
            IF ("Object Type" = CONST(Page)) AllObj."Object ID" WHERE("Object Type" = CONST(Page))
            ELSE
            IF ("Object Type" = CONST(Query)) AllObj."Object ID" WHERE("Object Type" = CONST(Query))
            ELSE
            IF ("Object Type" = CONST(System)) AllObj."Object ID" WHERE("Object Type" = CONST(System));
        }
        field(3; Dimension; Code[20])
        {
            Caption = 'Dimension', comment = 'DEA="Dimension"';
            TableRelation = Dimension;
        }
        field(4; "Object Name"; Text[30])
        {
            CalcFormula = Lookup(AllObjWithCaption."Object Name" WHERE("Object Type" = FIELD("Object Type"),
                                                                        "Object ID" = FIELD("Object ID")));
            Caption = 'Object Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(5; IsVisible; Boolean)
        {
            Caption = 'Visible', comment = 'DEA="Visible"';
        }
        field(6; IsEditable; Boolean)
        {
            Caption = 'Editable', comment = 'DEA="EditAble"';
        }
    }

    keys
    {
        key(Key1; "Object Type", "Object ID", Dimension)
        {
            Clustered = true;
        }
    }
}