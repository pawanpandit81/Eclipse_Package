@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectHeader'

define root view entity ZR_BIZ_OBJECT_HDR
  as select from ZI_BIZ_OBJECT_HDR as _Header
  composition [0..*] of ZR_BIZ_OBJECT_ITEM as _Item
{
  key BusinessObjectID,
      BusinessObjectNotes,
      BusinessObjectStatus,
      _Item
}
