@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Discount Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_DISC
  as select from zpdb00_disc
  association [0..1] to ZPDB00_I_BUPA as _Partner  on $projection.PartnerNo = _Partner.PartnerNo
  association [0..1] to ZPDB00_I_MTMS as _Material on $projection.MaterialNo = _Material.MaterialNo

{
  key partner  as PartnerNo,
  key material as MaterialNo,
      discount as DiscountValue,
      _Partner,
      _Material
}
