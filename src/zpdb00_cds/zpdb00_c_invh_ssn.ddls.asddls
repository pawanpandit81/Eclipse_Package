@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header with Session Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVH_SSN
  as select from ZPDB00_I_INVH
{
  key DocumentNo,
      DocDate,
      DocTime,
      PartnerNo,
      $session.system_language as SystemLanguage
}
where
  DocDate < $session.system_date
