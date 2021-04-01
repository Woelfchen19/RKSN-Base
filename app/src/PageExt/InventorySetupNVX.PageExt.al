pageextension 50004 InventorySetupNVX extends "Inventory Setup"
{
    layout
    {
        addlast(General)
        {
            field("Allow Neg. Inv. Stock Value NVX"; InvSetupNVX."Allow Neg. Inv. Stock Value")
            {
                ApplicationArea = All;
                Caption = 'Allow Negative Inventory for Items with Stock Value', comment = 'DEA="Zu lagerbewerteten Artikeln negative Lagerbestände zulassen"';
                //TODO ToolTip
                ToolTip = 'Allows Negative Inventory for Items with Stock Value', comment = 'DEA="Lässt negative Lagerbestände zu lagerbewerteten Artikeln zu"';
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }
            field("Allow Neg. Inv. no Stock Value NVX"; InvSetupNVX."Allow Neg. Inv. no Stock Value")
            {
                ApplicationArea = All;
                Caption = 'Allow Negative Inventory for Items without Stock Value', comment = 'DEA="Zu NICHT lagerbewerteten Artikeln negative Lagerbestände zulassen"';
                //TODO ToolTip
                ToolTip = 'Allows Negative Inventory for Items without Stock Value', comment = 'DEA="Lässt negative Lagerbestände zu nicht lagerbewerteten Artikeln zu"';
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }
            field("Inventory Section NVX"; InvSetupNVX."Inventory Section")
            {
                ApplicationArea = All;
                Caption = 'Inventory Section', comment = 'DEA="Lager Sparte"';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
                //TODO ToolTip
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;                
            }
            field("Inventory Cost Center NVX"; InvSetupNVX."Inventory Cost Center")
            {
                ApplicationArea = All;
                Caption = 'Inventory Cost Center', comment = 'DEA="Lager KSt."';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(1));
                //TODO Tooltip
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;                
            }
            field("Purchase Gen. Bus. Posting Group Fixed";InvSetupNVX."Purchase Gen. Bus. Posting Group Fixed")
            {
                ApplicationArea = All;
                Caption = 'Purchase Gen. Bus. Posting Group Fixed', comment = 'DEA="Zukauf Steuerschlüssel FIX"';
                TableRelation = "Gen. Business Posting Group".Code;
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;           
            }                     
        }        
    }
    
    var
        InvSetupNVX : Record InvSetupNVX;    
    
    trigger OnAfterGetRecord();
    begin
        InvSetupNVX.Reset();
        If not InvSetupNVX.Get() then begin
            InvSetupNVX.Init();
            InvSetupNVX.Insert();
        end;
    end;


}