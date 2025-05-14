@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Discount Cast Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_DISC_CAST
  as select from ZPDB00_I_DISC
{
  key PartnerNo,
  key MaterialNo,
      DiscountValue,
      concat( cast( DiscountValue as abap.char(15) ), ' %' ) as DiscountText
}
