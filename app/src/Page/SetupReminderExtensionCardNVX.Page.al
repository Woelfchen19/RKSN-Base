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
                field(WebSiteIBAN; Rec.WebSiteIBAN)
                {
                    ApplicationArea = All;
                }
                field(ActivateBusinessFilterInPages; Rec.ActivateBusinessFilterInPages)
                {
                    ApplicationArea = All;
                }
                field(AllowEmptyfilter; Rec.AllowEmptyfilter)
                {
                    ToolTip = 'Specifies the value of the use also empty filter field.', Comment = 'DEA="Leeren Filter berücksichten"';
                    ApplicationArea = All;
                }
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
