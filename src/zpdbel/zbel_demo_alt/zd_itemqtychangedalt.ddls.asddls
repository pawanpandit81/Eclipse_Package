@EndUserText.label: 'Event Item Quantity Changed'

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItemAlt'

@Event.sapObjectNodeTypeKey : [ { element : 'BusinessObjectID' } , { element : 'BusinessObjectItem' } ]

define abstract entity ZD_ITEMQTYCHANGEDALT
{
  BusinessObjectItem             : zitm;
  @Semantics.quantity.unitOfMeasure: 'BusinessObjectItemUom'
  @Event.previousValue.element   : 'PrevBusinessObjectItemQuantity'
  BusinessObjectItemQuantity     : zqty;
  BusinessObjectItemUom          : zuom;
  @Semantics.quantity.unitOfMeasure: 'PrevBusinessObjectItemUom'
  PrevBusinessObjectItemQuantity : zqty;
  PrevBusinessObjectItemUom      : zuom;

}
