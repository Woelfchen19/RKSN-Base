// table 50008 PstdDocInfoNVX
// {
//     DataClassification = CustomerContent;
    
//     fields
//     {
//         field(1;Department;Option)
//         {
//             DataClassification = CustomerContent;
//             OptionMembers = Sales,Purchase;
//             OptionCaption = 'Sales,Purchase', comment = 'DEA="Verkauf,Einkauf"';
//             Caption = 'Department', comment = 'DEA="Modul"';            
//         }
//         field(2;"Document Type";Option)
//         {
//             DataClassification = CustomerContent;
//             OptionMembers = Invoice,"Credit Memo",Shipment,"Return Receipt";
//             OptionCaption = 'Quote,Order,Invoice,Credit Memo,Blanket Order",Return Order', comment = 'DEA="Quote,Order,Invoice,Credit Memo,Blanket Order,Return Order"';
//             Caption = 'Document Type', comment = 'DEA="Belegart"';
//         }
//         field(5;"Document No.";Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Document No.', comment = 'DEA="Belegnr."';
//         }
//         field(10;"Shortcut Dimension 1 Code";Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Shortcut Dimension 1 Code', comment = 'DEA="Shortcutdimensionscode 1"';
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(1));            
//             // CaptionClass = '1338,1'; = Sales + Dim Name
//             // CaptionClass = '1339,1'; = Purchase + Dim Name
//         }
//         field(11;"Shortcut Dimension 3 Code";Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Shortcut Dimension 3 Code', comment = 'DEA="Shortcutdimensionscode 3"';
//             // CaptionClass = '1338,3'; = Sales + Dim Name
//             // CaptionClass = '1339,3'; = Purchase + Dim Name            
//             TableRelation = "Dimension Value".Code WHERE("Global Dimension No." = CONST(3));
//         }
//         field(15;"Interim Gen.Bus.Posting Group";Code[20])
//         {
//             DataClassification = CustomerContent;
//             Caption = 'Interim Gen. Bus. Posting Group', comment = 'DEA="Interim Steuerschlüssel"';
//             TableRelation = "Gen. Business Posting Group".Code;
//         }

//     }

//     keys
//     {
//         key(PK;Department,"Document Type","Document No.")
//         {
//             Clustered = true;
//         }
//     }

// }