enum 50004 "StatusCustBusinessFieldsNVX"
{
    Extensible = true;

    value(0; NE)
    {
        Caption = 'not configurated', comment = 'DEA="nicht eingerichtet"';
    }
    value(1; TE)
    {
        Caption = 'partially configurated', comment = 'DEA="teilweise eingerichtet"';
    }
    value(2; EE)
    {
        Caption = 'successfuly configurated', comment = 'DEA="erfolgreich eingerichtet"';
    }
}