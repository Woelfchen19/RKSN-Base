page 50034 SetupReminderExtensionCardNVX
{
    Caption = 'Setup Reminder Extension', comment = 'DEA="Einrichtung Erweiterung Mahnung"';
    PageType = Card;
    SourceTable = SetupReminderExtensionNVX;
    UsageCategory = Administration;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(AcitveChangeLogEntryDim; Rec.ActiveChangeLogEntryDim)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Activate ChangeLogEntry Dimension field.', Comment = 'DEA="Änderungsprotokol Dimension aktivieren"';
                }
                field(ActivateBusinessFilterInPages; Rec.ActivateBusinessFilterInPages)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Active Filter BusinessFields for Pages field.', Comment = 'DEA="Filter Geschäftsfelder für Pages aktivieren"';
                }
                field(AllowEmptyfilter; Rec.AllowEmptyfilter)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the use also empty filter field.', Comment = 'DEA="Leeren Filter berücksichten"';
                }
                field("Test User Activate"; Rec."Test User Activate")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test User Activate field.', Comment = 'DEA="Testbenutzer aktiviert"';
                }
                field("Test User ID"; Rec."Test User ID")
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Test User ID field.', Comment = 'DEA="Testbenutzer"';
                }
                field(WebSiteIBAN; Rec.WebSiteIBAN)
                {
                    ApplicationArea = All;
                    ToolTip = 'Specifies the value of the Website IBAN field.', Comment = 'DEA="Webseite IBAN"';
                }
            }
        }
    }
    actions
    {
        area(Processing)
        {
            Action(InsertSetupPropertyForField)
            {
                ApplicationArea = All;
                Caption = 'Setup PropertyForField insert', comment = 'DEA="Einrichtung Eigenschaften der Felder befüllen"';
                Image = Setup;

                trigger OnAction()
                var
                    AppMgt: Codeunit AppMgtNVX;
                begin
                    AppMgt.InsertSetupPropertyForField();
                end;
            }
        }
    }

    trigger OnOpenPage()
    begin
        if not Get() then begin
            init();
            insert();
        end;
    end;

    trigger OnClosePage()
    begin
        Rec.RefreshUserSetup();
    end;
}
