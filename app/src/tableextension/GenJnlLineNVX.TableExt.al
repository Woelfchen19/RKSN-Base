tableextension 50014 "GenJnlLineNVX" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; VATPostingTypeNVX; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50001; AllocCodeNVX; Code[10])
        {
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002; AllocationPercentNVX; Decimal)
        {
            Caption = 'Allocation %', comment = 'DEA="Verteilung %"';
            DataClassification = CustomerContent;
        }
        field(50003; StartDateNVX; Date)
        {
            Caption = 'Start Date', comment = 'DEA="Startdatum"';
            DataClassification = CustomerContent;
        }
        field(50004; ShortcutDimension1NameNVX; Text[50])
        {
            Caption = 'Shortcut Dimension 1 Name', comment = 'DEA="Shortcutdimensionsname 1"';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".Name where("Global Dimension No." = const(1), Code = field("Shortcut Dimension 1 Code")));
            CaptionClass = '1337,1';
        }
        field(50005; AssociatedNVX; Code[10])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            TableRelation = SetupAssociatedNVX;
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = lookup("Dimension Value".AssociatedNVX where("Global Dimension No." = const(2), Code = field("Shortcut Dimension 2 Code")));
        }
        field(50006; ShortcutDimension3CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
            CaptionClass = '1,2,3';
        }
        field(50007; FixedGBPGNVX; Code[20])
        {
            Caption = 'FixedGBPG', comment = 'DEA="FixedGBPG"';
            DataClassification = CustomerContent;
        }
        field(50008; ShortcutDimension4CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 4 Code', comment = 'DEA="Shortcutdimensionscode 4"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(4));
            CaptionClass = '1,2,4';
        }
        field(50009; ApplyDocumentNoNVX; Code[20])
        {
            Caption = 'Apply Document No.', comment = 'DEA="Ausziff.Beleg"';
            DataClassification = ToBeClassified;
            TableRelation = "Cust. Ledger Entry";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                CustLedgerEntry: Record "Cust. Ledger Entry";
                UserSetup: Record "User Setup";
                CustomerLedgerEntries: Page "Customer Ledger Entries";
                DocumentNo: Code[20];
            // NotAllowedErr: Label 'You have no permission for this Ledger entry!',
            //     comment = 'DEA="Sie sind zum gefundenen offenen Posten nicht berechtigt. Der offene Posten kann nicht angezeigt werden!"';
            begin
                //Assignfields
                if Rec.ApplyDocumentNoNVX <> '' then begin
                    ValidateCustLedgerEntryFilter(CustLedgerEntry);
                    CustomerLedgerEntries.LookupMode(true);
                    CustomerLedgerEntries.SetTableView(CustLedgerEntry);
                    if CustomerLedgerEntries.RunModal() = action::LookupOK then begin
                        CustomerLedgerEntries.GetRecord(CustLedgerEntry);
                        DocumentNo := CustLedgerEntry."Document No.";
                        CustLedgerEntry.Reset();
                        CustLedgerEntry.SetCurrentKey("Document No.");
                        CustLedgerEntry.SetRange("Document No.", DocumentNo);
                        CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
                        if CustLedgerEntry.IsEmpty then
                            Error(ReminderManagement.GetPermissionErrorLbl());

                        Rec."Account Type" := Rec."Account Type"::Customer;
                        Rec."Account No." := CustLedgerEntry."Customer No.";
                    end;
                end;
            end;
        }
        field(50010; ShortcutDimension5CodeNVX; Code[20])
        {
            Caption = 'Shortcut Dimension 5 Code', comment = 'DEA="Shortcutdimensionscode 5"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(5));
            CaptionClass = '1,2,5';
        }
        field(50011; GenBusPostingGroupDescNVX; Text[100])
        {
            Caption = 'Gen. Bus. Posting Group Description', comment = 'DEA="Geschäftsbuchungsgruppe Beschreibung"';
            FieldClass = FlowField;
            Editable = false;
            CalcFormula = lookup("Gen. Business Posting Group".Description where(Code = field("Gen. Bus. Posting Group")));
        }
        field(50012; ShortcutDimension6CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 6 Code', comment = 'DEA="Shortcutdimensionscode 6"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(6));
            CaptionClass = '1,2,6';
        }
        field(50013; DoNotSplitNVX; Boolean)
        {
            Caption = 'Do Not Split', comment = 'DEA="Nicht aufsplitten"';
            DataClassification = CustomerContent;
        }

        field(50014; ShortcutDimension7CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 7 Code', comment = 'DEA="Shortcutdimensionscode 7"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(7));
            CaptionClass = '1,2,7';
        }
        field(50015; IsRetrospectPostingNVX; Boolean)
        {
            Caption = 'IsRetrospectPosting', comment = 'DEA="Ist eine Retrobuchung"';
            DataClassification = CustomerContent;
        }
        field(50016; ShortcutDimension8CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 8 Code', comment = 'DEA="Shortcutdimensionscode 8"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(8));
            CaptionClass = '1,2,8';
        }
        field(50017; ShortcutDimension9CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 9 Code', comment = 'DEA="Shortcutdimensionscode 9"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(9));
            CaptionClass = '1,2,9';
        }
        field(50018; ShortcutDimension10CodeNVX; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="Shortcutdimensionscode 10"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(10));
            CaptionClass = '1,2,10';

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(10, ShortcutDimension10CodeNVX);
            end;
        }
        field(50020; SalesTransactionNoNVX; Integer)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Transaction No.', comment = 'DEA="VERKAUF Transaktionsnummer"';
        }
        field(50021; SalesSourceEntryNVX; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Source Entry', comment = 'DEA="QUELLPOSTEN Modul Verkauf"';
        }
        field(50022; SalesRetrospectEntryNVX; Boolean)
        {
            DataClassification = CustomerContent;
            Caption = 'Sales Restrospect Entry', comment = 'DEA="NACHGELAGERT Modul Verkauf"';
        }
    }
    procedure SetBusinessFieldNVX()
    var
        AssosiatedDepartment: Record AssignmentDepartmentNVX;
    begin
        AssosiatedDepartment.Reset();
        AssosiatedDepartment.SetRange("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if AssosiatedDepartment.FindFirst() then
            Rec.ValidateShortcutDimCode(5, AssosiatedDepartment."Shortcut Dimension 5 Code");
    end;

    local procedure ValidateCustLedgerEntryFilter(var CustLedgerEntry: Record "Cust. Ledger Entry")
    var
        UserSetup: Record "User Setup";
        DocumentNoNotFoundErr: Label 'Documentno. not found!', comment = 'DEA="Belegnummer nicht gefunden!"';
        NotAllowedErr: Label 'You have no permission for this Ledger entry!',
                    comment = 'DEA="Sie sind zum gefundenen offenen Posten nicht berechtigt. Der offene Posten kann nicht angezeigt werden!"';
    begin
        UserSetup.Get(UserId);
        CustLedgerEntry.SetCurrentKey("Document No.");
        CustLedgerEntry.SetRange("Document No.", Rec.ApplyDocumentNoNVX);
        if CustLedgerEntry.IsEmpty then
            Error(DocumentNoNotFoundErr);
        CustLedgerEntry.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
        if CustLedgerEntry.IsEmpty then
            Error(NotAllowedErr);
    end;

    var
        ReminderManagement: Codeunit ReminderManagementNVX;
}