pageextension 50018 "PstdSInvoiceNVX" extends "Posted Sales Invoice"
{
    layout
    {
        addfirst("Invoice Details")
        {
            field("Allocation Code NVX"; SalesInvoiceHeaderNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
            field("Shortcut Dimension 3 Code NVX"; SalesInvoiceHeaderNVX."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                Editable = false;
            }
            field("Interim Gen.Bus.Posting Group NVX"; SalesInvoiceHeaderNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group";
                Editable = false;
            }
            field("Comp Gen. Bus. Pst Grp WES NVX"; SalesInvoiceHeaderNVX."Comp Gen. Bus. Pst Grp WES")
            {
                ApplicationArea = All;
                Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                TableRelation = "Gen. Business Posting Group".Code;
                Editable = false;
            }
            field("Transaction No. NVX"; SalesInvoiceHeaderNVX."Transaction No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Transaction No.', comment = 'DEA="Verkauf Transaktionsnummer"';
                Editable = false;
            }
        }
        addbefore(IncomingDocAttachFactBox)
        {
            part(DimensionSetEntriesFactBoxNVX; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
            }
        }
    }
    var
        SalesInvoiceHeaderNVX: Record SalesInvoiceHeaderNVX;

    trigger OnAfterGetRecord();
    begin
        if SalesInvoiceHeaderNVX.Get("No.") then;
    end;
}