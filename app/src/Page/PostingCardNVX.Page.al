page 50012 PostingCardNVX
{
    PageType = Card;
    SourceTable = PostingsNVX;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    Caption = 'Dimensional Distribution Archive', comment = 'DEA="Sicherung dim.Verteilungen"';
    DataCaptionExpression = 'Sicherung dim.Verteilungen';
    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Posting GUID"; "Posting GUID")
                {
                    ApplicationArea = All;
                }
                field("Source Journal Line"; "Source Journal Line")
                {
                    ApplicationArea = All;
                }
                field("Date"; "Date")
                {
                    ApplicationArea = All;
                }
                field("Time"; "Time")
                {
                    ApplicationArea = All;
                }
                field("User ID"; "User ID")
                {
                    ApplicationArea = All;
                }
            }
            //GL Parts
            part(GLOrigin; GenJnlLineArchiveOriginNVX)
            {
                ApplicationArea = All;
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = GLVisible;
            }
            part(GLSummary; GenJnlLineArchiveSummaryNVX)
            {
                ApplicationArea = All;
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = GLVisible;
            }
            part(GLPreparation; GenJnlLineArchivePrepNVX)
            {
                ApplicationArea = All;
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = GLVisible;
            }
            //FA Parts
            part(FAOrigin; FAJnlLineArchiveOriginNVX)
            {
                ApplicationArea = All;
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = FAVisible;
            }
            part(FASummary; FAJnlLineArchiveSummaryNVX)
            {
                ApplicationArea = All;
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = FAVisible;
            }
            part(FAPreparation; FAJnlLineArchivePrepNVX)
            {
                ApplicationArea = All;
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = FAVisible;
            }
            //Purchase Line parts
            part(PurchOrigin; PurchLineArchiveOriginNVX)
            {
                ApplicationArea = All;
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = PurchVisible;
            }
            part(PurchSummary; PurchLineArchiveSummaryNVX)
            {
                ApplicationArea = All;
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = PurchVisible;
            }
            part(PurchPreparation; PurchLineArchivePrepNVX)
            {
                ApplicationArea = All;
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = PurchVisible;
            }
            //Sales Line Parts
            part(SalesOrigin; SalesLineArchiveOriginNVX)
            {
                ApplicationArea = All;
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = SalesVisible;
            }
            part(SalesSummary; SalesLineArchiveSummaryNVX)
            {
                ApplicationArea = All;
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = SalesVisible;
            }
            part(SalesPreparation; SalesLineArchivePrepNVX)
            {
                ApplicationArea = All;
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field("Posting GUID");
                Visible = SalesVisible;
            }
        }
    }

    trigger OnOpenPage();
    begin
        CurrPage.Editable(false);
    end;

    trigger OnAfterGetRecord();
    begin
        GLVisible := "Source Journal Line" = "Source Journal Line"::GenJnlLine;
        FAVisible := "Source Journal Line" = "Source Journal Line"::FAJnlLine;
        PurchVisible := "Source Journal Line" = "Source Journal Line"::PurchaseLine;
        SalesVisible := "Source Journal Line" = "Source Journal Line"::SalesLine;
    end;

    var
        FAVisible: Boolean;
        GLVisible: Boolean;
        PurchVisible: Boolean;
        SalesVisible: Boolean;
}