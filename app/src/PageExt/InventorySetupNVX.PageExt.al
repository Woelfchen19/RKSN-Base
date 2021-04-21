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
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;                
            }
            field("Section - Inventory Value Zero";InvSetupNVX."Section - Inventory Value Zero")
            {
                ApplicationArea = All;
                Caption = 'Section - Inventory Value Zero', comment = 'DEA="EK und VK nicht lagerbewertet Sparte"';
                TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
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
        addlast(Content)
        {
            group(Composition)
            {
                Caption = 'Composition and Sales', comment = 'DEA="Abfassungen und Verkäufe"';
                field("Composition Customer";InvSetupNVX."Composition Customer")
                {
                    Caption = 'Composition Customer', comment = 'DEA="Abfassung Debitor"';
                    TableRelation = Customer."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Gen. Bus. Posting Group Fixed";InvSetupNVX."Composition Gen. Bus. Posting Group Fixed")
                {
                    Caption = 'Composition Gen. Bus. Posting Group Fixed', comment = 'DEA="Abfassung Steuerschlüssel FIX"';
                    TableRelation = "Gen. Business Posting Group".Code;
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Gen. Bus. Posting Group WES";InvSetupNVX."Composition Gen. Bus. Posting Group WES")
                {
                    Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                    TableRelation = "Gen. Business Posting Group".Code;
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Section - Iventory Value Zero";InvSetupNVX."Composition Section - Iventory Value Zero")
                {
                    Caption = 'Composition Section - Inventory Value Zero', comment = 'DEA="Abfassung nicht lagerbewertete Sparte"';
                    TableRelation = "Dimension Value".Code WHERE ("Global Dimension No."=CONST(3));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Bal. WES";InvSetupNVX."Composition Bal. WES")
                {
                    Caption = 'Composition Bal. WES', comment = 'DEA="Abfassung Entl. WES"';
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Journal Name";InvSetupNVX."Composition Journal Name")
                {
                    Caption = 'Composition Journal Name', comment = 'DEA="Abfassung Buchblattname"';
                    TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = const ('Verkauf'));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                        InvSetupNVX.CalcFields("Composition Journal Description");
                        CurrPage.Update();
                    end;
                }
                field("Composition Journal Description";InvSetupNVX."Composition Journal Description")
                {
                    Caption = 'Composition Journal Description', comment = 'DEA="Abfassung Buchblattbeschreibung"';
                    Editable = false;
                }
                field("Sales Journal Name";InvSetupNVX."Sales Journal Name")
                {
                    Caption = 'Sales Journal Name', comment = 'DEA="Verkauf Buchblattname"';
                    TableRelation = "Gen. Journal Batch".Name where ("Journal Template Name" = const ('Verkauf'));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                        InvSetupNVX.CalcFields("Composition Journal Description");
                        CurrPage.Update();
                    end;
                }
                field("Sales Journal Description";InvSetupNVX."Sales Journal Description")
                {
                    Caption = 'Sales Journal Description', comment = 'DEA="Verkauf Buchblattbeschreibung"';
                    Editable = false;
                }
                field("Sales Bal. Return";InvSetupNVX."Sales Bal. Return")
                {
                    Caption = 'Sales Bal. Return', comment = 'DEA="Verkauf Entl. Erlöse"';
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Sales Bal. WES";InvSetupNVX."Sales Bal. WES")
                {
                    Caption = 'Sales Bal. WES', comment = 'DEA="Verkauf Entl. WES"';
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
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
        InvSetupNVX.CalcFields("Composition Journal Description","Sales Journal Description");
    end;


}