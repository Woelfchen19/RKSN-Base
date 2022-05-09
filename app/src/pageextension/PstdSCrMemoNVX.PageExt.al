pageextension 50016 "PstdSCrMemoNVX" extends "Posted Sales Credit Memo"
{
    layout
    {
        addfirst("Invoice Details")
        {
            field("Allocation Code NVX"; SalesCrMemoHeaderNVX."Allocation Code")
            {
                ApplicationArea = All;
                Editable = false;
                Caption = 'Allocation Code', comment = 'DEA="Verteilungscode"';
                TableRelation = AllocationCodeNVX.Code;
            }
            field("Shortcut Dimension 3 Code NVX"; SalesCrMemoHeaderNVX."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3';
                TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
                Editable = false;
            }
            field("Interim Gen.Bus.Posting Group NVX"; SalesCrMemoHeaderNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group";
                Editable = false;
            }
            field("Comp Gen. Bus. Pst Grp WES NVX"; SalesCrMemoHeaderNVX."Comp Gen. Bus. Pst Grp WES")
            {
                ApplicationArea = All;
                Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
                TableRelation = "Gen. Business Posting Group".Code;
                Editable = false;
            }
            field("Transaction No. NVX"; SalesCrMemoHeaderNVX."Transaction No.")
            {
                ApplicationArea = All;
                Caption = 'Sales Transaction No.', comment = 'DEA="Verkauf Transaktionsnummer"';
                Editable = false;
            }
        }
    }

    var
        SalesCrMemoHeaderNVX: Record SalesCrMemoHeaderNVX;

    trigger OnAfterGetRecord();
    begin
        if SalesCrMemoHeaderNVX.Get("No.") then;
    end;
}