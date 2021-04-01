codeunit 50012 Codeunit42HookNVX
{
    [EventSubscriber(ObjectType::Codeunit, Codeunit::CaptionManagement, 'OnExtensionCaptionArea', '', false, false)]
    local procedure GetDimensionName(Language: Integer; CaptionArea: Text[80]; CaptionRef: Text[1024]; VAR CaptionExpr: Text[1024])
    var
        Dim: Record Dimension;
        GLSetup: Record "General Ledger Setup";
        SalesLbl: Label 'Sales', comment = 'DEA="Verkauf"';
        PurchaseLbl: Label 'Purchase', comment = 'DEA="Einkauf"';
    begin
        IF CaptionArea = '1337' then begin // return Dimension Name without "Code" or "Filter"
            GLSetup.get();
            case CaptionRef of
                '1' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 1 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '2' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 2 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '3' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 3 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '4' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 4 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '5' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 5 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '6' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 6 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '7' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 7 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
                '8' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 8 Code") then;
                            CaptionExpr := StrSubstNo('%1 %2', Dim.GetMLName(Language), 'Name');
                    end;
            end; // of case
        end;

        IF CaptionArea = '1338' then begin //Return Sales Dimension Name
            GLSetup.get();
            case CaptionRef of
                '1' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 1 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '2' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 2 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '3' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 3 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '4' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 4 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '5' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 5 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '6' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 6 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '7' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 7 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
                '8' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 8 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', SalesLbl, Dim.GetMLName(Language));
                    end;
            end; // of case
        end;

        IF CaptionArea = '1339' then begin //Return Purchase Dimension Name
            GLSetup.get();
            case CaptionRef of
                '1' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 1 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '2' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 2 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '3' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 3 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '4' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 4 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '5' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 5 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '6' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 6 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '7' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 7 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
                '8' :
                    begin
                        if Dim.Get(GLSetup."Shortcut Dimension 8 Code") then;
                        CaptionExpr := StrSubstNo('%1 %2', PurchaseLbl, Dim.GetMLName(Language));
                    end;
            end; // of case
        end;

    end;
}