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
                    Caption = 'Business Fields', comment = 'DEA="Geschäftsfelder"';
                    field("Customer No."; Rec."Customer No.")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field("Shortcut Dimension 5 Code"; Rec."Shortcut Dimension 5 Code")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field("Shortcut Dimension 9 Code"; Rec."Shortcut Dimension 9 Code")
                    {
                        ApplicationArea = All;
                        CaptionClass = '1,2,9';
                        ToolTip = '', comment = 'DEA=""';

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Shortcut Dimension 9 Code" := AppMgt.OnLookupByBusinessFieldDimension(Rec."Shortcut Dimension 5 Code", 9);
                        end;
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
                            Rec."Reminder Terms Code" := AppMgt.ShowPageReminderTerms(Rec."Shortcut Dimension 5 Code");
                        end;
                    }
                    field("Payment Terms Code"; Rec."Payment Terms Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Payment Terms Code" := AppMgt.ShowPagePaymentTerms(TokenPaymentTermsTok);
                        end;
                    }
                    field("Payment Method Code"; Rec."Payment Method Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Payment Method Code" := AppMgt.ShowPagePaymentMethods(TokenPaymentMethodTok);
                        end;
                    }
                    field("Preferred BankAccount Code"; Rec."Preferred BankAccount Code")
                    {
                        ApplicationArea = All;

                        trigger OnLookup(var Text: Text): Boolean
                        begin
                            Rec."Preferred BankAccount Code" :=
                                AppMgt.ShowPageCustomerBankAccount(
                                    StrSubstNo(TokenPreferredBankAccountCodeTok, "Shortcut Dimension 5 Code"));
                        end;
                    }
                }
                group(Reminder)
                {
                    Caption = 'Reminder', comment = 'DEA="Mahnwesen"';
                    field("Allowed Setup dynamic fields"; Rec."Allowed Setup dynamic fields")
                    {
                        ToolTip = 'Specifies the value of the Allowed Setup dynamic Fields field.', Comment = 'DEA="setup dynamische Felder erlaubt"';
                        ApplicationArea = All;
                    }
                }
            }
        }
    }

    trigger OnClosePage()
    begin
        AppMgt.SetActiveAndStateCustomerBusinessLines("Customer No.");
    end;

    var
        AppMgt: Codeunit AppMgtNVX;
        TokenPaymentTermsTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPaymentMethodTok: Label 'K', comment = 'DEA="K"', Locked = true;
        TokenPreferredBankAccountCodeTok: Label '*%1*', comment = 'DEA="*%1*"', Locked = true;
}