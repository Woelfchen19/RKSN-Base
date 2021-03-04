codeunit 50002 Table15HookNVX
{

    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterValidateEvent', 'Gen. Prod. Posting Group', false, false)]
    //RKSN-36
    local procedure CheckInventoryValueZero(var Rec: Record "G/L Account")
    var
        GenPrdPstGrp: Record GenPrdPstGrpNVX;
        WrongPrdPstGrpErr: Label 'You are not allowed to use this Product Posting Group in this context. It belongs to the Datawarehouse', comment = 'DEA="Es ist nicht möglich, diese Produktbuchungsgruppe zuzuordnen, da diese zum Datawarehouse gehört!"';
    begin
        IF GenPrdPstGrp.Get(Rec."Gen. Prod. Posting Group") then
            IF (GenPrdPstGrp."Inventory Value Zero" <> GenPrdPstGrp."Inventory Value Zero"::"No Item") then
                Error(WrongPrdPstGrpErr);
    end;

}