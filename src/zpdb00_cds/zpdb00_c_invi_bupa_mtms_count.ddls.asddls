@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inv Itm Aggregate on Material & Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_BUPA_MTMS_COUNT
  as select from ZPDB00_I_INVI
{
  key _Invoice.PartnerNo,
  key MaterialNo,
      count( * ) as NoOfDocs
}
group by
  _Invoice.PartnerNo,
  MaterialNo
