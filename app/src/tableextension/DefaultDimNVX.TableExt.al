tableextension 50000 "DefaultDimNVX" extends "Default Dimension"
{
    procedure GetDefaultDimNVX(Type: Integer; No: Code[20]; DimNo: Integer): Code[20];
    var
        GLSetup: Record "General Ledger Setup";
    begin
        Reset();
        GLSetup.Get();
        case Type of
            1:
                SetRange("Table ID", Database::"G/L Account");
            2:
                SetRange("Table ID", Database::Item)
            else
                exit('');

        end;//of case

        SetRange("No.", No);

        case DimNo of
            1:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
            2:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
            3:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
            4:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
            5:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 5 Code");
            6:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 6 Code");
            7:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 7 Code");
            8:
                SetRange("Dimension Code", GLSetup."Shortcut Dimension 8 Code");
            9:
                SetRange("Dimension Code", GLSetup.ShortcutDimension9CodeNVX);
            10:
                SetRange("Dimension Code", GLSetup.ShortcutDimension10CodeNVX);
        end; //of case

        if not FindFirst() then
            Init();

        exit("Dimension Value Code");
    end;
}