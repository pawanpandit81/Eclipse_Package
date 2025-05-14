@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Basic Object Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity ZPD_I_OBID_IT
  as select from zpd_obid_it
{
  key objid  as BOObjid,
  key item   as BOItem,
      notes  as BONotes,
      status as BOStatus,
      @Semantics.quantity.unitOfMeasure: 'BOUom'
      quant  as BOQuant,
      uom    as BOUom
}
