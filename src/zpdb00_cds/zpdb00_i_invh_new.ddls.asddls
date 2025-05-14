@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inv Header w Input Param New Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_INVH_NEW
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_Date : abap.dats
  as select from zpdb00_invh
  association [0..*] to ZPDB00_I_INVI as _Item on $projection.Document = _Item.DocumentNo

{
  key document as Document,
      doc_date as DocDate,
      doc_time as DocTime,
      partner  as Partner,
      _Item
}
where
  doc_date = $parameters.P_Date
