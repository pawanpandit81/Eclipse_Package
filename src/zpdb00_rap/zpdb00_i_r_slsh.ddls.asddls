@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@DataIntegration.deltaReplication.intended: true
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_R_SLSH
  as select from zpdb00_slsh
    association [0..*] to ZPDB00_I_R_SLSI as _Item    on $projection.OrdId= _Item.OrdId
    association [0..1] to ZPDB00_I_BUPA as _Partner on $projection.PartnerNo = _Partner.PartnerNo
{
  key ord_id   as OrdId,
      doc_date as DocDate,
      region   as Region,
      partner  as PartnerNo,
      _Item,
      _Partner
}
