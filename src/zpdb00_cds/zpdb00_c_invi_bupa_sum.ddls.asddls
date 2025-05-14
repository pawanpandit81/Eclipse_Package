@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item Aggregation on Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_BUPA_SUM
  as select from ZPDB00_I_INVI
{
  key _Invoice.PartnerNo,
      @Semantics.amount.currencyCode: 'Currency'
      sum ( Price ) as PriceForPartner,
      Currency
}
group by
  _Invoice.PartnerNo,
  Currency
