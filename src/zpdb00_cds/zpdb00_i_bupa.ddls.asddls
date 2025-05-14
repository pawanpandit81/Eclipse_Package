@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Partner Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_BUPA
  as select from zpdb00_bupa
  association [0..1] to I_Country  as _Country  on $projection.Country = _Country.Country
  association [0..1] to I_Currency as _Currency on $projection.PaymentCurrency = _Currency.Currency
{
  key partner  as PartnerNo,
      name     as PartnerName,
      street   as Street,
      city     as City,
      country  as Country,
      currency as PaymentCurrency,
      _Country,
      _Currency
}
