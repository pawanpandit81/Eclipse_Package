@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Business Object Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
  serviceQuality: #X,
  sizeCategory: #S,
  dataClass: #MIXED
}
define view entity ZI_BIZ_OBJECT_HDR
  as select from zbiz_object_hdr
{
  key objid  as BusinessObjectID,
      notes  as BusinessObjectNotes,
      status as BusinessObjectStatus
}
