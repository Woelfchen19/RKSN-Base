table 50028 PurchaseLineNVX
{
    DataClassification = CustomerContent;
    
    fields
    {
        field(1;"Document Type";Option)
        {
            DataClassification = CustomerContent;
            OptionMembers = Quote,Order,Invoice,"Credit Memo","Blanket Order","Return Order";
        }
        field(3;"Document No.";Code[20])
        {
            DataClassification = CustomerContent;
        }
        field(4;"Line No.";Integer)
        {
            DataClassification = CustomerContent;            
        }
        field(10;"Allocation Code";Code[10])
        {
            Caption = 'Allocation Code', comment = 'Verteilungscode"';
            DataClassification = CustomerContent;
        }

        field(20;"Shortcut Dimension 1 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));       
            // CaptionClass = '1338,1'; = Sales + Dim Name
            // CaptionClass = '1339,1'; = Purchase + Dim Name
        }
        field(21;"Shortcut Dimension 3 Code";Code[20])
        {
            DataClassification = CustomerContent;
            Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
            // CaptionClass = '1338,3'; = Sales + Dim Name
            // CaptionClass = '1339,3'; = Purchase + Dim Name            
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
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
            CalcFormula = sum (DistrPurchLineNVX."VAT Base Amount" where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
        }
        field(101; "Allocation Amount Incl. VAT"; Decimal)
        {
            Caption = 'Allocation Amount Incl. VAT';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = sum (DistrPurchLineNVX."Amount Including VAT" where ("Document Type" = field ("Document Type"), "Document No." = field ("Document No."), "Origin Line No." = field ("Line No.")));
        }
    }

    keys
    {
        key(PK;"Document Type","Document No.","Line No.")
        {
            Clustered = true;
        }
    }

    procedure UpdateVendAmount(ActPurchaseLine: record "Purchase Line");
    begin
        "Vend. Amount" := round(ActPurchaseLine.Quantity * "Vend. Unit Price", 0.01);
        modify;
    end;
    
    procedure UpdatePurchaseLine(var ActPurchaseLine: record "Purchase Line")
    var
        VATPostingSetup: record "VAT Posting Setup";
        VatPercent: Decimal;
        NetUnitPrice: Decimal;
    begin        
        UpdateVendAmount(ActPurchaseLine);
        if VATPostingSetup.get(actPurchaseline."VAT Bus. Posting Group", actPurchaseLine."VAT Prod. Posting Group") then;
        if VATPostingSetup."VAT Calculation Type" <> VATPostingSetup."VAT Calculation Type"::"Reverse Charge VAT" then
            VatPercent := VATPostingSetup."VAT %";
        NetUnitPrice := round("Vend. Unit Price" / (100 + VatPercent) * 100, 0.01);
        actPurchaseLine.Validate("Direct Unit Cost", NetUnitPrice);
    end;

    procedure HandleVATDifferenceNVX(PurchaseHeader: Record "Purchase Header")
    var
        PurchaseLineNVX: record PurchaseLineNVX;
        TempVATAmountLine: Record "VAT Amount Line" temporary;
        PurchaseLine: record "Purchase Line";
        VATDifference: Decimal;
    begin
        begin

            purchaseHeader.TestField(Status, purchaseHeader.Status::Released);
            purchaseHeader.CalcFields("Amount Including VAT");

            purchaseLineNVX.reset;
            purchaseLineNVX.SetRange("Document Type", purchaseHeader."Document Type");
            purchaseLineNVX.SetRange("Document No.", purchaseHeader."No.");
            purchaseLineNVX.CalcSums("Vend. Amount");
            if purchaseLineNVX."Vend. Amount" = 0 then
                exit;

            VATDifference := purchaseHeader."Amount Including VAT" - purchaseLineNVX."Vend. Amount";

            if VATDifference <> 0 then begin

                clear(purchaseline);
                purchaseLine.SetpurchHeader(purchaseHeader);
                purchaseLine.CalcVATAmountLines(0, purchaseHeader, purchaseLine, TempVATAmountLine);
                TempVATAmountLine.SetFilter("VAT Amount", '<>0');
                TempVATAmountLine.findfirst;
                TempVATAmountLine.Validate("VAT Amount", TempVATAmountLine."VAT Amount" - VATDifference);
                TempVATAmountLine.CheckVATDifference(purchaseHeader."Currency Code", true);
                TempVATAmountLine.modify;
                purchaseLine.UpdateVATOnLines(0, purchaseHeader, purchaseLine, TempVATAmountLine);

            end;

        end;

    end;
}