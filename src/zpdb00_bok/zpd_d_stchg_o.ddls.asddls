@EndUserText.label: 'Status Changed Old'
define abstract entity ZPD_D_STCHG_O
{
  BOHStatus : zstat;
  _parent  : association to parent ZPD_D_STCHG;
}
