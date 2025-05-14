@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header w Input Reuse Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVH_REUSE
  with parameters
    P_Date : abap.dats
  as select from ZPDB00_C_INVH_PARAM( P_Date : $parameters.P_Date,
                                      P_Type : 'A',
                                      P_Field : 'From Outer' )
{
  key DocumentNo,
      DocDate,
      PartnerName,
      Country,
      Status,
      ImportedField
}
