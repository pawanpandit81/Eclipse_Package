@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_BIZ_OBJECT_ITEM
  as select from zbiz_object_item
{
  key objid      as BusinessObjectID,
  key item       as BusinessObjectItem,
      itemnotes  as BusinessObjectItemNotes,
      itemstatus as BusinessObjectItemStatus,
      @Semantics.quantity.unitOfMeasure: 'BusinessObjectItemUom'
      quantity   as BusinessObjectItemQuantity,
      uom        as BusinessObjectItemUom
}
