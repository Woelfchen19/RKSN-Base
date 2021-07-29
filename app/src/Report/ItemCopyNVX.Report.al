report 50000 "ItemCopyNVX"
{
    // version NAVDACH11.00.00.24742

    Caption = 'Item Copy',
                comment = 'DEA="Artikel kopieren"';
    ProcessingOnly = true;

    dataset
    {
    }

    requestpage
    {
        SaveValues = true;

        layout
        {
            area(content)
            {
                group(Options)
                {
                    Caption = 'Options',
                                comment = 'DEA="Optionen"';

                    field(ItemNo; Item."No.")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Source Item No.',
                                    comment = 'DEA="Ausgangsartikelnr."';
                        Lookup = true;
                        TableRelation = Item."No.";
                        ToolTip = 'Specifies the number of the item that you want to copy the data from.',
                                    comment = 'DEA="Gibt die Nummer des Artikels an, aus dem die Daten kopiert werden sollen."';
                    }
                    field(TargetItemNo; InItem."No.")
                    {
                        ApplicationArea = Basic,Suite;
                        Caption = 'Target Item No.',
                                    comment = 'DEA="Zielartikelnr."';
                        Lookup = true;
                        ToolTip = 'Specifies the number of the item that you want to copy the data to.',
                                    comment = 'DEA="Gibt die Nummer des Artikels an, in den die Daten kopiert werden sollen."';

                        trigger OnLookup(var Text: Text) : Boolean;
                        begin
                            IF PAGE.RUNMODAL(PAGE::"Item List",InItem,InItem."No.") = ACTION::LookupOK THEN;
                        end;
                    }
                    field(NewNoSeries; NewNoSeries)
                    {
                        ApplicationArea = Basic,Suite;
                        AssistEdit = true;
                        Caption = 'Target No. Series',
                                    comment = 'DEA="Zielnummernserien"';
                        Editable = false;
                        ToolTip = 'Specifies the item number series to which the data is to be copied.',
                                    comment = 'DEA="Gibt die Artikelnummernserie an, in die Daten kopiert werden sollen."';

                        trigger OnAssistEdit();
                        begin
                            ItemSetup.Get();
                            ItemSetup.TESTFIELD("Item Nos.");
                            NoSeriesMgt.SelectSeries(ItemSetup."Item Nos.",Item."No. Series",NewNoSeries);
                        end;
                    }
                    group(General)
                    {
                        Caption = 'General',
                                    comment = 'DEA="Allgemein"';
                        field(GeneralItemInformation; CopyGenItemInfo)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'General Item Information',
                                        comment = 'DEA="Allgemeine Artikelinformationen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Comments; CopyComments)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Comments',
                                        comment = 'DEA="Bemerkungen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(CopyPic; CopyPic)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Picture',
                                        comment = 'DEA="Bild"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                    }
                    group(Sale)
                    {
                        Caption = 'Sale',
                                    comment = 'DEA="Verkauf"';
                        field(SalesPrices; CopySalesPrices)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Sales Prices',
                                        comment = 'DEA="VK-Preise"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(SalesLineDisc; CopySalesLineDisc)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Sales Line Disc.',
                                        comment = 'DEA="VK-Zeilenrabatte"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                    }
                    group(Purchase)
                    {
                        Caption = 'Purchase',
                                    comment = 'DEA="Einkauf"';
                        field(PurchasePrices; CopyPurchPrices)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Purchase Prices',
                                        comment = 'DEA="EK-Preise"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(PurchaseLineDisc; CopyPurchLineDisc)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Purchase Line Disc.',
                                        comment = 'DEA="EK-Zeilenrabatte"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                    }
                    group(Service)
                    {
                        Caption = 'Service',
                                    comment = 'DEA="Service"';
                        field(Troubleshooting; CopyTroubleshooting)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Troubleshooting',
                                        comment = 'DEA="Lösungsanleitung"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ResourceSkills; CopyResourceSkills)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Resource Skills',
                                        comment = 'DEA="Ressourcenqualifikationen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                    }
                    group(Extended)
                    {
                        Caption = 'Extended',
                                    comment = 'DEA="Erweitert"';
                        field(UnitsOfMeasure; CopyUnitOfMeasure)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Units of measure',
                                        comment = 'DEA="Einheiten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ItemVariants; CopyVariants)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Item Variants',
                                        comment = 'DEA="Artikelvarianten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Translations; CopyTranslations)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Translations',
                                        comment = 'DEA="Übersetzungen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ExtendedTexts; CopyExtTxt)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Extended Texts',
                                        comment = 'DEA="Textbausteine"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(BOMComponents; CopyBOM)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'BOM Components',
                                        comment = 'DEA="Stücklistenkomponenten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(CopyItemVendor; CopyItemVendor)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Item Vendors',
                                        comment = 'DEA="Debitoren Artikel"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Attributes; CopyAttributes)
                        {
                            ApplicationArea = Basic,Suite;
                            Caption = 'Attributes',
                                        comment = 'DEA="Attribute"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                    }
                }
            }
        }

        actions
        {
        }

        trigger OnOpenPage();
        begin
            Item := TmpItem;
            CLEAR(InItem);
            NewNoSeries := '"';
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        Window.OPEN(
          Text001 + // copy item
          Text002 + // From item
          Text003 + // To item
          '             #3############## #4#####');

        Window.UPDATE(1,Item."No.");
        Window.UPDATE(2,InItem."No.");
        CopyItem(Item."No.",InItem."No.");

        MESSAGE(
          RecapitulationTxt +
          DialogTxt[1] + DialogTxt[2] + DialogTxt[3] + DialogTxt[4] + DialogTxt[5] +
          DialogTxt[6] + DialogTxt[7] + DialogTxt[8] + DialogTxt[9] + DialogTxt[10] +
          DialogTxt[11] + DialogTxt[12] + DialogTxt[13] + DialogTxt[14] + DialogTxt[15] +
          DialogTxt[16] + DialogTxt[17] + DialogTxt[18] + DialogTxt[19] + DialogTxt[20] +
          DialogTxt[21] + DialogTxt[22] + DialogTxt[23] + DialogTxt[24] + DialogTxt[25] +
          DialogTxt[26] + DialogTxt[27] + DialogTxt[28] + DialogTxt[29] + DialogTxt[30],
          Item."No.",InItem."No.");

        Window.CLOSE();

        CopySuccessful := TRUE;
    end;

    var
        Item : Record "Item";
        InItem : Record "Item";
        ItemTranslation : Record "Item Translation";
        TmpItem : Record "Item";
        ItemSetup : Record "Inventory Setup";
        NoSeriesMgt : Codeunit NoSeriesManagement;
        Window : Dialog;
        CopyGenItemInfo : Boolean;
        CopyComments : Boolean;
        CopyPic : Boolean;
        CopyUnitOfMeasure : Boolean;
        CopyVariants : Boolean;
        CopyTranslations : Boolean;
        CopyExtTxt : Boolean;
        CopyBOM : Boolean;
        CopyItemVendor : Boolean;
        CopyTroubleshooting : Boolean;
        CopyResourceSkills : Boolean;
        CopySalesPrices : Boolean;
        CopySalesLineDisc : Boolean;
        CopyPurchPrices : Boolean;
        CopyPurchLineDisc : Boolean;
        CopyAttributes : Boolean;
        DialogTxt : array [30] of Text[250];
        DialogTitle : Text[50];
        RecCount : Integer;
        CopyCount : Integer;
        TmpItemNo : Code[20];
        CopySuccessful : Boolean;
        Text001 : Label 'Copy Item\\',comment = 'DEA="Artikel kopieren\\"';
        Text002 : Label 'Source Item     #1########\',comment = 'DEA="Ausgangsartikel     #1########\"';
        Text003 : Label 'Target Item     #2########\',comment = 'DEA="Zielartikel         #2########\"';
        RecapitulationTxt : Label 'Recapitulation of copy job:\\Source Item: %1\Target Item: %2\',comment = 'DEA="Zusammenfassung von Kopierauftrag:\\Ausgangsartikel: %1\Zielartikel: %2\"';
        Text007 : Label 'Source Item No. %1 doesn''t exist.',comment = 'DEA="Ausgangsartikel %1 existiert nicht."';
        Text008 : Label 'Target Item No. must not be empty.',comment = 'DEA="Zielartikelnr. darf nicht leer sein."';
        Text009 : Label 'General item information',comment = 'DEA="Allg. Artikelinformationen"';
        Text010 : Label 'Target Item No.%1 already exists.',comment = 'DEA="Zielartikel %1 ist bereits vorhanden."';
        Text011 : Label 'Target Item %1 doesn''t exist.',comment = 'DEA="Zielartikel %1 existiert nicht."';
        Text013 : Label 'Comments',comment = 'DEA="Bemerkungen"';
        Text014 : Label 'Item units of measure',comment = 'DEA="Maßeinheiten Artikel"';
        Text015 : Label 'Item variants',comment = 'DEA="Artikelvarianten"';
        Text016 : Label 'Item translations',comment = 'DEA="Artikelübersetzungen"';
        Text017 : Label 'Extended texts',comment = 'DEA="Textbausteine"';
        Text018 : Label 'BOM components',comment = 'DEA="Stücklistenkomponenten"';
        Text021 : Label 'Item vendors',comment = 'DEA="Debitoren Artikel"';
        Text025 : Label 'copied.',comment = 'DEA="kopiert."';
        Text026 : Label 'Resource skills',comment = 'DEA="Ressourcenqualifikationen"';
        Text027 : Label 'Dimensions',comment = 'DEA="Dimensionen"';
        Text028 : Label 'Troubleshootings',comment = 'DEA="Lösungsanleitungen"';
        Text029 : Label 'Sales Prices',comment = 'DEA="VK-Preise"';
        Text030 : Label 'Sales Line Disc.',comment = 'DEA="VK-Zeilenrabatte"';
        Text031 : Label 'Purchase Prices',comment = 'DEA="EK-Preise"';
        Text032 : Label 'Purchase Line Disc.',comment = 'DEA="EK-Zeilenrabatte"';
        NewNoSeries : Code[20];

    procedure CopyItem(_FromItemNo : Code[20];_InItemNo : Code[20]);
    begin
        IF NOT Item.GET(_FromItemNo) THEN
          ERROR(Text007,_FromItemNo);

        IF (_InItemNo = '') AND (NOT CopyGenItemInfo) THEN
          ERROR(Text008);

        ItemSetup.Get();

        IF CopyGenItemInfo THEN
          InsertTargetItem(_InItemNo)
        ELSE BEGIN
          IF NOT InItem.GET(_InItemNo) THEN
            ERROR(Text011,_InItemNo);
        END;

        IF NOT (CopySalesLineDisc OR CopyPurchLineDisc) THEN BEGIN
          InItem."Item Disc. Group" := '"';
          InItem.Modify();
        END;

        CopyItemPicture(Item,InItem);
        CopyItemComments(Item."No.",InItem."No.");
        CopyItemUnisOfMeasure(Item,InItem);
        CopyItemVariants(Item."No.",InItem."No.");
        CopyItemTranslations(Item."No.",InItem."No.");
        CopyExtendedTexts(Item."No.",InItem."No.");
        CopyBOMComponents(Item."No.",InItem."No.");
        CopyItemVendors(Item."No.",InItem."No.");
        CopyTroubleshootingSetup(Item."No.",InItem."No.");
        CopyItemResourceSkills(Item."No.",InItem."No.");
        CopyItemSalesPrices(Item."No.",InItem."No.");
        CopySalesLineDiscounts(Item."No.",InItem."No.");
        CopyPurchasePrices(Item."No.",InItem."No.");
        CopyPurchaseLineDiscounts(Item."No.",InItem."No.");
        CopyItemAttributes(Item."No.",InItem."No.");
    end;

    procedure InitDialog(Txt : Text[50]);
    begin
        RecCount := 0;
        CopyCount := CopyCount + 1;
        DialogTitle := Txt;
        Window.UPDATE(3,Txt);
        Window.UPDATE(4,0);
    end;

    procedure UpdateDialog();
    begin
        RecCount := RecCount + 1;
        Window.UPDATE(4,RecCount);
    end;

    procedure EndDialog();
    begin
        IF RecCount <> 0 THEN
          DialogTitle := STRSUBSTNO('%1 %2',RecCount,DialogTitle);
        DialogTitle := DialogTitle + ' ' + Text025;
        DialogTxt[CopyCount] := DialogTitle + '\"';
    end;

    procedure ItemDef(var Item2 : Record "Item");
    begin
        TmpItem := Item2;
    end;

    procedure ItemReturn(var ReturnItem : Record "Item") : Boolean;
    begin
        ReturnItem := InItem;
        EXIT(CopySuccessful);
    end;

    local procedure SetTargetItemNo(NewItemNo : Code[20];var TargetItemNo : Code[20];var TargetNoSeries : Code[20]);
    var
        TmpItemNo : Code[20];
    begin
        IF NewItemNo = '' THEN
          IF NewNoSeries <> '' THEN BEGIN
            NoSeriesMgt.SetSeries(TargetItemNo);
            TargetNoSeries := NewNoSeries;
          END ELSE BEGIN
            ItemSetup.TESTFIELD("Item Nos.");
            NoSeriesMgt.InitSeries(ItemSetup."Item Nos.",Item."No. Series",0D,TargetItemNo,TargetNoSeries);
          END
        ELSE BEGIN
          IF InItem.GET(NewItemNo) THEN
            ERROR(Text010,NewItemNo);
          IF ItemSetup."Item Nos." <> '' THEN
            NoSeriesMgt.TestManual(ItemSetup."Item Nos.");

          TargetItemNo := NewItemNo;
          TargetNoSeries := '"';
        END
    end;

    local procedure InsertTargetItem(NewItemNo : Code[20]);
    var
        TempItemNo : Code[20];
        TempItemNoSeries : Code[20];
    begin
        InitDialog(Text009);
        WITH InItem DO BEGIN
          SetTargetItemNo(NewItemNo,TempItemNo,TempItemNoSeries);
          COPY(Item);
          "No." := TempItemNo;
          "No. Series" := TempItemNoSeries;
          "Last Date Modified" := TODAY;
          "Created From Nonstock Item" := FALSE;
          INSERT();
        END;
        EndDialog();
    end;

    local procedure CopyItemPicture(FromItem : Record "Item";var ToItem : Record "Item");
    begin
        IF CopyPic THEN BEGIN
          ToItem.Picture := FromItem.Picture;
          ToItem.Modify();
        END ELSE BEGIN
          CLEAR(ToItem.Picture);
          ToItem.Modify();
        END;
    end;

    local procedure CopyItemComments(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        CommentLine : Record "Comment Line";
    begin
        IF NOT CopyComments THEN
          EXIT;

        CommentLine.SETRANGE("Table Name",CommentLine."Table Name"::Item);
        CommentLine.SETRANGE("No.",FromItemNo);
        IF CommentLine.FINDSET() THEN BEGIN
          InitDialog(Text013);
          REPEAT
            CommentLine."No." := ToItemNo;
            CommentLine.INSERT();
            CommentLine."No." := FromItemNo;
            UpdateDialog();
          UNTIL CommentLine.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyItemUnisOfMeasure(FromItem : Record "Item";var ToItem : Record "Item");
    var
        ItemUnitOfMeasure : Record "Item Unit of Measure";
    begin
        IF CopyUnitOfMeasure THEN BEGIN
          ItemUnitOfMeasure.SETRANGE("Item No.",FromItem."No.");
          IF ItemUnitOfMeasure.FINDSET() THEN BEGIN
            InitDialog(Text014);
            REPEAT
              ItemUnitOfMeasure."Item No." := ToItem."No.";
              ItemUnitOfMeasure.INSERT();
              ItemUnitOfMeasure."Item No." := FromItem."No.";
              UpdateDialog();
            UNTIL ItemUnitOfMeasure.Next() = 0;
            EndDialog();
          END;
        END ELSE
          IF CopyGenItemInfo THEN BEGIN
            ToItem."Base Unit of Measure" := '"';
            ToItem."Sales Unit of Measure" := '"';
            ToItem."Purch. Unit of Measure" := '"';
            ToItem."Put-away Unit of Measure Code" := '"';
            ToItem.Modify();
          END;
    end;

    local procedure CopyItemVariants(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        ItemVariant : Record "Item Variant";
    begin
        IF NOT CopyVariants THEN
          EXIT;

        ItemVariant.SETRANGE("Item No.",FromItemNo);
        IF ItemVariant.FINDSET() THEN BEGIN
          InitDialog(Text015);
          REPEAT
            ItemVariant."Item No." := ToItemNo;
            ItemVariant.INSERT();
            ItemVariant."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL ItemVariant.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyItemTranslations(FromItemNo : Code[20];ToItemNo : Code[20]);
    begin
        IF NOT CopyTranslations THEN
          EXIT;

        ItemTranslation.SETRANGE("Item No.",FromItemNo);
        IF NOT CopyVariants THEN
          ItemTranslation.SETRANGE("Variant Code",'');
        IF ItemTranslation.FINDSET() THEN BEGIN
          InitDialog(Text016);
          REPEAT
            ItemTranslation."Item No." := ToItemNo;
            ItemTranslation.INSERT();
            ItemTranslation."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL ItemTranslation.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyExtendedTexts(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        ExtendedTextHeader : Record "Extended Text Header";
        ExtendedTextLine : Record "Extended Text Line";
    begin
        IF NOT CopyExtTxt THEN
          EXIT;

        ExtendedTextHeader.SETRANGE("Table Name",ExtendedTextHeader."Table Name"::Item);
        ExtendedTextHeader.SETRANGE("No.",FromItemNo);
        IF ExtendedTextHeader.FINDSET() THEN BEGIN
          InitDialog(Text017);
          REPEAT
            ExtendedTextLine.SETRANGE("Table Name",ExtendedTextHeader."Table Name");
            ExtendedTextLine.SETRANGE("No.",ExtendedTextHeader."No.");
            ExtendedTextLine.SETRANGE("Language Code",ExtendedTextHeader."Language Code");
            ExtendedTextLine.SETRANGE("Text No.",ExtendedTextHeader."Text No.");
            IF ExtendedTextLine.FINDSET() THEN
              REPEAT
                ExtendedTextLine."No." := ToItemNo;
                ExtendedTextLine.INSERT();
                ExtendedTextLine."No." := FromItemNo;
              UNTIL ExtendedTextLine.Next() = 0;

            ExtendedTextHeader."No." := ToItemNo;
            ExtendedTextHeader.INSERT();
            ExtendedTextHeader."No." := FromItemNo;
            UpdateDialog();
          UNTIL ExtendedTextHeader.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyBOMComponents(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        BOMComponent : Record "BOM Component";
    begin
        IF NOT CopyBOM THEN
          EXIT;

        BOMComponent.SETRANGE("Parent Item No.",FromItemNo);
        IF BOMComponent.FINDSET() THEN BEGIN
          InitDialog(Text018);
          REPEAT
            BOMComponent."Parent Item No." := ToItemNo;
            BOMComponent.INSERT();
            BOMComponent."Parent Item No." := FromItemNo;
            UpdateDialog();
          UNTIL BOMComponent.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyItemVendors(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        ItemVendor : Record "Item Vendor";
    begin
        IF NOT CopyItemVendor THEN
          EXIT;

        ItemVendor.SETRANGE("Item No.",FromItemNo);
        IF ItemVendor.FINDSET() THEN BEGIN
          InitDialog(Text021);
          REPEAT
            ItemVendor."Item No." := ToItemNo;
            ItemVendor.INSERT();
            ItemVendor."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL ItemVendor.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyTroubleshootingSetup(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        TroubleshootingSetup : Record "Troubleshooting Setup";
    begin
        IF NOT CopyTroubleshooting THEN
          EXIT;

        TroubleshootingSetup.SETRANGE(Type,TroubleshootingSetup.Type::Item);
        TroubleshootingSetup.SETRANGE("No.",FromItemNo);
        IF TroubleshootingSetup.FINDSET() THEN BEGIN
          InitDialog(Text028);
          REPEAT
            TroubleshootingSetup."No." := ToItemNo;
            TroubleshootingSetup.INSERT();
            TroubleshootingSetup."No." := FromItemNo;
            UpdateDialog();
          UNTIL TroubleshootingSetup.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyItemResourceSkills(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        ResourceSkill : Record "Resource Skill";
    begin
        IF NOT CopyResourceSkills THEN
          EXIT;

        ResourceSkill.SETRANGE(Type,ResourceSkill.Type::Item);
        ResourceSkill.SETRANGE("No.",FromItemNo);
        IF ResourceSkill.FINDSET() THEN BEGIN
          InitDialog(Text026);
          REPEAT
            ResourceSkill."No." := ToItemNo;
            ResourceSkill.INSERT();
            ResourceSkill."No." := FromItemNo;
            UpdateDialog();
          UNTIL ResourceSkill.Next() = 0;
          EndDialog();
        END;
    end;

    local procedure CopyItemSalesPrices(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        SalesPrice : Record "Sales Price";
    begin
        IF NOT CopySalesPrices THEN
          EXIT;

        SalesPrice.SETRANGE("Item No.",FromItemNo);
        IF SalesPrice.FINDSET() THEN BEGIN
          InitDialog(Text029);
          REPEAT
            SalesPrice."Item No." := ToItemNo;
            SalesPrice.INSERT();
            SalesPrice."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL SalesPrice.Next() = 0;
        END;
    end;

    local procedure CopySalesLineDiscounts(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        SalesLineDiscount : Record "Sales Line Discount";
    begin
        IF NOT CopySalesLineDisc THEN
          EXIT;

        SalesLineDiscount.SETRANGE(Type,SalesLineDiscount.Type::Item);
        SalesLineDiscount.SETRANGE(Code,FromItemNo);
        IF SalesLineDiscount.FINDSET() THEN BEGIN
          InitDialog(Text030);
          REPEAT
            SalesLineDiscount.Code := ToItemNo;
            SalesLineDiscount.INSERT();
            SalesLineDiscount.Code := FromItemNo;
            UpdateDialog();
          UNTIL SalesLineDiscount.Next() = 0;
        END;
    end;

    local procedure CopyPurchasePrices(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        PurchasePrice : Record "Purchase Price";
    begin
        IF NOT CopyPurchPrices THEN
          EXIT;

        PurchasePrice.SETRANGE("Item No.",FromItemNo);
        IF PurchasePrice.FINDSET() THEN BEGIN
          InitDialog(Text031);
          REPEAT
            PurchasePrice."Item No." := ToItemNo;
            PurchasePrice.INSERT();
            PurchasePrice."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL PurchasePrice.Next() = 0;
        END;
    end;

    local procedure CopyPurchaseLineDiscounts(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        PurchLineDiscount : Record "Purchase Line Discount";
    begin
        IF NOT CopyPurchLineDisc THEN
          EXIT;

        PurchLineDiscount.SETRANGE("Item No.",FromItemNo);
        IF PurchLineDiscount.FINDSET() THEN BEGIN
          InitDialog(Text032);
          REPEAT
            PurchLineDiscount."Item No." := ToItemNo;
            PurchLineDiscount.INSERT();
            PurchLineDiscount."Item No." := FromItemNo;
            UpdateDialog();
          UNTIL PurchLineDiscount.Next() = 0;
        END;
    end;

    local procedure CopyItemAttributes(FromItemNo : Code[20];ToItemNo : Code[20]);
    var
        ItemAttributeValueMapping : Record "Item Attribute Value Mapping";
        NewItemAttributeValueMapping : Record "Item Attribute Value Mapping";
    begin
        IF NOT CopyAttributes THEN
          EXIT;

        ItemAttributeValueMapping.SETRANGE("Table ID",DATABASE::Item);
        ItemAttributeValueMapping.SETRANGE("No.",FromItemNo);
        IF ItemAttributeValueMapping.FINDSET() THEN
          REPEAT
            NewItemAttributeValueMapping := ItemAttributeValueMapping;
            NewItemAttributeValueMapping."No." := ToItemNo;
            NewItemAttributeValueMapping.INSERT();
          UNTIL ItemAttributeValueMapping.Next() = 0;
    end;
}

