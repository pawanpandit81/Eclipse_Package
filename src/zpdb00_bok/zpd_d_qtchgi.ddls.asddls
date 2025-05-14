@EndUserText.label: 'Quantity Changed Item'
@ObjectModel.sapObjectNodeType.name: 'ZBOIT'
//@Event.sapObjectNodeTypeKey : [{ element : 'BOObjid' }, 
//                               { element : 'BOItem' }]
define root abstract entity ZPD_D_QTCHGI
{
  @Semantics.quantity.unitOfMeasure: 'BOIUom'
  BOIQuantity : zquan;
  BOIUom      : ziuom;
  _before     : composition [1..1] of ZPD_D_QTCHGI_O;
}
