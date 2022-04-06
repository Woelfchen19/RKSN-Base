table 50029 PurchaseLineNVX
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
        field(30; "Vend. Unit Price"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend. Unit Price', comment = 'DEA="Kred. VK-Preis"';
        }

        field(31; "Vend. Amount"; Decimal)
        {
            DataClassification = ToBeClassified;
            Caption = 'Vend. Amount', comment = 'DEA="Kred. Betrag"';
            Editable = false;
        }
        field(100; "Allocation Amount"; Decimal)
        {
            Caption = 'Allocation Amount';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrPurchLineNVX."VAT Base Amount" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Origin Line No." = field("Line No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum(DistrPurchLineNVX."Amount Including VAT" where("Document Type" = field("Document Type"), "Document No." = field("Document No."), "Origin Line No." = field("Line No.")));
        }
    }

    keys
    {
        key(PK; "Document Type", "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }
    procedure HandleVATDifferenceNVX(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLine: Record "Purchase Line";
        PurchaseLineNVX: Record PurchaseLineNVX;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        VATDifference: Decimal;
    begin
        begin
            PurchaseHeader.TestField(Status, PurchaseHeader.Status::Released);
            PurchaseHeader.CalcFields("Amount Including VAT");

            PurchaseLineNVX.Reset();
            PurchaseLineNVX.SetRange("Document Type", PurchaseHeader."Document Type");
            PurchaseLineNVX.SetRange("Document No.", PurchaseHeader."No.");
            PurchaseLineNVX.CalcSums("Vend. Amount");
            if PurchaseLineNVX."Vend. Amount" = 0 then
                exit;

            VATDifference := PurchaseHeader."Amount Including VAT" - PurchaseLineNVX."Vend. Amount";

            if VATDifference <> 0 then begin
                Clear(PurchaseLine);
                PurchaseLine.SetPurchHeader(PurchaseHeader);
                PurchaseLine.CalcVATAmountLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);
                TempVATAmountLine.SetFilter("VAT Amount", '<>0');
                TempVATAmountLine.FindFirst();
                TempVATAmountLine.Validate("VAT Amount", TempVATAmountLine."VAT Amount" - VATDifference);
                TempVATAmountLine.CheckVATDifference(PurchaseHeader."Currency Code", true);
                TempVATAmountLine.Modify();
                PurchaseLine.UpdateVATOnLines(0, PurchaseHeader, PurchaseLine, TempVATAmountLine);
            end;
        end;
    end;

    procedure GetDefinition(DocumentType: Enum RKSPurchaseDocumentTypeNVX; DocumentNo: Code[20]; LineNo: Integer)
    begin
        if LineNo = 0 then
            exit;
        if ("Document Type" = DocumentType) and
            ("Document No." = DocumentNo) and
            ("Line No." = LineNo)
        then
            exit;

        if Get(DocumentType, DocumentNo, LineNo) then begin
            CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
            exit;
        end;

        Init();
        "Document Type" := DocumentType;
        "Document No." := DocumentNo;
        "Line No." := LineNo;
        Insert();
        CalcFields("Allocation Amount", "Allocation Amount Incl. VAT");
    end;
}