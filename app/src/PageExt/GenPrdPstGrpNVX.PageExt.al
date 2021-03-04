pageextension 50000 GenPrdPstGrpNVX extends "Gen. Product Posting Groups"
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
                    If not GenPrdPstGrp.Modify then;

                    If not GenPrdPstGrp.Get(Code) then begin
                        // GenPrdPstGrp.Init();
                        GenPrdPstGrp.Code := Code;
                        GenPrdPstGrp.Insert();
                    end;

                end;
            }

        }
    }

    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;


    trigger OnAfterGetRecord();
    //RKSN-36
    begin
        If not GenPrdPstGrp.Get(Code) then begin
            GenPrdPstGrp.Init();
            GenPrdPstGrp.Code := Code;
            GenPrdPstGrp.Insert();
        end;
    end;


    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        GenPrdPstGrp.Init();
    end;


    // trigger OnInsertRecord(BelowxRec : Boolean) : Boolean;
    // begin
    //     GenPrdPstGrp.Code := Code;
    //     GenPrdPstGrp.Insert();
    // end;
}