page 50006 AllocationSubPageNVX
{
    Caption = 'Lines', comment = 'DEA="Zeilen"';
    PageType = ListPart;
    SourceTable = AllocationLineNVX;
    AutoSplitKey = true;
    MultipleNewLines = true;
    DelayedInsert = true;
    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Shortcut Dimension 1 Code"; "Shortcut Dimension 1 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Shortcut Dimension 1 Name"; "Shortcut Dimension 1 Name")
                {
                    ApplicationArea = All;
                }
                field("Shortcut Dimension 2 Code"; "Shortcut Dimension 2 Code")
                {
                    ApplicationArea = All;
                    trigger OnValidate();
                    begin
                        CurrPage.Update();
                    end;
                }
                field("Shortcut Dimension 2 Name"; "Shortcut Dimension 2 Name")
                {
                    ApplicationArea = All;
                }
                //TODO I don't understand this field :(
                // field("Allocation Quantity"; "Allocation Quantity")
                // {
                //     ApplicationArea = All;
                // }
                field("Allocation %"; "Allocation %")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean);
    var
        AllocationCode: Record AllocationCodeNVX;
        AllocationHeader: Record AllocationHeaderNVX;
    begin
        AllocationHeader.Get("Allocation ID");
        AllocationCode.Get(AllocationHeader."Allocation Code");
        "Shortcut Dimension 2 Code" := AllocationCode."Shortcut Dimension 2 Code";
    end;
}