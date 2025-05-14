@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Inv Itm Agg w St on Material & Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_BUPA_MTMS_STAT
  as select from ZPDB00_C_INVI_BUPA_MTMS_SUM   as Combine
    inner join   ZPDB00_C_INVI_BUPA_MTMS_COUNT as Numbers on  Combine.PartnerNo  = Numbers.PartnerNo
                                                          and Combine.MaterialNo = Numbers.MaterialNo
{
  key Combine.PartnerNo,
  key Combine.MaterialNo,
      @Semantics.amount.currencyCode: 'Currency'
      Combine.PriceForPartnerMaterial,
      Numbers.NoOfDocs,
      Combine.Currency
}
where
      Numbers.NoOfDocs       >= 10
  and Combine.PriceForPartnerMaterial <= 100000
