// page 50008 TestDocInfo
// {
//     PageType = Card;
//     SourceTable = DocInfoNVX;

//     layout
//     {
//         area(content)
//         {
//             repeater(GroupName)
//             {
//                 field(Department;Rec.Department)
//                 {
                    
//                 }
//                 field("Document No.";Rec."Document No.")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field("Document Type";Rec."Document Type")
//                 {
//                     ApplicationArea = All;
//                 }
//                 field(Dim1;Rec."Shortcut Dimension 1 Code")
//                 {
//                     ApplicationArea = All;
//                 }         
//                 field(Dim3;Rec."Shortcut Dimension 3 Code")
//                 {
//                     ApplicationArea = All;
//                 }                       
//                 field("interimdingens";Rec."Interim Gen.Bus.Posting Group")
//                 {
//                     ApplicationArea = All;
//                 }                
//             }
//         }
//     }

//     actions
//     {
//         area(processing)
//         {
//             action(ActionName)
//             {
//                 trigger OnAction();
//                 begin
//                 end;
//             }
//         }
//     }
    
//     var
//         myInt : Integer;
// }