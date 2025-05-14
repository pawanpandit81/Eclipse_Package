@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_INVH
  as select from zpdb00_invh
  association [0..*] to ZPDB00_I_INVI as _Item    on $projection.DocumentNo = _Item.DocumentNo
  association [0..1] to ZPDB00_I_BUPA as _Partner on $projection.PartnerNo = _Partner.PartnerNo
{
  key document as DocumentNo,
      doc_date as DocDate,
      doc_time as DocTime,
      partner  as PartnerNo,
      _Item,
      _Partner
}
