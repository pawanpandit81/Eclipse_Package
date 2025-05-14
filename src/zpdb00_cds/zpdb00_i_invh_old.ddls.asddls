@AbapCatalog.sqlViewName: 'ZVPDB00_INVH'
@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inv Header w Input Param Old Interface'
@Metadata.ignorePropagatedAnnotations: true
define view ZPDB00_I_INVH_OLD
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
