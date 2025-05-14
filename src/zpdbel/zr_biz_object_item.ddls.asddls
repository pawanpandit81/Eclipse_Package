@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Item'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItem'

define view entity ZR_BIZ_OBJECT_ITEM
  as select from ZI_BIZ_OBJECT_ITEM as _Item
  association to parent ZR_BIZ_OBJECT_HDR as _Header on $projection.BusinessObjectID = _Header.BusinessObjectID
{
  key BusinessObjectID,
  key BusinessObjectItem,
      BusinessObjectItemNotes,
      BusinessObjectItemStatus,
      @Semantics.quantity.unitOfMeasure: 'BusinessObjectItemUom'
      BusinessObjectItemQuantity,
      BusinessObjectItemUom,
      _Header
}
