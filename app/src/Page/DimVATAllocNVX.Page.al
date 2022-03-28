page 50005 DimVATAllocNVX
{

    ApplicationArea = All;
    Caption = 'Dim. / VAT Allocation', comment = 'DEA="Dim.USt.-Zuordnungen"';
    PageType = List;
    SourceTable = DimVATAllocNVX;
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            repeater(General)
            {
                field("VAT Posting Type NVX"; "VAT Posting Type")
                {
                    ApplicationArea = All;
                }
                field("Allocation % NVX"; "Allocation %")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 1 Code NVX"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown();
                    var
                        DimValueRec: Record "Dimension Value";
                        GLSetup: Record "General Ledger Setup";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run();
                    end;
                }
                field("Shortcut Dimension 1 Name NVX"; "Shortcut Dimension 1 Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code NVX"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown();
                    var
                        DimValueRec: Record "Dimension Value";
                        GLSetup: Record "General Ledger Setup";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run();
                    end;
                }
                field("Shortcut Dimension 2 Name NVX"; "Shortcut Dimension 2 Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 3 Code NVX"; "Shortcut Dimension 3 Code")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown();
                    var
                        DimValueRec: Record "Dimension Value";
                        GLSetup: Record "General Ledger Setup";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run();
                    end;
                }
                field("Shortcut Dimension 3 Name NVX"; "Shortcut Dimension 3 Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 4 Code NVX"; "Shortcut Dimension 4 Code")
                {
                    ApplicationArea = All;
                    trigger OnDrillDown();
                    var
                        DimValueRec: Record "Dimension Value";
                        GLSetup: Record "General Ledger Setup";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run();
                    end;
                }
                field("Shortcut Dimension 4 Name NVX"; "Shortcut Dimension 4 Name")
                {
                    ApplicationArea = All;
                }
                field("Start Date NVX"; "Start Date")
                {
                    ApplicationArea = All;
                }

            }
        }
    }

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        DimVATAlloc: Record DimVATAllocNVX;
        DimVATAlloc2: Record DimVATAllocNVX;
        PercentageIncompleteErr: Label 'Percentage distribution is not complete!', comment = 'DEA="Die %-Verteilung ist noch nicht vollständig abgeschlossen!"';
    begin

        DimVATAlloc.Reset();
        if DimVATAlloc.FindSet() then
            repeat
                DimVATAlloc2.SetRange("Shortcut Dimension 1 Code", DimVATAlloc."Shortcut Dimension 1 Code");
                DimVATAlloc2.SetRange("Shortcut Dimension 2 Code", DimVATAlloc."Shortcut Dimension 2 Code");
                DimVATAlloc2.SetRange("Start Date", DimVATAlloc."Start Date");
                DimVATAlloc2.CalcSums("Allocation %");
                if DimVATAlloc2."Allocation %" <> 100 then
                    Error(PercentageIncompleteErr);
            until DimVATAlloc.Next() = 0;

        exit(true);
    end;
}