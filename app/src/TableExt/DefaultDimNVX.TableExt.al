tableextension 50001 DefaultDimNVX extends "Default Dimension"
{
    procedure GetDefaultDim(Type: Integer; No: Code[20]; DimNo: Integer): Code[20];
    var
        GLSetup: Record "General Ledger Setup";
        // DefaultDim: Record "Default Dimension";
    begin
        Reset();
        GLSetup.Get();
        Case Type of
            1:
                SetRange("Table ID",Database::"G/L Account");                
            2:
                SetRange("Table ID",Database::Item)
        else
            exit('');

        end;//of case

        SetRange("No.",No);

        Case DimNo of
            1:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 1 Code");
            2:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 2 Code");
            3:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 3 Code");
            4:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 4 Code");
            5:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 5 Code");
            6:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 6 Code");
            7:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 7 Code");
            8:
                SetRange("Dimension Code",GLSetup."Shortcut Dimension 8 Code");
        end; //of case

        IF not FindFirst() then
            Init();

        exit("Dimension Value Code");
    end;
}