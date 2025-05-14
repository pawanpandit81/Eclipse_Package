@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Item'
@Metadata.ignorePropagatedAnnotations: true

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItemAlt'

define view entity ZR_BIZ_OBJECT_ITEM_ALT
  as select from ZI_BIZ_OBJECT_ITEM as _Item
  association to parent ZR_BIZ_OBJECT_HDR_ALT as _Header on $projection.BusinessObjectID = _Header.BusinessObjectID
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
