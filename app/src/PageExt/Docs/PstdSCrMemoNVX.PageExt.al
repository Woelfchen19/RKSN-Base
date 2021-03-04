pageextension 50031 PstdSCrMemoNVX extends "Posted Sales Credit Memo"
{
    layout
    {
        addfirst("Invoice Details")
        {
            field("Shortcut Dimension 1 Code NVX"; PstdDocInfoNVX."Shortcut Dimension 1 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
                CaptionClass = '1339,1';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));
                Editable = false;
            }
            field("Shortcut Dimension 3 Code NVX"; PstdDocInfoNVX."Shortcut Dimension 3 Code")
            {
                ApplicationArea = All;
                Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
                CaptionClass = '1339,3';
                TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
                Editable = false;
            }
            field("Interim Gen.Bus.Posting Group"; PstdDocInfoNVX."Interim Gen.Bus.Posting Group")
            {
                ApplicationArea = All;
                Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
                TableRelation = "Gen. Business Posting Group";
                Editable = false;
            }
        }
    }
    
        var
        PstdDocInfoNVX: Record PstdDocInfoNVX;

    trigger OnAfterGetRecord();
    begin
        PstdDocInfoNVX.Get(PstdDocInfoNVX.Department::Sales,PstdDocInfoNVX."Document Type"::"Credit Memo","No.");
    end;
}