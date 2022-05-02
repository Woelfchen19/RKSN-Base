codeunit 50025 DimensionValueHookNVX
{
    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterInsertEvent', '', true, true)]
    local procedure OnAfterInsertEvent(var Rec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        Rec."Global Dimension No." := GetGlobalDimensionNo(Rec."Dimension Code");
        Rec.Modify();
    end;

    [EventSubscriber(ObjectType::Table, Database::"Dimension Value", 'OnAfterModifyEvent', '', true, true)]
    local procedure OnAfterModifyEvent(var Rec: Record "Dimension Value"; var xRec: Record "Dimension Value"; RunTrigger: Boolean)
    begin
        Rec."Global Dimension No." := GetGlobalDimensionNo(Rec."Dimension Code");
    end;

    local procedure GetGlobalDimensionNo(DimensionCode: Code[20]): Integer
    var
        GeneralLedgerSetup: Record "General Ledger Setup";
    begin
        GeneralLedgerSetup.Get();
        case DimensionCode of
            GeneralLedgerSetup."Global Dimension 1 Code":
                exit(1);
            GeneralLedgerSetup."Global Dimension 2 Code":
                exit(2);
            GeneralLedgerSetup."Shortcut Dimension 3 Code":
                exit(3);
            GeneralLedgerSetup."Shortcut Dimension 4 Code":
                exit(4);
            GeneralLedgerSetup."Shortcut Dimension 5 Code":
                exit(5);
            GeneralLedgerSetup."Shortcut Dimension 6 Code":
                exit(6);
            GeneralLedgerSetup."Shortcut Dimension 7 Code":
                exit(7);
            GeneralLedgerSetup."Shortcut Dimension 8 Code":
                exit(8);
            GeneralLedgerSetup.ShortcutDimension9CodeNVX:
                exit(9);
            GeneralLedgerSetup.ShortcutDimension10CodeNVX:
                exit(10);
            else
                exit(0);
        end;
    end;
}