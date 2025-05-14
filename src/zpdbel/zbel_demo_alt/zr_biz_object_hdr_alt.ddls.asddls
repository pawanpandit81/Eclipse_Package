@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectHeaderAlt'

define root view entity ZR_BIZ_OBJECT_HDR_ALT
  as select from ZI_BIZ_OBJECT_HDR as _Header
  composition [0..*] of ZR_BIZ_OBJECT_ITEM_ALT as _Item
{
  key BusinessObjectID,
      BusinessObjectNotes,
      BusinessObjectStatus,
      _Item
}
