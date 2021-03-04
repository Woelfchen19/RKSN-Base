page 50023 FAJnlLineArchiveCompleteNVX
{
    Caption = 'FA Journal Line Archive', comment = 'DEA="Anlagen Buch.-Blattzeilenarchiv"';
    PageType = ListPart;
    SourceTable = FAJnlLineArchiveNVX;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Posting GUID"; "Posting GUID")
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Journal Template Name"; "Journal Template Name")
                {
                }
                field("Journal Batch Name"; "Journal Batch Name")
                {
                }
                field("Line No."; "Line No.")
                {
                }
                field("Depreciation Book Code"; "Depreciation Book Code")
                {
                }
                field("FA Posting Type"; "FA Posting Type")
                {
                }
                field("FA No."; "FA No.")
                {
                }
                field("FA Posting Date"; "FA Posting Date")
                {
                }
                field("Posting Date"; "Posting Date")
                {
                }
                field("Document Type"; "Document Type")
                {
                }
                field("Document Date"; "Document Date")
                {
                }
                field("Document No."; "Document No.")
                {
                }
                field("External Document No."; "External Document No.")
                {
                }
                field(Description; Description)
                {
                }
                field(Amount; Amount)
                {
                }
                field("Debit Amount"; "Debit Amount")
                {
                }
                field("Credit Amount"; "Credit Amount")
                {
                }
                field("Salvage Value"; "Salvage Value")
                {
                }
                field(Quantity; Quantity)
                {
                }
                field(Correction; Correction)
                {
                }
                field("No. of Depreciation Days"; "No. of Depreciation Days")
                {
                }
                field("Depr. until FA Posting Date"; "Depr. until FA Posting Date")
                {
                }
                field("Depr. Acquisition Cost"; "Depr. Acquisition Cost")
                {
                }
                field("FA Posting Group"; "FA Posting Group")
                {
                }
                field("Maintenance Code"; "Maintenance Code")
                {
                }
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 3 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 4 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 5 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 6 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Shortcut Dimension 7 Code"; "Shortcut Dimension 1 Code")
                {
                }
                field("Shortcut Dimension 8 Code"; "Shortcut Dimension 2 Code")
                {
                }
                field("Insurance No."; "Insurance No.")
                {
                }
                field("Budgeted FA No."; "Budgeted FA No.")
                {
                }
                field("Use Duplication List"; "Use Duplication List")
                {
                }
                field("Duplicate in Depreciation Book"; "Duplicate in Depreciation Book")
                {
                }
                field("FA Reclassification Entry"; "FA Reclassification Entry")
                {
                }
                field("FA Error Entry No."; "FA Error Entry No.")
                {
                }
                field("Reason Code"; "Reason Code")
                {
                }
                field("Source Code"; "Source Code")
                {
                }
                field("Recurring Method"; "Recurring Method")
                {
                }
                field("Recurring Frequency"; "Recurring Frequency")
                {
                }
                field("Expiration Date"; "Expiration Date")
                {
                }
                field("Index Entry"; "Index Entry")
                {
                }
                field("Posting No. Series"; "Posting No. Series")
                {
                }
                field("Dimension Set ID"; "Dimension Set ID")
                {
                }
                field("VAT Posting Type NVX"; "VAT Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Allocation Code NVX"; "Allocation Code")
                {
                    ApplicationArea = All;
                    Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                }
                field("Allocation %"; "Allocation %")
                {
                    ApplicationArea = All;
                    Caption = 'Percentage', comment = 'DEA="%-Anteil"';
                }
                field("Start Date"; "Start Date")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
    }
}

