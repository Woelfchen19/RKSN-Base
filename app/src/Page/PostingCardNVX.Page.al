page 50014 PostingCardNVX
{
    PageType = Card;
    SourceTable = PostingsNVX;
    InsertAllowed = false;
    DeleteAllowed = false;
    Editable = false;
    layout
    {
        area(content)
        {
            group(General)
            {
                field("Posting GUID"; "Posting GUID")
                {
                    ApplicationArea = All;
                }
                // field("Posting Date";"Posting Date")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }
                // field("Document No.";"Document No.")
                // {
                //     ApplicationArea = All;
                //     Editable = false;
                // }           
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
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = GLVisible;
            }
            part(GLSummary; GenJnlLineArchiveSummaryNVX)
            {
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = GLVisible;
            }
            part(GLPreparation; GenJnlLineArchivePrepNVX)
            {
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = GLVisible;
            }
            part(GLComplete; GenJnlArchiveCompleteNVX)
            {
                Caption = 'Complete', comment = 'DEA="Vollständig"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = GLVisible;
            }

            //FA Parts
            part(FAOrigin; FAJnlLineArchiveOriginNVX)
            {
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = FAVisible;
            }
            part(FASummary; FAJnlLineArchiveSummaryNVX)
            {
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = FAVisible;
            }
            part(FAPreparation; FAJnlLineArchivePrepNVX)
            {
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = FAVisible;
            }
            part(FAComplete; FAJnlLineArchiveCompleteNVX)
            {
                Caption = 'Complete', comment = 'DEA="Vollständig"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = FAVisible;
            }
            
            //Purchase Line parts
            part(PurchOrigin; PurchLineArchiveOriginNVX)
            {
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = PurchVisible;
            }
            part(PurchSummary; PurchLineArchiveSummaryNVX)
            {
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = PurchVisible;
            }
            part(PurchPreparation; PurchLineArchivePrepNVX)
            {
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = PurchVisible;
            }
            part(PurchComplete; PurchLineArchiveCompleteNVX)
            {
                Caption = 'Complete', comment = 'DEA="Vollständig"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = PurchVisible;
            }

            //Sales Line Parts
            part(SalesOrigin; SalesLineArchiveOriginNVX)
            {
                Caption = 'Origin', comment = 'DEA="Ursprung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = SalesVisible;
            }
            part(SalesSummary; SalesLineArchiveSummaryNVX)
            {
                Caption = 'Summary', comment = 'DEA="Zusammenfassung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = SalesVisible;
            }
            part(SalesPreparation; SalesLineArchivePrepNVX)
            {
                Caption = 'Preparation', comment = 'DEA="Vorbereitung"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = SalesVisible;
            }       
            part(SalesComplete; SalesLineArchiveCompleteNVX)
            {
                Caption = 'Complete', comment = 'DEA="Vollständig"';
                SubPageLink = "Posting GUID" = field ("Posting GUID");
                Visible = PurchVisible;
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
        GLVisible: Boolean;
        FAVisible: Boolean;
        PurchVisible: Boolean;
        SalesVisible: Boolean;

}