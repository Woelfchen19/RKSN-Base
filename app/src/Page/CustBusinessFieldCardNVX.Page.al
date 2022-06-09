page 50032 "CustBusinessFieldCardNVX"
{
    Caption = 'Customer Card BusinessField', comment = 'DEA="Debitorenkarte Geschäftsfeld"';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = CustomerBusinessFieldNVX;
    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General', comment = 'DEA="Allgemein"';
                group(BusinessFields)
                {
                    Caption = 'Business Field', comment = 'DEA="Geschäftsfeld"';
                    field(Dimension5Name; Rec.ShortcutdimensionCode5Name)
                    {
                        ToolTip = 'Specifies the value of the Shortcut Dimension 5 Name field.';
                        ApplicationArea = All;
                        ShowCaption = false;
                    }
                    field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                    {
                        ApplicationArea = All;
                        Visible = false;
                    }
                }
                group(ShortcutDimension9Code)
                {
                    Caption = 'SAMMELKto', comment = 'DEA="Sammelkonto"';
                    field(ShortcutdimensionCode9Name; Rec.ShortcutdimensionCode9Name)
                    {
                        ShowCaption = false;
                        ToolTip = 'Specifies the value of the Shortcut Dimension 9 Name field.', Comment = 'DEA="Name"';
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            UpdateShortcutdimensionCode9Description();
                        end;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            UpdateShortcutdimensionCode9Description();
                        end;
                    }
                    field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
                    {
                        ApplicationArea = All;
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Shortcut Dimension 9 Code" := AppMgt.OnLookupByBusinessFieldDimension(Rec."Shortcut Dimension 5 Code", 9);
                        end;
                    }
                }
                group(InfoUser)
                {
                    Caption = 'Info User', comment = 'DEA="Benutzerinformationen"';

                    field("Created By User"; Rec."Created By User")
                    {
                        ToolTip = 'Specifies the value of the Created By User field.';
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Creation Date"; Rec."Creation Date")
                    {
                        ToolTip = 'Specifies the value of the Creation Date field.';
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Last Modified By User"; Rec."Last Modified By User")
                    {
                        ToolTip = 'Specifies the value of the Last Modified By User field.';
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                    field("Last Modified Date"; Rec."Last Modified Date")
                    {
                        ToolTip = 'Specifies the value of the Last Modified Date field.';
                        ApplicationArea = All;
                        Importance = Additional;
                    }
                }
                group(Payment)
                {
                    Caption = 'Payment Management', comment = 'DEA="Zahlungsmanagement"';
                    field("Reminder Terms Code"; Rec."Reminder Terms Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageReminderTerms(Rec."Shortcut Dimension 5 Code", Rec."Reminder Terms Code");
                        end;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok, Rec."Payment Terms Code");
                        end;
                    }
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok, Rec."Payment Method Code");
                        end;
                    }
                    field(BankAccountCustBusinessField; Rec.BankAccountCustBusinessField)
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageCustomerBankAccount(
                                Rec."Customer No.",
                                    StrSubstNo(TokenPreferredBankAccountCodeTok, Rec."Shortcut Dimension 5 Code"),
                                        Rec.BankAccountCustBusinessField);
                        end;
                    }
                    field("Preferred BankAccount Code"; Rec."Preferred BankAccount Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            AppMgt.ShowPageCustomerBankAccount(
                                Rec."Customer No.",
                                    StrSubstNo(TokenPreferredBankAccountCodeTok, Rec."Shortcut Dimension 5 Code"),
                                        Rec."Preferred BankAccount Code");
                        end;
                    }
                    field(BalanceBusinessField; Rec.BalanceBusinessField)
                    {
                        ApplicationArea = All;
                    }
                }
                group(Reminder)
                {
                }
            }
        }
    }

    actions
    {
        area(Reporting)
        {
            action(RKSTBalanceReview)
            {
                Caption = 'RKST Balance Review', comment = 'DEA=RKST Debitor Saldenrückblick';
                ApplicationArea = All;
                Promoted = true;
                Image = Report;
                PromotedCategory = Report;
                PromotedOnly = true;
                RunObject = Report "Detail Trial Balance";
                ToolTip = 'Show the Customer Balance Review', comment = 'DEA="Führt den Bericht RKST Debitor Saldenrückblick aus"';
            }
        }
    }

    trigger OnAfterGetCurrRecord()
    begin
        UpdateShortcutdimensionCode9Description();
    end;

    trigger OnClosePage()
    begin
        AppMgt.SetActiveAndStateCustomerBusinessLines("Customer No.");
    end;

    local procedure UpdateShortcutdimensionCode9Description()
    begin
        if Rec."Shortcut Dimension 9 Code" = '' then
            exit;

        GLSetup.GetRecordOnce();
        DimensionValue.Get(GLSetup.ShortcutDimension9CodeNVX, Rec."Shortcut Dimension 9 Code");
        Rec.ShortcutdimensionCode9Name := DimensionValue.Name;
    end;

    var
        GLSetup: Record "General Ledger Setup";
        DimensionValue: Record "Dimension Value";
        AppMgt: Codeunit AppMgtNVX;
        TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"', Locked = true;
}