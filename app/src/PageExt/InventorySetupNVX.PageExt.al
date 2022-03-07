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
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }
            field("Inventory Cost Center NVX"; InvSetupNVX."Inventory Cost Center")
            {
                ApplicationArea = All;
                Caption = 'Inventory Cost Center', comment = 'DEA="Lager KSt."';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }
            field("Section - Inventory Value ZeroNVX"; InvSetupNVX."Section - Inventory Value Zero")
            {
                ApplicationArea = All;
                Caption = 'Section - Inventory Value Zero', comment = 'DEA="EK und VK nicht lagerbewertet Sparte"';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }

            field("Purchase Gen. Bus. Posting Group FixedNVX"; InvSetupNVX."Purch Gen. Bus. Pst Grp Fixed")
            {
                ApplicationArea = All;
                Caption = 'Purchase Gen. Bus. Posting Group Fixed', comment = 'DEA="Zukauf Steuerschlüssel FIX"';
                TableRelation = "Gen. Business Posting Group".Code;
                trigger OnValidate();
                begin
                    InvSetupNVX.Modify();
                end;
            }
            field("Vend./Cust. Dim 1NVX"; InvSetupNVX."Vend./Cust. Dim 1")
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
                Caption = 'Vendor/Customer postings Dimension 1', comment = 'DEA="Dim. 1 Personenkonten Buchungsgruppen"';
                trigger OnValidate()
                begin
                    InvSetupNVX.Modify();
                    InvSetupNVX.GetDimSetID();
                    CurrPage.Update();
                end;
            }
            field("Vend./Cust. Dim 2NVX"; InvSetupNVX."Vend./Cust. Dim 2")
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(2));
                Caption = 'Vendor/Customer postings Dimension 2', comment = 'DEA="Dim. 2 Personenkonten Buchungsgruppen"';
                trigger OnValidate()
                begin
                    InvSetupNVX.Modify();
                    InvSetupNVX.GetDimSetID();
                    CurrPage.Update();
                end;
            }
            field("Vend./Cust. Dim 3NVX"; InvSetupNVX."Vend./Cust. Dim 3")
            {
                ApplicationArea = All;
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                Caption = 'Vendor/Customer postings Dimension 3', comment = 'DEA="Dim. 3 Personenkonten Buchungsgruppen"';
                trigger OnValidate()
                begin
                    InvSetupNVX.Modify();
                    InvSetupNVX.GetDimSetID();
                    CurrPage.Update();
                end;
            }
            field("Vend./Cust. Dim Set IDNVX"; InvSetupNVX."Vend./Cust. Dim Set ID")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Vendor/Customer Dimension Set-ID', comment = 'DEA="Dim. Personenkonten Buchungsgruppen Dimension Set ID"';
                trigger OnValidate()
                begin
                    InvSetupNVX.Modify();
                    InvSetupNVX.GetDimSetID();
                    CurrPage.Update();
                end;
            }
        }
        addlast(Content)
        {
            group(CompositionNVX)
            {
                Caption = 'Composition and Sales', comment = 'DEA="Abfassungen und Verkäufe"';
                field("Composition CustomerNVX"; InvSetupNVX."Composition Customer")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Customer', comment = 'DEA="Abfassung Debitor"';
                    TableRelation = Customer."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Gen. Bus. Posting Group FixedNVX"; InvSetupNVX."Comp Gen. Bus. Pst Grp Fixed")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Gen. Bus. Posting Group Fixed', comment = 'DEA="Abfassung Steuerschlüssel FIX"';
                    TableRelation = "Gen. Business Posting Group".Code;
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Gen. Bus. Posting Group WESNVX"; InvSetupNVX."Comp Gen. Bus. Pst Grp WES")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                    TableRelation = "Gen. Business Posting Group".Code;
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Section - Iventory Value ZeroNVX"; InvSetupNVX."Comp Sect - Inv Value Zero")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Section - Inventory Value Zero', comment = 'DEA="Abfassung nicht lagerbewertete Sparte"';
                    TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Bal. WESNVX"; InvSetupNVX."Composition Bal. WES")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Bal. WES', comment = 'DEA="Abfassung Entl. WES"';
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Composition Journal NameNVX"; InvSetupNVX."Composition Journal Name")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Journal Name', comment = 'DEA="Abfassung Buchblattname"';
                    TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = const('Verkauf'));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                        InvSetupNVX.CalcFields("Comp Journal Description");
                        CurrPage.Update();
                    end;
                }
                field("Composition Journal DescriptionNVX"; InvSetupNVX."Comp Journal Description")
                {
                    ApplicationArea = All;
                    Caption = 'Composition Journal Description', comment = 'DEA="Abfassung Buchblattbeschreibung"';
                    Editable = false;
                }
                field("Sales Journal NameNVX"; InvSetupNVX."Sales Journal Name")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Journal Name', comment = 'DEA="Verkauf Buchblattname"';
                    TableRelation = "Gen. Journal Batch".Name where("Journal Template Name" = const('Verkauf'));
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                        InvSetupNVX.CalcFields("Sales Journal Description");
                        CurrPage.Update();
                    end;
                }
                field("Sales Journal DescriptionNVX"; InvSetupNVX."Sales Journal Description")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Journal Description', comment = 'DEA="Verkauf Buchblattbeschreibung"';
                    Editable = false;
                }
                field("Sales Bal. ReturnNVX"; InvSetupNVX."Sales Bal. Return")
                {
                    ApplicationArea = All;
                    Caption = 'Sales Bal. Return', comment = 'DEA="Verkauf Entl. Erlöse"';
                    TableRelation = "G/L Account"."No.";
                    trigger OnValidate();
                    begin
                        InvSetupNVX.Modify();
                    end;
                }
                field("Sales Bal. WESNVX"; InvSetupNVX."Sales Bal. WES")
                {
                    ApplicationArea = All;
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
        InvSetupNVX: Record InvSetupNVX;

    trigger OnAfterGetRecord();
    begin
        InvSetupNVX.Reset();
        if not InvSetupNVX.Get() then begin
            InvSetupNVX.Init();
            InvSetupNVX.Insert();
        end;
        InvSetupNVX.CalcFields("Comp Journal Description", "Sales Journal Description");
    end;


}