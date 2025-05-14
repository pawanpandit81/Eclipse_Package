@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header with Substring Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVH_SBS
  as select from ZPDB00_I_INVH
{
  key DocumentNo,
      DocDate,
      substring( DocDate, 5, 2 ) as MonthInDocDate,
      substring( DocDate, 1, 4 ) as YearInDocDate,
      DocTime,
      PartnerNo
}
