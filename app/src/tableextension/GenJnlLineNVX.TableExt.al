tableextension 50014 "GenJnlLineNVX" extends "Gen. Journal Line"
{
    fields
    {
        field(50000; ShortcutDimension10CodeNVX; Code[20])
        {
            AccessByPermission = TableData "Dimension Combination" = R;
            Caption = 'Shortcut Dimension 10 Code', comment = 'DEA="ShortcutDimensionscode 10"';
            TableRelation = Dimension;

            trigger OnValidate()
            begin
                Rec.ValidateShortcutDimCode(10, ShortcutDimension10CodeNVX);
            end;
        }
        field(50001; AllocCodeNVX; Code[10])
        {
            Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
            DataClassification = CustomerContent;
        }
        field(50002; VATPostingTypeNVX; Code[10])
        {
            Caption = 'VAT Posting Type', comment = 'DEA="USt.-Buchungsart"';
            DataClassification = CustomerContent;
        }
        field(50003; AssociatedNVX; Text[10])
        {
            Caption = 'Assosiated', comment = 'DEA="Zugehörig"';
            DataClassification = CustomerContent;
            TableRelation = SetupAssociatedNVX;
        }
        field(50004; DoNotSplitNVX; Boolean)
        {
            Caption = 'Do Not Split', comment = 'DEA="Nicht aufsplitten"';
            DataClassification = CustomerContent;
        }
        field(50005; FixedGBPGNVX; Code[20])
        {
            Caption = 'FixedGBPG', comment = 'DEA="FixedGBPG"';
            DataClassification = CustomerContent;
        }
        field(50006; IsRetrospectPostingNVX; Boolean)
        {
            Caption = 'IsRetrospectPosting', comment = 'DEA="Ist eine Retrobuchung"';
            DataClassification = CustomerContent;
        }

        //ToDo
        /// <summary>
        /// Use New Function CheckPermission in OnValidate trigger 
        /// </summary>
        field(50007; ApplyDocumentNoNVX; Code[20])
        {
            Caption = 'Apply Document No.', comment = 'DEA="Ausziff.Beleg"';
            DataClassification = ToBeClassified;
            TableRelation = "Cust. Ledger Entry";
            ValidateTableRelation = false;

            trigger OnValidate()
            var
                UserSetup: Record "User Setup";
                CustLedgerEntry: Record "Cust. Ledger Entry";
                CustomerLedgerEntries: Page "Customer Ledger Entries";
                DocumentNo: Code[20];
                NotAllowedErr: Label 'You have no permission for this Ledger entry!',
                    comment = 'DEA="Sie sind zum gefundenen offenen Posten nicht berechtigt. Der offene Posten kann nicht angezeigt werden!"';
            begin
                //CheckPermission();
                //Assignfields
                if Rec.ApplyDocumentNoNVX <> '' then begin
                    UserSetup.Get(UserId);
                    CustLedgerEntry.SetCurrentKey("Document No.");
                    CustLedgerEntry.SetRange("Document No.", Rec.ApplyDocumentNoNVX);
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
                            Error(NotAllowedErr);

                        Rec."Account Type" := Rec."Account Type"::Customer;
                        Rec."Account No." := CustLedgerEntry."Customer No.";
                    end;
                end;
            end;
        }
    }

    keys
    {
        key(Key20; AssociatedNVX)
        {
        }
    }

    // local procedure CheckPermission()
    // begin

    // end;

    procedure SetBusinessFieldNVX()
    var
        AssosiatedDepartment: Record AssosiatedDepartmentNVX;
    begin
        AssosiatedDepartment.Reset();
        AssosiatedDepartment.SetRange("Shortcut Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        if AssosiatedDepartment.FindFirst() then
            Rec.ValidateShortcutDimCode(5, AssosiatedDepartment."Shortcut Dimension 5 Code");
    end;

    procedure SetAssociatedNVX()
    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
    begin
        if Rec."Shortcut Dimension 1 Code" = '' then
            exit;

        GLSetup.Get();
        DimensionValue.Get(GLSetup."Global Dimension 1 Code", Rec."Shortcut Dimension 1 Code");
        Rec.AssociatedNVX := Dimensionvalue.AssociatedNVX;
        Rec.Modify();
    end;

}