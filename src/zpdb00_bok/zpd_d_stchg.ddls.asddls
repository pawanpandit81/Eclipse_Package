@EndUserText.label: 'Status Changed'
@ObjectModel.sapObjectNodeType.name: 'ZBOHI'
define root abstract entity ZPD_D_STCHG
{
  BOHStatus : zstat;
  _before   : composition [1..1] of ZPD_D_STCHG_O;
}
