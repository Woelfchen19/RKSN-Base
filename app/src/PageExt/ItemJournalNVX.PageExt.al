pageextension 50017 "ItemJournalNVX" extends "Item Journal"
{
    layout
    {
        modify("Gen. Bus. Posting Group")
        {
            trigger OnLookup(var Text: Text) : Boolean;
            var
                GBPGRec: Record "Gen. Business Posting Group";
                GenBsnPstGrpNVX: Record GenBsnPstGrpNVX;
                GBPGPage: Page "Gen. Business Posting Groups";
            begin
                Clear(GBPGPage);
                GBPGRec.Reset();
                repeat
                    if GenBsnPstGrpNVX.Get(GBPGRec.Code) and GenBsnPstGrpNVX."Filter Item Journal" then
                        GBPGRec.Mark(true);
                until GBPGRec.Next() = 0;
                GBPGRec.MarkedOnly(true);
                GBPGPage.SetRecord(GBPGRec);
                GBPGPage.SetTableView(GBPGRec);
                GBPGPage.LookupMode(true);
                if GBPGPage.RunModal() = "Action"::LookupOK then begin
                    GBPGPage.GetRecord(GBPGRec);
                    Rec.Validate("Gen. Bus. Posting Group",GBPGRec.Code);
                end;
            end;
        }
    //     modify("Shortcut Dimension 1 Code")
    //     {
    //         trigger OnAfterValidate()
    //         var
    //             Item: Record Item;
    //             InvSetupNVX: Record InvSetupNVX;
    //             WrongDimErr: Label 'Item has inventory value. Dimension have to match the setup.', Comment = 'DEA="Der erfasste Artikel ist lagerbewertet eingerichtet. Die Angaben zu Kostenstelle und Sparte müssen dem setup der Lager Einrichtung entsprechen!"';
    //         begin
    //             Item.Get("Item No.");
    //             Case Item."Inventory Value Zero" of
    //                 true:
    //                     TestField("Shortcut Dimension 1 Code");
    //                 false:
    //                     begin
    //                         InvSetupNVX.Get();
    //                         if "Shortcut Dimension 1 Code" <> InvSetupNVX."Inventory Cost Center" then
    //                             Error(WrongDimErr);
    //                     end;
    //             end; //of Case
    //         end;
    //     }     
    }
}