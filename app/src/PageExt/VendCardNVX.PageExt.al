pageextension 50011 "VendCardNVX" extends "Vendor Card"
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
                    if GenBsnPstGrpNVX.Get(GBPGRec.Code) and GenBsnPstGrpNVX."Filter Vendor" then
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
    }
}