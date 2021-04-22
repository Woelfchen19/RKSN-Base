codeunit 50002 "Table15HookNVX"
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

    [EventSubscriber(ObjectType::Table, Database::"G/L Account", 'OnAfterValidateEvent', 'Gen. Posting Type', false, false)]
    local procedure SetGenBsnPostingGroupType(Rec: Record "G/L Account")
    var
        GLAccountNVX: Record GLAccountNVX;
    begin
        IF (Rec."No." = '') OR Rec.IsTemporary then
            exit;
        IF not GLAccountNVX.Get(Rec."No.") then begin
            GLAccountNVX.Init();
            GLAccountNVX."G/L Account No." := Rec."No.";
            GLAccountNVX.Insert();
        end;
        IF Rec."Gen. Posting Type" = Rec."Gen. Posting Type"::Sale then begin
            GLAccountNVX."Gen. Bsn. Posting Group Type" := GLAccountNVX."Gen. Bsn. Posting Group Type"::Standard;
            GLAccountNVX.Modify();
        end;
    end;

}