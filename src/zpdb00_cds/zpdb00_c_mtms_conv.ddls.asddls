@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Material Master Conversion Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_MTMS_CONV
  as select from ZPDB00_I_MTMS

{
  key MaterialNo,
      MaterialName,
      //MaterialDescription,
      @Semantics.quantity.unitOfMeasure: 'StockUnit'
      Stock,
      StockUnit,
      @Semantics.quantity.unitOfMeasure: 'StockUnit'
      unit_conversion( quantity => Stock,
                       source_unit => StockUnit,
                       target_unit => cast( 'ST' as abap.unit( 3 ) ),
                       error_handling => 'SET_TO_NULL' ) as UnitInPieces,
      @Semantics.amount.currencyCode: 'Currency'
      PricePerUnit,
      Currency
}
