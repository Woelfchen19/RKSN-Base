table 50047 AssignmentDepartmentNVX
{
    Caption = 'Assignment Department', comment = 'DEA="Zuordnung KST"';
    DataClassification = CustomerContent;

    fields
    {
        field(1; "Shortcut Dimension 5 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            CaptionClass = '1,2,5';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            NotBlank = true;
        }
        field(2; "Shortcut Dimension 1 Code"; Code[20])
        {
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            CaptionClass = '1,2,1';
            DataClassification = CustomerContent;
            TableRelation = "Dimension Value".Code where(
                "Global Dimension No." = const(1), AssignedToBusinessFieldNVX = const(false), "Dimension Value Type" = const(Standard));
            NotBlank = true;
        }
    }

    keys
    {
        key(PK; "Shortcut Dimension 5 Code", "Shortcut Dimension 1 Code")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
        SetAssigned(1);
    end;

    trigger OnRename()
    begin
        SetAssigned(2);
    end;

    trigger OnDelete()
    begin
        SetAssigned(3);
    end;

    local procedure SetAssigned(Status: integer)
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        GLSetup.GetRecordOnce();

        case status of
            1:
                begin
                    DimensionValue.Get(GLSetup."Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    DimensionValue.AssignedToBusinessFieldNVX := true;
                    DimensionValue.Modify();
                end;
            2:
                begin
                    DimensionValue.Get(GLSetup."Global Dimension 1 Code", xRec."Shortcut Dimension 1 Code");
                    DimensionValue.AssignedToBusinessFieldNVX := false;
                    DimensionValue.Modify();

                    DimensionValue.Get(GLSetup."Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    DimensionValue.AssignedToBusinessFieldNVX := true;
                    DimensionValue.Modify();
                end;
            3:
                begin
                    DimensionValue.Get(GLSetup."Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
                    DimensionValue.AssignedToBusinessFieldNVX := false;
                    DimensionValue.Modify();
                end;
        end;
    end;
}