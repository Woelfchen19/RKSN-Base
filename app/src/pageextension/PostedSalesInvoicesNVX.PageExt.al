pageextension 50069 "PostedSalesInvoicesNVX" extends "Posted Sales Invoices"
{
    layout
    {
        addbefore(IncomingDocAttachFactBox)
        {
            part(DimensionSetEntriesFactBoxNVX; "Dimension Set Entries FactBox")
            {
                ApplicationArea = Basic, Suite;
                SubPageLink = "Dimension Set ID" = FIELD("Dimension Set ID");
            }
        }
    }
}