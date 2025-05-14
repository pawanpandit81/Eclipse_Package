@EndUserText.label: 'Status Changed Item'
define root abstract entity ZPD_D_STCHGI
{
  BOIStatus : zstat;
  _before   : composition [1..1] of ZPD_D_STCHGI_O;
}
