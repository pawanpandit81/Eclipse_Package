@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item Report on Partner'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_BUPA_CURR_CONV
  with parameters
    @Environment.systemField: #SYSTEM_DATE
    P_CalculationDate : abap.dats
  as select from ZPDB00_C_INVI_BUPA_SUM
{
  key PartnerNo,
      @Semantics.amount.currencyCode: 'Currency'
      PriceForPartner,
      Currency,
      @Semantics.amount.currencyCode: 'Currency'
      currency_conversion( amount => PriceForPartner,
                           source_currency => Currency,
                           round => 'X',
                           target_currency => cast( 'USD' as abap.cuky( 5 ) ),
                           exchange_rate_date => $parameters.P_CalculationDate,
                           exchange_rate_type => 'M',
                           error_handling => 'SET_TO_NULL' ) as PriceInUSD
}
