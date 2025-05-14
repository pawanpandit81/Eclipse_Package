@EndUserText.label: 'Event Item Quantity Changed'
@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItem'
define root abstract entity ZD_ITEMQTYCHANGED
{
  @Semantics.quantity.unitOfMeasure: 'BusinessObjectItemUom'
  BusinessObjectItemQuantity : zqty;
  BusinessObjectItemUom      : zuom;
  __before                   : composition [1..1] of ZD_ITEMQTYCHANGEDOLD;
}
