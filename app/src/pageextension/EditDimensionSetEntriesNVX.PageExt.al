//ToDo

pageextension 50067 "EditDimensionSetEntriesNVX" extends "Edit Dimension Set Entries"
{
    // trigger OnAfterGetRecord();
    // begin
    //     DimMgt.GetShortcutDimensions(Rec."Dimension Set ID", ShortcutDims);
    // end;

    trigger OnOpenPage()
    begin
        if DimensionFieldMgt.GetFieldsPropertyVisibleEditableBySetup(
            Page::"Detailed Cust. Ledg. Entries",
                DimVisible1, DimVisible2, DimVisible3, DimVisible4, DimVisible5, DimVisible6, DimVisible7, DimVisible8, DimVisible9, DimVisible10,
                    DimEditable1, DimEditable2, DimEditable3, DimEditable4, DimEditable5, DimEditable6, DimEditable7, DimEditable8, DimEditable9, DimEditable10)
        then begin
            DimEditable5 := DimEditable5 and UserSetup.EditBusFieldCustLedgerEntryNVX;
            DimEditable9 := DimEditable9 and UserSetup.AllCollectedAccountsNVX;

            // AppMgt.GetUserSetup(UserSetup, true);
            // Rec.FilterGroup(2);
            // Rec.SetFilter(ShortcutDimension5CodeNVX, UserSetup.BusinessFieldFilterNVX);
            // Rec.FilterGroup(0);
        end;
    end;

    var
        UserSetup: Record "User Setup";
        // AppMgt: Codeunit AppMgtNVX;
        DimensionFieldMgt: Codeunit DimensionFieldManagementNVX;
        // DimMgt: Codeunit DimensionManagement;
        DimEditable1: Boolean;
        DimEditable2: Boolean;
        DimEditable3: Boolean;
        DimEditable4: Boolean;
        DimEditable5: Boolean;
        DimEditable6: Boolean;
        DimEditable7: Boolean;
        DimEditable8: Boolean;
        DimEditable9: Boolean;
        DimEditable10: Boolean;
        DimVisible1: Boolean;
        DimVisible2: Boolean;
        DimVisible3: Boolean;
        DimVisible4: Boolean;
        DimVisible5: Boolean;
        DimVisible6: Boolean;
        DimVisible7: Boolean;
        DimVisible8: Boolean;
        DimVisible9: Boolean;
        DimVisible10: Boolean;
}