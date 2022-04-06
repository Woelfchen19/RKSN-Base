pageextension 50033 GenBsnPstGrpNVX extends "Gen. Business Posting Groups"
{
    layout
    {
        addlast(Control1)
        {
            field("Filter Customer NVX"; GenBsnPstGrp."Filter Customer")
            {
                ApplicationArea = All;
                Caption = 'Filter Master Data Customer', comment = 'DEA="Filter Stammdaten Debitor"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Sales Quote NVX"; GenBsnPstGrp."Filter Sales Quote")
            {
                ApplicationArea = All;
                Caption = 'Filter Sales Quote', comment = 'DEA="Filter Angebot"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Sales Order NVX"; GenBsnPstGrp."Filter Sales Order")
            {
                ApplicationArea = All;
                Caption = 'Filter Sales Order', comment = 'DEA="Filter Auftrag"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Sales Invoice NVX"; GenBsnPstGrp."Filter Sales Invoice")
            {
                ApplicationArea = All;
                Caption = 'Filter Sales Invoice', comment = 'DEA="Filter Erfassung VK-Rechnung"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Sales Cr. Memo NVX"; GenBsnPstGrp."Filter Sales Cr. Memo")
            {
                ApplicationArea = All;
                Caption = 'Filter Sales Credit Memo', comment = 'DEA="Filter Erfassung VK-Gutschriftsrechnung"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Vendor NVX"; GenBsnPstGrp."Filter Vendor")
            {
                ApplicationArea = All;
                Caption = 'Filter Master Data Vendor', comment = 'DEA="Filter Stammdaten Kreditor"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Purchase Quote NVX"; GenBsnPstGrp."Filter Purchase Quote")
            {
                ApplicationArea = All;
                Caption = 'Filter Purchase Quote', comment = 'DEA="Filter Anfrage"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Purchase Order NVX"; GenBsnPstGrp."Filter Purchase Order")
            {
                ApplicationArea = All;
                Caption = 'Filter Purchase Order', comment = 'DEA="Filter Bestellung"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Purchase Invoice NVX"; GenBsnPstGrp."Filter Purchase Invoice")
            {
                ApplicationArea = All;
                Caption = 'Filter Purchase Invoice', comment = 'DEA="Filter Erfassung EK-Rechnung"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Purchase Cr. Memo NVX"; GenBsnPstGrp."Filter Purchase Cr. Memo")
            {
                ApplicationArea = All;
                Caption = 'Filter Purchase Credit Memo', comment = 'DEA="Filter Erfassung EK-Gutschriftsrechnung"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter G/L Account NVX"; GenBsnPstGrp."Filter G/L Account")
            {
                ApplicationArea = All;
                Caption = 'Filter G/L Account', comment = 'DEA="Kontenplan"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
            field("Filter Item Journal NVX"; GenBsnPstGrp."Filter Item Journal")
            {
                ApplicationArea = All;
                Caption = 'Filter Item Journal', comment = 'DEA="Artikelbuchblatt"';
                trigger OnValidate();
                begin
                    GenBsnPstGrp.Modify();
                end;
            }
        }
        addlast(Content)
        {
            part(PstTypeMatrixNVX; PstTypeMatrixNVX)
            {
                ApplicationArea = All;
                Caption = 'Matrix General Business Posting Group_VAT Posting Type', comment = 'DEA="Matrix Geschäftsbuchungsgruppe_USt Buchungsart"';
                SubPageLink = "Code" = field(Code);
            }
        }
    }

    actions
    {
        addlast(Processing)
        {
            action(ShowAllNVX)
            {
                ApplicationArea = All;
                Caption = 'Show all', comment = 'DEA="Alle anzeigen"';
                Promoted = true;
                PromotedCategory = Process;
                Image = ClearFilter;
                ToolTip = 'Clears all filter.', comment = 'DEA="Hebt alle Filter auf."';

                trigger OnAction()
                begin
                    Reset();
                end;
            }
        }
    }

    var
        GenBsnPstGrp: Record GenBsnPstGrpNVX;

    trigger OnAfterGetRecord();
    begin
        if not GenBsnPstGrp.Get(Code) then begin
            GenBsnPstGrp.Init();
            GenBsnPstGrp.Code := Code;
            GenBsnPstGrp.Insert();
        end;

        CurrPage.PstTypeMatrixNVX.Page.Load();
    end;

    trigger OnQueryClosePage(CloseAction: Action): Boolean;
    var
        BsnPstGrpVATPstTypeNVX: Record BsnPstGrpVATPstTypeNVX;
        GenBusinessPostingGroup: Record "Gen. Business Posting Group";
        VATPostingType: Record VATPostingTypeNVX;
        NoOfTypes: Integer;
        MissingTypeErr: Label 'You must specify all VAT Posting Groups for Gen. Business Posting Group %1', comment = 'DEA="Sie müssen für die Geschäftsbuchungsgruppe %1 alle Ust.-Buchungsarten definieren!"';
    begin
        if LookupMode then
            exit(true);
        if CloseAction = CloseAction::OK then begin
            VATPostingType.Reset();
            NoOfTypes := VATPostingType.Count();
            GenBusinessPostingGroup.Reset();
            if GenBusinessPostingGroup.FindSet() then
                repeat
                    BsnPstGrpVATPstTypeNVX.SetRange("Gen. Bus. Posting Group", GenBusinessPostingGroup.Code);
                    BsnPstGrpVATPstTypeNVX.SetFilter(BsnPstGrpVATPstTypeNVX."VAT Posting Type", '<>%1', '');
                    BsnPstGrpVATPstTypeNVX.SetFilter("Gen. Bus. Posting Group2", '<>%1', '');
                    if BsnPstGrpVATPstTypeNVX.Count() <> NoOfTypes then
                        Error(MissingTypeErr, GenBusinessPostingGroup.Code);
                until GenBusinessPostingGroup.Next() = 0;
            exit(true);
        end;
    end;
}