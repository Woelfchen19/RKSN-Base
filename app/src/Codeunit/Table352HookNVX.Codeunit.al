// codeunit 50011 Table352HookNVX
// {
//     // [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterInsertEvent', '', false, false)]
//     // local procedure ItemCheckDimensionAfterInsert(Rec: Record "Default Dimension")
//     // var
//     //     Item: Record Item;
//     //     GLSetup: Record "General Ledger Setup";
//     //     InvSetupNVX: Record InvSetupNVX;
//     //     InvValueZeroErr: Label 'This item has no inventory value. Cost Center and Section are obligatory. Values set up in the inventory setup are not allowed for items without inventory value.', 
//     //     comment = 'DEA="Der Artikel ist nicht lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte ist pflichtig. Darüber hinaus dürfen die Dimensionswerte aus der Lager-Einrichtung für nicht lagerbewertete Artikel nicht zugeordnet werden!"';
//     //     InvValueErr: Label 'This item has inventory value. Cost Center and Section are obligatory. Only values set up in the inventory setup are allowed for items with inventory value., ',
//     //     comment = 'DEA="Der Artikel ist lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte muss der Lager-Einrichtung entsprechen"';
//     // begin
//     //     IF Rec."Table ID" <> 27 then
//     //         exit;

//     //     GLSetup.Get();
//     //     InvSetupNVX.Get();

//     //     case Rec."Dimension Code" of

//     //         GLSetup."Global Dimension 1 Code":
//     //             begin
//     //                 Item.Get(Rec."No.");
//     //                 case Item."Inventory Value Zero" of
//     //                     true:
//     //                         IF Rec."Dimension Value Code" = InvSetupNVX."Inventory Cost Center" then
//     //                             Error(InvValueZeroErr);
//     //                     false:
//     //                         IF Rec."Dimension Value Code" <> InvSetupNVX."Inventory Cost Center" then
//     //                             Error(InvValueErr);
//     //                 end;                    
//     //             end;
                
//     //         GLSetup."Shortcut Dimension 3 Code":
//     //             begin
//     //                 Item.Get(Rec."No.");
//     //                 case Item."Inventory Value Zero" of
//     //                     true:
//     //                         IF Rec."Dimension Value Code" = InvSetupNVX."Inventory Section" then
//     //                             Error(InvValueZeroErr);
//     //                     false:
//     //                         IF Rec."Dimension Value Code" <> InvSetupNVX."Inventory Section" then
//     //                             Error(InvValueErr);
//     //                 end;              
//     //             end;

//     //     end;
//     // end;


//     [EventSubscriber(ObjectType::Table, Database::"Default Dimension", 'OnAfterValidateEvent', 'Dimension Value Code', false, false)]
//     local procedure ItemCheckDimensionAfterValidateValueCode(Rec: Record "Default Dimension")
//     var
//         Item: Record Item;
//         GLSetup: Record "General Ledger Setup";
//         InvSetupNVX: Record InvSetupNVX;
//         InvValueZeroErr: Label 'This item has no inventory value. Cost Center and Section are obligatory. Values set up in the inventory setup are not allowed for items without inventory value.', 
//         comment = 'DEA="Der Artikel ist nicht lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte ist pflichtig. Darüber hinaus dürfen die Dimensionswerte aus der Lager-Einrichtung für nicht lagerbewertete Artikel nicht zugeordnet werden!"';
//         InvValueErr: Label 'This item has inventory value. Cost Center and Section are obligatory. Only values set up in the inventory setup are allowed for items with inventory value., ',
//         comment = 'DEA="Der Artikel ist lagerbewertet eingerichtet. Das Setup zu Kostenstelle und Sparte muss der Lager-Einrichtung entsprechen"';    
//     begin
    //     IF Rec."Table ID" <> 27 then
    //         exit;

    //     GLSetup.Get();
    //     InvSetupNVX.Get();

    //     case Rec."Dimension Code" of

    //         GLSetup."Global Dimension 1 Code":
    //             begin
    //                 Item.Get(Rec."No.");
    //                 case Item."Inventory Value Zero" of
    //                     true:
    //                         IF Rec."Dimension Value Code" = InvSetupNVX."Inventory Cost Center" then
    //                             Error(InvValueZeroErr);
    //                     false:
    //                         IF Rec."Dimension Value Code" <> InvSetupNVX."Inventory Cost Center" then
    //                             Error(InvValueErr);
    //                 end;                    
    //             end;
                
    //         GLSetup."Shortcut Dimension 3 Code":
    //             begin
    //                 Item.Get(Rec."No.");
    //                 case Item."Inventory Value Zero" of
    //                     true:
    //                         IF Rec."Dimension Value Code" = InvSetupNVX."Inventory Section" then
    //                             Error(InvValueZeroErr);
    //                     false:
    //                         IF Rec."Dimension Value Code" <> InvSetupNVX."Inventory Section" then
    //                             Error(InvValueErr);
    //                 end;              
    //             end;

    //     end;
    // end;
// }