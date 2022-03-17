table 50036 SalesLineNVX
{
    fields
    {
        field(1; "Document Type"; Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3; "Document No."; Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4; "Line No."; Integer)
        {
            DataClassification = CustomerContent;
        }
        field(10; "Allocation Code"; Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }

        field(20; "Shortcut Dimension 1 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(1));
            // CaptionClass = '1338,1'; = Sales + Dim Name
            // CaptionClass = '1339,1'; = Purchase + Dim Name
        }
        field(21; "Shortcut Dimension 3 Code"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            // CaptionClass = '1338,3'; = Sales + Dim Name
            // CaptionClass = '1339,3'; = Purchase + Dim Name            
            TableRelation = "Dimension Value".Code where("Global Dimension No." = const(3));
        }
        field(30; "Cust. Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. Unit Price', comment = 'DEA="Deb. VK-Preis"';
        }

        field(31; "Cust. Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Cust. Amount', comment = 'DEA="Deb. Betrag"';
            Editable = false;
        }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrSalesLineNVX."VAT Base Amount" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Origin Line No." = field("Line No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrSalesLineNVX."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Origin Line No." = field("Line No.")));
        }
        field(102; "Comp Gen. Bus. Pst Grp WES"; Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Composition Gen. Bus. Posting Group WES', comment = 'DEA="Abfassung Steuerschlüssel WES"';
            TableRelation = "Gen. Business Posting Group".Code;
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    procedure HandleVATDifferenceNVX(SalesHeader: Record "Sales Header")
    var
        SalesLine: Record "Sales Line";
        SalesLineNVX: Record SalesLineNVX;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATDifference: Decimal;
    begin

        SalesHeader.TestField(Status, SalesHeader.Status::Released);
        SalesHeader.CalcFields("Amount Including VAT");

        SalesLineNVX.Reset();
        SalesLineNVX.SetRange("Document Type", SalesHeader."Document Type");
        SalesLineNVX.SetRange("Document No.", SalesHeader."No.");
        SalesLineNVX.CalcSums("Cust. Amount");
        if SalesLineNVX."Cust. Amount" = 0 then
            exit;

        VATDifference := SalesHeader."Amount Including VAT" - SalesLineNVX."Cust. Amount";

        if VATDifference <> 0 then begin
            Clear(SalesLine);
            SalesLine.SetSalesHeader(SalesHeader);
            SalesLine.CalcVATAmountLines(0, SalesHeader, SalesLine, TempVATAmountLine);
            TempVATAmountLine.SetFilter("VAT Amount", '<>0');
            TempVATAmountLine.FindFirst();
            TempVATAmountLine.Validate("VAT Amount", TempVATAmountLine."VAT Amount" - VATDifference);
            TempVATAmountLine.CheckVATDifference(SalesHeader."Currency Code", true);
            TempVATAmountLine.Modify();
            SalesLine.UpdateVATOnLines(0, SalesHeader, SalesLine, TempVATAmountLine);
        end;
    end;
}