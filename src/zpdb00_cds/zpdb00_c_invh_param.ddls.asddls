@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header Input Param Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVH_PARAM
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_Date  : abap.dats,
    P_Type  : abap.char( 1 ),
    P_Field : abap.char( 10 )
  as select from ZPDB00_I_INVH
{
  key DocumentNo,
      DocDate,
      _Partner.PartnerName,
      _Partner.Country,
      case $parameters.P_Type
        when 'A' then 'New'
        when 'B' then 'Old'
        else 'Unknown'
      end                 as Status,
      $parameters.P_Field as ImportedField
}
where
  DocDate = $parameters.P_Date
