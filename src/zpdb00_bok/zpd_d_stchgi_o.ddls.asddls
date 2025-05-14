@EndUserText.label: 'Status Changed Item Old'
define abstract entity ZPD_D_STCHGI_O
{
  BOIStatus : zstat;
  _parent   : association to parent ZPD_D_STCHGI;
}
