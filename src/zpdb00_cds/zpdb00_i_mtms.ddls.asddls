@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_MTMS
  as select from zpdb00_mtms
  association [0..1] to I_Currency      as _Currency on $projection.Currency = _Currency.Currency
  association [0..1] to I_UnitOfMeasure as _Unit     on $projection.StockUnit = _Unit.UnitOfMeasure

{
  key material    as MaterialNo,
      name        as MaterialName,
      description as MaterialDescription,
      @Semantics.quantity.unitOfMeasure : 'StockUnit'
      stock       as Stock,
      stk_unit    as StockUnit,
      @Semantics.amount.currencyCode: 'Currency'
      per_unit    as PricePerUnit,
      currency    as Currency,
      _Currency,
      _Unit
}
