page 50029 PurchLineArchiveNVX
{
    
    ApplicationArea = All;
    Caption = 'Purchase Line Archive', comment = 'DEA="Einkaufszeilenarchiv"';
    PageType = List;
    SourceTable = PurchLineArchiveNVX;
    UsageCategory = History;
    
    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Posting GUID"; "Posting GUID")
                {
                    ApplicationArea = All;
                }
                field("Posting Type"; "Posting Type")
                {
                    ApplicationArea = All;
                }
                field("A. Rcd. Not Inv. Ex. VAT (LCY)"; Rec."A. Rcd. Not Inv. Ex. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Allow Invoice Disc."; Rec."Allow Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Allow Item Charge Assignment"; Rec."Allow Item Charge Assignment")
                {
                    ApplicationArea = All;
                }
                field("Amount Including VAT"; Rec."Amount Including VAT")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced (LCY)"; Rec."Amt. Rcd. Not Invoiced (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Amt. Rcd. Not Invoiced"; Rec."Amt. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Appl.-to Item Entry"; Rec."Appl.-to Item Entry")
                {
                    ApplicationArea = All;
                }
                field("Area"; Rec.Area)
                {
                    ApplicationArea = All;
                }
                field("Attached to Line No."; Rec."Attached to Line No.")
                {
                    ApplicationArea = All;
                }
                field("Bin Code"; Rec."Bin Code")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order Line No."; Rec."Blanket Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Blanket Order No."; Rec."Blanket Order No.")
                {
                    ApplicationArea = All;
                }
                field("Budgeted FA No."; Rec."Budgeted FA No.")
                {
                    ApplicationArea = All;
                }
                field("Buy-from Vendor No."; Rec."Buy-from Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Completely Received"; Rec."Completely Received")
                {
                    ApplicationArea = All;
                }
                field("Copied From Posted Doc."; Rec."Copied From Posted Doc.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference No."; Rec."Cross-Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type No."; Rec."Cross-Reference Type No.")
                {
                    ApplicationArea = All;
                }
                field("Cross-Reference Type"; Rec."Cross-Reference Type")
                {
                    ApplicationArea = All;
                }
                field("Currency Code"; Rec."Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Deferral Code"; Rec."Deferral Code")
                {
                    ApplicationArea = All;
                }
                field("Depr. Acquisition Cost"; Rec."Depr. Acquisition Cost")
                {
                    ApplicationArea = All;
                }
                field("Depr. until FA Posting Date"; Rec."Depr. until FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Depreciation Book Code"; Rec."Depreciation Book Code")
                {
                    ApplicationArea = All;
                }
                field("Description 2"; Rec."Description 2")
                {
                    ApplicationArea = All;
                }
                field("Dimension Set ID"; Rec."Dimension Set ID")
                {
                    ApplicationArea = All;
                }
                field("Direct Unit Cost"; Rec."Direct Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = All;
                }
                field("Document Type"; Rec."Document Type")
                {
                    ApplicationArea = All;
                }
                field("Drop Shipment"; Rec."Drop Shipment")
                {
                    ApplicationArea = All;
                }
                field("Duplicate in Depreciation Book"; Rec."Duplicate in Depreciation Book")
                {
                    ApplicationArea = All;
                }
                field("Entry Point"; Rec."Entry Point")
                {
                    ApplicationArea = All;
                }
                field("Expected Receipt Date"; Rec."Expected Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Date"; Rec."FA Posting Date")
                {
                    ApplicationArea = All;
                }
                field("FA Posting Type"; Rec."FA Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Gen. Bus. Posting Group"; Rec."Gen. Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Gross Weight"; Rec."Gross Weight")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Code"; Rec."IC Partner Code")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Ref. Type"; Rec."IC Partner Ref. Type")
                {
                    ApplicationArea = All;
                }
                field("IC Partner Reference"; Rec."IC Partner Reference")
                {
                    ApplicationArea = All;
                }
                field("Inbound Whse. Handling Time"; Rec."Inbound Whse. Handling Time")
                {
                    ApplicationArea = All;
                }
                field("Indirect Cost %"; Rec."Indirect Cost %")
                {
                    ApplicationArea = All;
                }
                field("Insurance No."; Rec."Insurance No.")
                {
                    ApplicationArea = All;
                }
                field("Inv. Disc. Amount to Invoice"; Rec."Inv. Disc. Amount to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Inv. Discount Amount"; Rec."Inv. Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Item Category Code"; Rec."Item Category Code")
                {
                    ApplicationArea = All;
                }
                field("Job Currency Code"; Rec."Job Currency Code")
                {
                    ApplicationArea = All;
                }
                field("Job Currency Factor"; Rec."Job Currency Factor")
                {
                    ApplicationArea = All;
                }
                field("Job Line Amount (LCY)"; Rec."Job Line Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Line Amount"; Rec."Job Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Job Line Disc. Amount (LCY)"; Rec."Job Line Disc. Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Line Discount %"; Rec."Job Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Job Line Discount Amount"; Rec."Job Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Job Line Type"; Rec."Job Line Type")
                {
                    ApplicationArea = All;
                }
                field("Job No."; Rec."Job No.")
                {
                    ApplicationArea = All;
                }
                field("Job Planning Line No."; Rec."Job Planning Line No.")
                {
                    ApplicationArea = All;
                }
                field("Job Remaining Qty. (Base)"; Rec."Job Remaining Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Job Remaining Qty."; Rec."Job Remaining Qty.")
                {
                    ApplicationArea = All;
                }
                field("Job Task No."; Rec."Job Task No.")
                {
                    ApplicationArea = All;
                }
                field("Job Total Price (LCY)"; Rec."Job Total Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Total Price"; Rec."Job Total Price")
                {
                    ApplicationArea = All;
                }
                field("Job Unit Price (LCY)"; Rec."Job Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Job Unit Price"; Rec."Job Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Lead Time Calculation"; Rec."Lead Time Calculation")
                {
                    ApplicationArea = All;
                }
                field("Line Amount"; Rec."Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = All;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = All;
                }
                field("Line No."; Rec."Line No.")
                {
                    ApplicationArea = All;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = All;
                }
                field("Maintenance Code"; Rec."Maintenance Code")
                {
                    ApplicationArea = All;
                }
                field("MPS Order"; Rec."MPS Order")
                {
                    ApplicationArea = All;
                }
                field("Net Weight"; Rec."Net Weight")
                {
                    ApplicationArea = All;
                }
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Operation No."; Rec."Operation No.")
                {
                    ApplicationArea = All;
                }
                field("Order Date"; Rec."Order Date")
                {
                    ApplicationArea = All;
                }
                field("Order Line No."; Rec."Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Order No."; Rec."Order No.")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount (LCY)"; Rec."Outstanding Amount (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amount"; Rec."Outstanding Amount")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Amt. Ex. VAT (LCY)"; Rec."Outstanding Amt. Ex. VAT (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Qty. (Base)"; Rec."Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Outstanding Quantity"; Rec."Outstanding Quantity")
                {
                    ApplicationArea = All;
                }
                field("Overhead Rate"; Rec."Overhead Rate")
                {
                    ApplicationArea = All;
                }
                field("Pay-to Vendor No."; Rec."Pay-to Vendor No.")
                {
                    ApplicationArea = All;
                }
                field("Planned Receipt Date"; Rec."Planned Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Planning Flexibility"; Rec."Planning Flexibility")
                {
                    ApplicationArea = All;
                }
                field("Posting Group"; Rec."Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Prepayment %"; Rec."Prepayment %")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Amount"; Rec."Prepayment Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Line"; Rec."Prepayment Line")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Area Code"; Rec."Prepayment Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Group Code"; Rec."Prepayment Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Prepayment Tax Liable"; Rec."Prepayment Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT %"; Rec."Prepayment VAT %")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Difference"; Rec."Prepayment VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("Prepayment VAT Identifier"; Rec."Prepayment VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt Deducted"; Rec."Prepmt Amt Deducted")
                {
                    ApplicationArea = All;
                }
                field("Prepmt Amt to Deduct"; Rec."Prepmt Amt to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. Deducted"; Rec."Prepmt VAT Diff. Deducted")
                {
                    ApplicationArea = All;
                }
                field("Prepmt VAT Diff. to Deduct"; Rec."Prepmt VAT Diff. to Deduct")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. (LCY)"; Rec."Prepmt. Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amount Inv. Incl. VAT"; Rec."Prepmt. Amount Inv. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Incl. VAT"; Rec."Prepmt. Amt. Incl. VAT")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Amt. Inv."; Rec."Prepmt. Amt. Inv.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. Line Amount"; Rec."Prepmt. Line Amount")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Amount Inv. (LCY)"; Rec."Prepmt. VAT Amount Inv. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Base Amt."; Rec."Prepmt. VAT Base Amt.")
                {
                    ApplicationArea = All;
                }
                field("Prepmt. VAT Calc. Type"; Rec."Prepmt. VAT Calc. Type")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order Line No."; Rec."Prod. Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Prod. Order No."; Rec."Prod. Order No.")
                {
                    ApplicationArea = All;
                }
                // field("Product Group Code"; Rec."Product Group Code")
                // {
                //     ApplicationArea = All;
                // }
                field("Profit %"; Rec."Profit %")
                {
                    ApplicationArea = All;
                }
                field("Promised Receipt Date"; Rec."Promised Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Purchasing Code"; Rec."Purchasing Code")
                {
                    ApplicationArea = All;
                }
                field("Qty. Assigned"; Rec."Qty. Assigned")
                {
                    ApplicationArea = All;
                }
                field("Qty. Invoiced (Base)"; Rec."Qty. Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. per Unit of Measure"; Rec."Qty. per Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced (Base)"; Rec."Qty. Rcd. Not Invoiced (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. Rcd. Not Invoiced"; Rec."Qty. Rcd. Not Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Qty. Received (Base)"; Rec."Qty. Received (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Assign"; Rec."Qty. to Assign")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice (Base)"; Rec."Qty. to Invoice (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Invoice"; Rec."Qty. to Invoice")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive (Base)"; Rec."Qty. to Receive (Base)")
                {
                    ApplicationArea = All;
                }
                field("Qty. to Receive"; Rec."Qty. to Receive")
                {
                    ApplicationArea = All;
                }
                field("Quantity (Base)"; Rec."Quantity (Base)")
                {
                    ApplicationArea = All;
                }
                field("Quantity Invoiced"; Rec."Quantity Invoiced")
                {
                    ApplicationArea = All;
                }
                field("Quantity Received"; Rec."Quantity Received")
                {
                    ApplicationArea = All;
                }
                field("Recalculate Invoice Disc."; Rec."Recalculate Invoice Disc.")
                {
                    ApplicationArea = All;
                }
                field("Receipt Line No."; Rec."Receipt Line No.")
                {
                    ApplicationArea = All;
                }
                field("Receipt No."; Rec."Receipt No.")
                {
                    ApplicationArea = All;
                }
                field("Requested Receipt Date"; Rec."Requested Receipt Date")
                {
                    ApplicationArea = All;
                }
                field("Reserved Qty. (Base)"; Rec."Reserved Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Reserved Quantity"; Rec."Reserved Quantity")
                {
                    ApplicationArea = All;
                }
                field("Responsibility Center"; Rec."Responsibility Center")
                {
                    ApplicationArea = All;
                }
                field("Ret. Qty. Shpd Not Invd.(Base)"; Rec."Ret. Qty. Shpd Not Invd.(Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped (Base)"; Rec."Return Qty. Shipped (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped Not Invd."; Rec."Return Qty. Shipped Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. Shipped"; Rec."Return Qty. Shipped")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Ship (Base)"; Rec."Return Qty. to Ship (Base)")
                {
                    ApplicationArea = All;
                }
                field("Return Qty. to Ship"; Rec."Return Qty. to Ship")
                {
                    ApplicationArea = All;
                }
                field("Return Reason Code"; Rec."Return Reason Code")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment Line No."; Rec."Return Shipment Line No.")
                {
                    ApplicationArea = All;
                }
                field("Return Shipment No."; Rec."Return Shipment No.")
                {
                    ApplicationArea = All;
                }
                field("Return Shpd. Not Invd. (LCY)"; Rec."Return Shpd. Not Invd. (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Return Shpd. Not Invd."; Rec."Return Shpd. Not Invd.")
                {
                    ApplicationArea = All;
                }
                field("Returns Deferral Start Date"; Rec."Returns Deferral Start Date")
                {
                    ApplicationArea = All;
                }
                field("Routing No."; Rec."Routing No.")
                {
                    ApplicationArea = All;
                }
                field("Routing Reference No."; Rec."Routing Reference No.")
                {
                    ApplicationArea = All;
                }
                field("Safety Lead Time"; Rec."Safety Lead Time")
                {
                    ApplicationArea = All;
                }
                field("Sales Order Line No."; Rec."Sales Order Line No.")
                {
                    ApplicationArea = All;
                }
                field("Sales Order No."; Rec."Sales Order No.")
                {
                    ApplicationArea = All;
                }
                field("Salvage Value"; Rec."Salvage Value")
                {
                    ApplicationArea = All;
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
                field("Special Order Sales Line No."; Rec."Special Order Sales Line No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order Sales No."; Rec."Special Order Sales No.")
                {
                    ApplicationArea = All;
                }
                field("Special Order"; Rec."Special Order")
                {
                    ApplicationArea = All;
                }
                field("System-Created Entry"; Rec."System-Created Entry")
                {
                    ApplicationArea = All;
                }
                field("Tax Area Code"; Rec."Tax Area Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Group Code"; Rec."Tax Group Code")
                {
                    ApplicationArea = All;
                }
                field("Tax Liable"; Rec."Tax Liable")
                {
                    ApplicationArea = All;
                }
                field("Transaction Specification"; Rec."Transaction Specification")
                {
                    ApplicationArea = All;
                }
                field("Transaction Type"; Rec."Transaction Type")
                {
                    ApplicationArea = All;
                }
                field("Transport Method"; Rec."Transport Method")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost (LCY)"; Rec."Unit Cost (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit Cost"; Rec."Unit Cost")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure (Cross Ref.)"; Rec."Unit of Measure (Cross Ref.)")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                }
                field("Unit Price (LCY)"; Rec."Unit Price (LCY)")
                {
                    ApplicationArea = All;
                }
                field("Unit Volume"; Rec."Unit Volume")
                {
                    ApplicationArea = All;
                }
                field("Units per Parcel"; Rec."Units per Parcel")
                {
                    ApplicationArea = All;
                }
                field("Use Duplication List"; Rec."Use Duplication List")
                {
                    ApplicationArea = All;
                }
                field("Use Tax"; Rec."Use Tax")
                {
                    ApplicationArea = All;
                }
                field("Variant Code"; Rec."Variant Code")
                {
                    ApplicationArea = All;
                }
                field("VAT %"; Rec."VAT %")
                {
                    ApplicationArea = All;
                }
                field("VAT Base Amount"; Rec."VAT Base Amount")
                {
                    ApplicationArea = All;
                }
                field("VAT Bus. Posting Group"; Rec."VAT Bus. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("VAT Calculation Type"; Rec."VAT Calculation Type")
                {
                    ApplicationArea = All;
                }
                field("VAT Difference"; Rec."VAT Difference")
                {
                    ApplicationArea = All;
                }
                field("VAT Identifier"; Rec."VAT Identifier")
                {
                    ApplicationArea = All;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Vendor Item No."; Rec."Vendor Item No.")
                {
                    ApplicationArea = All;
                }
                field("Whse. Outstanding Qty. (Base)"; Rec."Whse. Outstanding Qty. (Base)")
                {
                    ApplicationArea = All;
                }
                field("Work Center No."; Rec."Work Center No.")
                {
                    ApplicationArea = All;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = All;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Finished; Rec.Finished)
                {
                    ApplicationArea = All;
                }
                field(Nonstock; Rec.Nonstock)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field(Subtype; Rec.Subtype)
                {
                    ApplicationArea = All;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = All;
                }
                field("VAT Posting Type"; "VAT Posting Type")
                {
                }
                field("Allocation Code"; "Allocation Code")
                {
                }
                field("Allocation %"; "Allocation %")
                {
                }
                field("Start Date"; "Start Date")
                {
                }
            }
        }
    }
    
}
