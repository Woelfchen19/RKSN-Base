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
                field(AllowChangeLogEntryDim; Rec.AllowChangeLogEntryDim)
                {
                    ToolTip = 'Specifies the value of the Allow Change LogEntryDimension field.', Comment = 'DEA="Änderung der Tabelle Änderungsprotokollposten Dimensionen"';
                    ApplicationArea = All;
                }
                field("Test User ID"; Rec."Test User ID")
                {
                    ToolTip = 'Specifies the value of the Test User ID field.', Comment = 'DEA="Testbenutzer"';
                    ApplicationArea = All;
                }
                field(AcitveChangeLogEntryDim; Rec.AcitveChangeLogEntryDim)
                {
                    ToolTip = 'Specifies the value of the Activate ChangeLogEntry Dimension field.', Comment = 'DEA="Änderungsprotokol Dimension aktivieren"';
                    ApplicationArea = All;
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
                Caption = 'Setup PropertyForField insert', comment = 'DEA="Einrichtung Eigenschaften der Felder befüllen"';
                ApplicationArea = All;
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
