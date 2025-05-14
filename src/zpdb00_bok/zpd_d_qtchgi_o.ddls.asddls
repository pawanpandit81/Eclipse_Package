@EndUserText.label: 'Quantity Changed Item Old'
@ObjectModel.sapObjectNodeType.name: 'ZBOIT'
define abstract entity ZPD_D_QTCHGI_O
{
  @Semantics.quantity.unitOfMeasure: 'BOIUom'
  BOIQuantity : zquan;
  BOIUom      : ziuom;
  _parent     : association to parent ZPD_D_QTCHGI;
}
