page 50002 DimVATAllocNVX
{

    ApplicationArea = All;
    Caption = 'Dim. / VAT Allocation', comment = 'DEA="Dim.USt.-Zuordnungen"';
    PageType = List;
    SourceTable = DimVATAllocNVX;
    UsageCategory = Administration;

    layout
    {
        area(content)
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
                        GLSetup: Record "General Ledger Setup";
                        DimValueRec: Record "Dimension Value";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 1 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run;
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
                        GLSetup: Record "General Ledger Setup";
                        DimValueRec: Record "Dimension Value";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 2 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run;
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
                        GLSetup: Record "General Ledger Setup";
                        DimValueRec: Record "Dimension Value";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 3 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run;
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
                        GLSetup: Record "General Ledger Setup";
                        DimValueRec: Record "Dimension Value";
                        DimValuesPage: Page "Dimension Values";
                    begin
                        GLSetup.Get();
                        DimValueRec.SetRange("Dimension Code", GLSetup."Shortcut Dimension 4 Code");
                        DimValuesPage.SetRecord(DimValueRec);
                        DimValuesPage.SetTableView(DimValueRec);
                        DimValuesPage.Run;
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
        AllFieldsFilled: Boolean;
        PercentSum: Decimal;
        SetupIncomplete: Label 'Setup is incomplete', comment = 'DEA="Die Einrichtung ist nicht vollständig!"';
        PercentageIncomplete: Label 'Percentage distribution is not complete!', comment = 'DEA="Die %-Verteilung ist noch nicht vollständig abgeschlossen!"';
    begin

        AllFieldsFilled := true;

        DimVATAlloc.Reset();
        IF DimVATAlloc.FindSet() then
            repeat
                case true of
                    "Shortcut Dimension 1 Code" = '' :
                        AllFieldsFilled := false;
            "Shortcut Dimension 2 Code" = '' :
                        AllFieldsFilled := false;
            "Shortcut Dimension 3 Code" = '' :
                        AllFieldsFilled := false;
            "VAT Posting Type" = '' :
                        AllFieldsFilled := false;
            "Start Date" = 0D :
                        AllFieldsFilled := false;
            end;//of case

            until DimVATAlloc.next = 0;

        If not AllFieldsFilled then
            Error(SetupIncomplete);

        // If PercentSum <> 100 then //TODO RKSN-42 WorkItem 5348
        //     Error(PercentageIncomplete);

        exit(true);
    end;

}
