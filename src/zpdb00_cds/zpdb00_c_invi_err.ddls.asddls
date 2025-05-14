@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item with Error Consumption'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_ERR
  as select from ZPDB00_I_INVI
{
  key DocumentNo,
  key ItemNo,
      MaterialNo,
      @Semantics.quantity.unitOfMeasure: 'SalesUnit'
      Quantity,
      SalesUnit,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      Currency,
      case Price
        when 37707 then 'X'
        else ' '
      end as ErrorInConversion
}
