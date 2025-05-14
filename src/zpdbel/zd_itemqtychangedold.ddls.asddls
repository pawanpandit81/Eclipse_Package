@EndUserText.label: 'Event Item Quantity Changed'
@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItem'
define abstract entity ZD_ITEMQTYCHANGEDOLD
{
  @Semantics.quantity.unitOfMeasure: 'BusinessObjectItemUom'
  BusinessObjectItemQuantity : zqty;
  BusinessObjectItemUom      : zuom;
  _parent                    : association to parent ZD_ITEMQTYCHANGED;
}
