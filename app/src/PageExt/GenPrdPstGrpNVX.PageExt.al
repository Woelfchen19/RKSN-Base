pageextension 50000 "GenPrdPstGrpNVX" extends "Gen. Product Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field(InventoryValueZeroNVX; GenPrdPstGrp."Inventory Value Zero")
            //RKSN-36
            {
                ApplicationArea = All;
                Caption = 'Inventory Value Zero', comment = 'DEA="Ohne Lagerbewertung"';
                ToolTip = 'Specifies if the product posting group must be excluded from inventory valuation.', comment = 'DEA="Gibt an ob die Produktbuchungsgruppe Lagerbewertet ist, d.h. keinen Wertefluss hat."';
                trigger OnValidate();
                begin
                    ModifyDataNVX();
                end;
            }
            field(InventoryPostingGroupNVX;GenPrdPstGrp."Inventory Posting Group NVX")
            { 
                ApplicationArea = All;
                TableRelation = "Inventory Posting Group";
                Caption = 'Inventory Posting Group', comment = 'DEA="Lagerbuchungsgruppe"';
                ToolTip = 'Specifies the default Inventory Posting Group for Items with this Gen. Product Posting Group', 
                comment = 'DEA="Gibt die Standard-Lagerbuchungsgruppe für Artikel mit dieser Produktbuchungsgruppe an"';
                trigger OnValidate();
                begin
                    ModifyDataNVX();
                end;
            }
        }
    }

    procedure ModifyDataNVX();
    begin
        GenPrdPstGrp.Validate("Inventory Posting Group NVX");
        if not GenPrdPstGrp.Modify() then
            if not GenPrdPstGrp.Get(Code) then begin
                GenPrdPstGrp.Code := Code;
                GenPrdPstGrp.Insert();
            end;
    end;
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;

    trigger OnAfterGetRecord();
    //RKSN-36
    begin
        if not GenPrdPstGrp.Get(Code) then begin
            GenPrdPstGrp.Init();
            GenPrdPstGrp.Code := Code;
            GenPrdPstGrp.Insert();
        end;
    end;

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        GenPrdPstGrp.Init();
    end;
}