enum 50004 "StatusCustBusinessFieldsNVX"
{
    Extensible = true;

    Value(0; EMPTY)
    {
        Caption = '', comment = 'DEA=""';
    }
    value(1; NE)
    {
        Caption = 'not configurated', comment = 'DEA="nicht eingerichtet"';
    }
    value(2; TE)
    {
        Caption = 'partially configurated', comment = 'DEA="teilweise eingerichtet"';
    }
    value(3; EE)
    {
        Caption = 'successfuly configurated', comment = 'DEA="erfolgreich eingerichtet"';
    }
}