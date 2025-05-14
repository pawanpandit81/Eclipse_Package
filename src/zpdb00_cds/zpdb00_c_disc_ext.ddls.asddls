@AbapCatalog.viewEnhancementCategory: [#PROJECTION_LIST]
@AbapCatalog.extensibility.extensible: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Discount Cast Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_DISC_EXT
  as select from ZPDB00_I_DISC
{
  key PartnerNo,
  key MaterialNo,
      DiscountValue,
      _Material.MaterialName,
      _Material.MaterialDescription,
      _Partner  
}
