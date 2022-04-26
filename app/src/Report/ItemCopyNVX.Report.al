report 50000 ItemCopyNVX
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
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options',
                                comment = 'DEA="Optionen"';

                    field(ItemNo; Item."No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Source Item No.',
                                    comment = 'DEA="Ausgangsartikelnr."';
                        Lookup = true;
                        TableRelation = Item."No.";
                        ToolTip = 'Specifies the number of the item that you want to copy the data from.',
                                    comment = 'DEA="Gibt die Nummer des Artikels an, aus dem die Daten kopiert werden sollen."';
                    }
                    field(TargetItemNo; InItem."No.")
                    {
                        ApplicationArea = Basic, Suite;
                        Caption = 'Target Item No.',
                                    comment = 'DEA="Zielartikelnr."';
                        Lookup = true;
                        ToolTip = 'Specifies the number of the item that you want to copy the data to.',
                                    comment = 'DEA="Gibt die Nummer des Artikels an, in den die Daten kopiert werden sollen."';

                        trigger OnLookup(var Text: Text): Boolean;
                        begin
                            if Page.RunModal(Page::"Item List", InItem, InItem."No.") = Action::LookupOK then;
                        end;
                    }
                    field(NoSeries; NewNoSeries)
                    {
                        ApplicationArea = Basic, Suite;
                        AssistEdit = true;
                        Caption = 'Target No. Series',
                                    comment = 'DEA="Zielnummernserien"';
                        Editable = false;
                        ToolTip = 'Specifies the item number series to which the data is to be copied.',
                                    comment = 'DEA="Gibt die Artikelnummernserie an, in die Daten kopiert werden sollen."';

                        trigger OnAssistEdit();
                        begin
                            ItemSetup.Get();
                            ItemSetup.TestField("Item Nos.");
                            NoSeriesMgt.SelectSeries(ItemSetup."Item Nos.", Item."No. Series", NewNoSeries);
                        end;
                    }
                    group(General)
                    {
                        Caption = 'General',
                                    comment = 'DEA="Allgemein"';
                        field(GeneralItemInformation; CopyGenItemInfo)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'General Item Information',
                                        comment = 'DEA="Allgemeine Artikelinformationen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Comments; CopyComments)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Comments',
                                        comment = 'DEA="Bemerkungen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Pic; CopyPic)
                        {
                            ApplicationArea = Basic, Suite;
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
                            ApplicationArea = Basic, Suite;
                            Caption = 'Sales Prices',
                                        comment = 'DEA="VK-Preise"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(SalesLineDisc; CopySalesLineDisc)
                        {
                            ApplicationArea = Basic, Suite;
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
                            ApplicationArea = Basic, Suite;
                            Caption = 'Purchase Prices',
                                        comment = 'DEA="EK-Preise"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(PurchaseLineDisc; CopyPurchLineDisc)
                        {
                            ApplicationArea = Basic, Suite;
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
                            ApplicationArea = Basic, Suite;
                            Caption = 'Troubleshooting',
                                        comment = 'DEA="Lösungsanleitung"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ResourceSkills; CopyResourceSkills)
                        {
                            ApplicationArea = Basic, Suite;
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
                            ApplicationArea = Basic, Suite;
                            Caption = 'Units of measure',
                                        comment = 'DEA="Einheiten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ItemVariants; CopyVariants)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Variants',
                                        comment = 'DEA="Artikelvarianten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Translations; CopyTranslations)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Translations',
                                        comment = 'DEA="Übersetzungen"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ExtendedTexts; CopyExtTxt)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Extended Texts',
                                        comment = 'DEA="Textbausteine"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(BOMComponents; CopyBOM)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'BOM Components',
                                        comment = 'DEA="Stücklistenkomponenten"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(ItemVendor; CopyItemVendor)
                        {
                            ApplicationArea = Basic, Suite;
                            Caption = 'Item Vendors',
                                        comment = 'DEA="Debitoren Artikel"';
                            ToolTip = 'Specifies if the selected data type if also copied to the new item.',
                                        comment = 'DEA="Gibt an, ob der ausgewählte Datentyp auch in den neuen Artikel kopiert wird."';
                        }
                        field(Attributes; CopyAttributes)
                        {
                            ApplicationArea = Basic, Suite;
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
            Clear(InItem);
            NewNoSeries := '"';
        end;
    }

    labels
    {
    }

    trigger OnPreReport();
    begin
        //   Text001Txt + // copy item
        //   Text002Txt + // From item
        //   Text003Txt + // To item

        Window.Open(
            StrSubstNo('%1%2%3%4', Text001Txt, Text002Txt, Text003Txt, '             #3############## #4#####'));

        Window.Update(1, Item."No.");
        Window.Update(2, InItem."No.");
        CopyItem(Item."No.", InItem."No.");

        Message(
          RecapitulationTxt +
          DialogTxt[1] + DialogTxt[2] + DialogTxt[3] + DialogTxt[4] + DialogTxt[5] +
          DialogTxt[6] + DialogTxt[7] + DialogTxt[8] + DialogTxt[9] + DialogTxt[10] +
          DialogTxt[11] + DialogTxt[12] + DialogTxt[13] + DialogTxt[14] + DialogTxt[15] +
          DialogTxt[16] + DialogTxt[17] + DialogTxt[18] + DialogTxt[19] + DialogTxt[20] +
          DialogTxt[21] + DialogTxt[22] + DialogTxt[23] + DialogTxt[24] + DialogTxt[25] +
          DialogTxt[26] + DialogTxt[27] + DialogTxt[28] + DialogTxt[29] + DialogTxt[30],
          Item."No.", InItem."No.");

        Window.Close();

        CopySuccessful := true;
    end;

    var
        ItemSetup: Record "Inventory Setup";
        InItem: Record Item;
        Item: Record Item;
        TmpItem: Record Item;
        ItemTranslation: Record "Item Translation";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        CopyAttributes: Boolean;
        CopyBOM: Boolean;
        CopyComments: Boolean;
        CopyExtTxt: Boolean;
        CopyGenItemInfo: Boolean;
        CopyItemVendor: Boolean;
        CopyPic: Boolean;
        CopyPurchPrices: Boolean;
        CopyPurchLineDisc: Boolean;
        CopyResourceSkills: Boolean;
        CopySalesLineDisc: Boolean;
        CopySalesPrices: Boolean;
        CopySuccessful: Boolean;
        CopyTranslations: Boolean;
        CopyTroubleshooting: Boolean;
        CopyUnitOfMeasure: Boolean;
        CopyVariants: Boolean;
        NewNoSeries: Code[20];
        Window: Dialog;
        CopyCount: Integer;
        RecCount: Integer;
        RecapitulationTxt: Label 'Recapitulation of copy job:\\Source Item: %1\Target Item: %2\', comment = 'DEA="Zusammenfassung von Kopierauftrag:\\Ausgangsartikel: %1\Zielartikel: %2\"';
        Text001Txt: Label 'Copy Item\\', comment = 'DEA="Artikel kopieren\\"';
        Text002Txt: Label 'Source Item     #1########\', comment = 'DEA="Ausgangsartikel     #1########\"';
        Text003Txt: Label 'Target Item     #2########\', comment = 'DEA="Zielartikel         #2########\"';
        Text007Txt: Label 'Source Item No. %1 doesn''t exist.', comment = 'DEA="Ausgangsartikel %1 existiert nicht."';
        Text008Txt: Label 'Target Item No. must not be empty.', comment = 'DEA="Zielartikelnr. darf nicht leer sein."';
        Text009Txt: Label 'General item information', comment = 'DEA="Allg. Artikelinformationen"';
        Text010Txt: Label 'Target Item No.%1 already exists.', comment = 'DEA="Zielartikel %1 ist bereits vorhanden."';
        Text011Txt: Label 'Target Item %1 doesn''t exist.', comment = 'DEA="Zielartikel %1 existiert nicht."';
        Text013Txt: Label 'Comments', comment = 'DEA="Bemerkungen"';
        Text014Txt: Label 'Item units of measure', comment = 'DEA="Maßeinheiten Artikel"';
        Text015Txt: Label 'Item variants', comment = 'DEA="Artikelvarianten"';
        Text016Txt: Label 'Item translations', comment = 'DEA="Artikelübersetzungen"';
        Text017Txt: Label 'Extended texts', comment = 'DEA="Textbausteine"';
        Text018Txt: Label 'BOM components', comment = 'DEA="Stücklistenkomponenten"';
        Text021Txt: Label 'Item vendors', comment = 'DEA="Debitoren Artikel"';
        Text025Txt: Label 'copied.', comment = 'DEA="kopiert."';
        Text026Txt: Label 'Resource skills', comment = 'DEA="Ressourcenqualifikationen"';
        Text028Txt: Label 'Troubleshootings', comment = 'DEA="Lösungsanleitungen"';
        Text029Txt: Label 'Sales Prices', comment = 'DEA="VK-Preise"';
        Text030Txt: Label 'Sales Line Disc.', comment = 'DEA="VK-Zeilenrabatte"';
        Text031Txt: Label 'Purchase Prices', comment = 'DEA="EK-Preise"';
        Text032Txt: Label 'Purchase Line Disc.', comment = 'DEA="EK-Zeilenrabatte"';
        DialogTitleTxt: Text[50];
        DialogTxt: array[30] of Text[250];

    procedure CopyItem(_FromItemNo: Code[20]; _InItemNo: Code[20]);
    begin
        if not Item.Get(_FromItemNo) then
            Error(Text007Txt, _FromItemNo);

        if (_InItemNo = '') and (not CopyGenItemInfo) then
            Error(Text008Txt);

        ItemSetup.Get();

        if CopyGenItemInfo then
            InsertTargetItem(_InItemNo)
        else
            if not InItem.Get(_InItemNo) then
                Error(Text011Txt, _InItemNo);

        if not (CopySalesLineDisc or CopyPurchLineDisc) then begin
            InItem."Item Disc. Group" := '"';
            InItem.Modify();
        end;

        CopyItemPicture(Item, InItem);
        CopyItemComments(Item."No.", InItem."No.");
        CopyItemUnisOfMeasure(Item, InItem);
        CopyItemVariants(Item."No.", InItem."No.");
        CopyItemTranslations(Item."No.", InItem."No.");
        CopyExtendedTexts(Item."No.", InItem."No.");
        CopyBOMComponents(Item."No.", InItem."No.");
        CopyItemVendors(Item."No.", InItem."No.");
        CopyTroubleshootingSetup(Item."No.", InItem."No.");
        CopyItemResourceSkills(Item."No.", InItem."No.");
        CopyItemSalesPrices(Item."No.", InItem."No.");
        CopySalesLineDiscounts(Item."No.", InItem."No.");
        CopyPurchasePrices(Item."No.", InItem."No.");
        CopyPurchaseLineDiscounts(Item."No.", InItem."No.");
        CopyItemAttributes(Item."No.", InItem."No.");
    end;

    procedure InitDialog(Txt: Text[50]);
    begin
        RecCount := 0;
        CopyCount := CopyCount + 1;
        DialogTitleTxt := Txt;
        Window.Update(3, Txt);
        Window.Update(4, 0);
    end;

    procedure UpdateDialog();
    begin
        RecCount := RecCount + 1;
        Window.Update(4, RecCount);
    end;

    procedure EndDialog();
    begin
        if RecCount <> 0 then
            DialogTitleTxt := StrSubstNo('%1 %2', RecCount, DialogTitleTxt);
        DialogTitleTxt := copystr(DialogTitleTxt + ' ' + Text025Txt, 1, 50);
        DialogTxt[CopyCount] := DialogTitleTxt + '\"';
    end;

    procedure ItemDef(var Item2: Record Item);
    begin
        TmpItem := Item2;
    end;

    procedure ItemReturn(var ReturnItem: Record Item): Boolean;
    begin
        ReturnItem := InItem;
        exit(CopySuccessful);
    end;

    local procedure SetTargetItemNo(NewItemNo: Code[20]; var TargetItemNo: Code[20]; var TargetNoSeries: Code[20]);
    begin
        if NewItemNo = '' then
            if NewNoSeries <> '' then begin
                NoSeriesMgt.SetSeries(TargetItemNo);
                TargetNoSeries := NewNoSeries;
            end else begin
                ItemSetup.TestField("Item Nos.");
                NoSeriesMgt.InitSeries(ItemSetup."Item Nos.", Item."No. Series", 0D, TargetItemNo, TargetNoSeries);
            end
        else begin
            if InItem.Get(NewItemNo) then
                Error(Text010Txt, NewItemNo);
            if ItemSetup."Item Nos." <> '' then
                NoSeriesMgt.TestManual(ItemSetup."Item Nos.");

            TargetItemNo := NewItemNo;
            TargetNoSeries := '"';
        end
    end;

    local procedure InsertTargetItem(NewItemNo: Code[20]);
    var
        TempItemNo: Code[20];
        TempItemNoSeries: Code[20];
    begin
        InitDialog(Text009Txt);
        SetTargetItemNo(NewItemNo, TempItemNo, TempItemNoSeries);
        InItem.Copy(Item);
        InItem."No." := TempItemNo;
        InItem."No. Series" := TempItemNoSeries;
        InItem."Last Date Modified" := Today;
        InItem."Created From Nonstock Item" := false;
        InItem.Insert();
        EndDialog();
    end;

    local procedure CopyItemPicture(FromItem: Record Item; var ToItem: Record Item);
    begin
        if CopyPic then begin
            ToItem.Picture := FromItem.Picture;
            ToItem.Modify();
        end else begin
            Clear(ToItem.Picture);
            ToItem.Modify();
        end;
    end;

    local procedure CopyItemComments(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        CommentLine: Record "Comment Line";
    begin
        if not CopyComments then
            exit;

        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Item);
        CommentLine.SetRange("No.", FromItemNo);
        if CommentLine.FindSet() then begin
            InitDialog(Text013Txt);
            repeat
                CommentLine."No." := ToItemNo;
                CommentLine.Insert();
                CommentLine."No." := FromItemNo;
                UpdateDialog();
            until CommentLine.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyItemUnisOfMeasure(FromItem: Record Item; var ToItem: Record Item);
    var
        ItemUnitOfMeasure: Record "Item Unit of Measure";
    begin
        if CopyUnitOfMeasure then begin
            ItemUnitOfMeasure.SetRange("Item No.", FromItem."No.");
            if ItemUnitOfMeasure.FindSet() then begin
                InitDialog(Text014Txt);
                repeat
                    ItemUnitOfMeasure."Item No." := ToItem."No.";
                    ItemUnitOfMeasure.Insert();
                    ItemUnitOfMeasure."Item No." := FromItem."No.";
                    UpdateDialog();
                until ItemUnitOfMeasure.Next() = 0;
                EndDialog();
            end;
        end else
            if CopyGenItemInfo then begin
                ToItem."Base Unit of Measure" := '"';
                ToItem."Sales Unit of Measure" := '"';
                ToItem."Purch. Unit of Measure" := '"';
                ToItem."Put-away Unit of Measure Code" := '"';
                ToItem.Modify();
            end;
    end;

    local procedure CopyItemVariants(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        ItemVariant: Record "Item Variant";
    begin
        if not CopyVariants then
            exit;

        ItemVariant.SetRange("Item No.", FromItemNo);
        if ItemVariant.FindSet() then begin
            InitDialog(Text015Txt);
            repeat
                ItemVariant."Item No." := ToItemNo;
                ItemVariant.Insert();
                ItemVariant."Item No." := FromItemNo;
                UpdateDialog();
            until ItemVariant.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyItemTranslations(FromItemNo: Code[20]; ToItemNo: Code[20]);
    begin
        if not CopyTranslations then
            exit;

        ItemTranslation.SetRange("Item No.", FromItemNo);
        if not CopyVariants then
            ItemTranslation.SetRange("Variant Code", '');
        if ItemTranslation.FindSet() then begin
            InitDialog(Text016Txt);
            repeat
                ItemTranslation.Init();
                ItemTranslation."Item No." := ToItemNo;
                ItemTranslation.Insert();
                ItemTranslation."Item No." := FromItemNo;
                UpdateDialog();
            until ItemTranslation.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyExtendedTexts(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        ExtendedTextHeader: Record "Extended Text Header";
        ExtendedTextLine: Record "Extended Text Line";
    begin
        if not CopyExtTxt then
            exit;

        ExtendedTextHeader.SetRange("Table Name", ExtendedTextHeader."Table Name"::Item);
        ExtendedTextHeader.SetRange("No.", FromItemNo);
        if ExtendedTextHeader.FindSet() then begin
            InitDialog(Text017Txt);
            repeat
                ExtendedTextLine.SetRange("Table Name", ExtendedTextHeader."Table Name");
                ExtendedTextLine.SetRange("No.", ExtendedTextHeader."No.");
                ExtendedTextLine.SetRange("Language Code", ExtendedTextHeader."Language Code");
                ExtendedTextLine.SetRange("Text No.", ExtendedTextHeader."Text No.");
                if ExtendedTextLine.FindSet() then
                    repeat
                        ExtendedTextLine."No." := ToItemNo;
                        ExtendedTextLine.Insert();
                        ExtendedTextLine."No." := FromItemNo;
                    until ExtendedTextLine.Next() = 0;

                ExtendedTextHeader."No." := ToItemNo;
                ExtendedTextHeader.Insert();
                ExtendedTextHeader."No." := FromItemNo;
                UpdateDialog();
            until ExtendedTextHeader.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyBOMComponents(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        BOMComponent: Record "BOM Component";
    begin
        if not CopyBOM then
            exit;

        BOMComponent.SetRange("Parent Item No.", FromItemNo);
        if BOMComponent.FindSet() then begin
            InitDialog(Text018Txt);
            repeat
                BOMComponent."Parent Item No." := ToItemNo;
                BOMComponent.Insert();
                BOMComponent."Parent Item No." := FromItemNo;
                UpdateDialog();
            until BOMComponent.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyItemVendors(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        ItemVendor2: Record "Item Vendor";
    begin
        if not CopyItemVendor then
            exit;

        ItemVendor2.SetRange("Item No.", FromItemNo);
        if ItemVendor2.FindSet() then begin
            InitDialog(Text021Txt);
            repeat
                ItemVendor2."Item No." := ToItemNo;
                ItemVendor2.Insert();
                ItemVendor2."Item No." := FromItemNo;
                UpdateDialog();
            until ItemVendor2.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyTroubleshootingSetup(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        TroubleshootingSetup: Record "Troubleshooting Setup";
    begin
        if not CopyTroubleshooting then
            exit;

        TroubleshootingSetup.SetRange(Type, TroubleshootingSetup.Type::Item);
        TroubleshootingSetup.SetRange("No.", FromItemNo);
        if TroubleshootingSetup.FindSet() then begin
            InitDialog(Text028Txt);
            repeat
                TroubleshootingSetup."No." := ToItemNo;
                TroubleshootingSetup.Insert();
                TroubleshootingSetup."No." := FromItemNo;
                UpdateDialog();
            until TroubleshootingSetup.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyItemResourceSkills(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        ResourceSkill: Record "Resource Skill";
    begin
        if not CopyResourceSkills then
            exit;

        ResourceSkill.SetRange(Type, ResourceSkill.Type::Item);
        ResourceSkill.SetRange("No.", FromItemNo);
        if ResourceSkill.FindSet() then begin
            InitDialog(Text026Txt);
            repeat
                ResourceSkill."No." := ToItemNo;
                ResourceSkill.Insert();
                ResourceSkill."No." := FromItemNo;
                UpdateDialog();
            until ResourceSkill.Next() = 0;
            EndDialog();
        end;
    end;

    local procedure CopyItemSalesPrices(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        SalesPrice: Record "Sales Price";
    begin
        if not CopySalesPrices then
            exit;

        SalesPrice.SetRange("Item No.", FromItemNo);
        if SalesPrice.FindSet() then begin
            InitDialog(Text029Txt);
            repeat
                SalesPrice."Item No." := ToItemNo;
                SalesPrice.Insert();
                SalesPrice."Item No." := FromItemNo;
                UpdateDialog();
            until SalesPrice.Next() = 0;
        end;
    end;

    local procedure CopySalesLineDiscounts(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        SalesLineDiscount: Record "Sales Line Discount";
    begin
        if not CopySalesLineDisc then
            exit;

        SalesLineDiscount.SetRange(Type, SalesLineDiscount.Type::Item);
        SalesLineDiscount.SetRange(Code, FromItemNo);
        if SalesLineDiscount.FindSet() then begin
            InitDialog(Text030Txt);
            repeat
                SalesLineDiscount.Code := ToItemNo;
                SalesLineDiscount.Insert();
                SalesLineDiscount.Code := FromItemNo;
                UpdateDialog();
            until SalesLineDiscount.Next() = 0;
        end;
    end;

    local procedure CopyPurchasePrices(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        PurchasePrice: Record "Purchase Price";
    begin
        if not CopyPurchPrices then
            exit;

        PurchasePrice.SetRange("Item No.", FromItemNo);
        if PurchasePrice.FindSet() then begin
            InitDialog(Text031Txt);
            repeat
                PurchasePrice."Item No." := ToItemNo;
                PurchasePrice.Insert();
                PurchasePrice."Item No." := FromItemNo;
                UpdateDialog();
            until PurchasePrice.Next() = 0;
        end;
    end;

    local procedure CopyPurchaseLineDiscounts(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        PurchLineDiscount: Record "Purchase Line Discount";
    begin
        if not CopyPurchLineDisc then
            exit;

        PurchLineDiscount.SetRange("Item No.", FromItemNo);
        if PurchLineDiscount.FindSet() then begin
            InitDialog(Text032Txt);
            repeat
                PurchLineDiscount."Item No." := ToItemNo;
                PurchLineDiscount.Insert();
                PurchLineDiscount."Item No." := FromItemNo;
                UpdateDialog();
            until PurchLineDiscount.Next() = 0;
        end;
    end;

    local procedure CopyItemAttributes(FromItemNo: Code[20]; ToItemNo: Code[20]);
    var
        ItemAttributeValueMapping: Record "Item Attribute Value Mapping";
        NewItemAttributeValueMapping: Record "Item Attribute Value Mapping";
    begin
        if not CopyAttributes then
            exit;

        ItemAttributeValueMapping.SetRange("Table ID", Database::Item);
        ItemAttributeValueMapping.SetRange("No.", FromItemNo);
        if ItemAttributeValueMapping.FindSet() then
            repeat
                NewItemAttributeValueMapping := ItemAttributeValueMapping;
                NewItemAttributeValueMapping."No." := ToItemNo;
                NewItemAttributeValueMapping.Insert();
            until ItemAttributeValueMapping.Next() = 0;
    end;
}

