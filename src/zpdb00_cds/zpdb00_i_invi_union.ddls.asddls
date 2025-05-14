@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item via Union Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity ZPDB00_I_INVI_UNION
  as select from ZPDB00_C_INVI_ERR
{
  key DocumentNo,
  key ItemNo,
      'Normal' as ItemType,
      //      MaterialNo,
      //      @Semantics.quantity.unitOfMeasure: 'SalesUnit'
      //      Quantity,
      //      SalesUnit,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      Currency,
      ErrorInConversion
}
where
  ErrorInConversion = ' '
union select from ZPDB00_C_INVI_ERR
{

  key DocumentNo,
  key ItemNo,
      'Error'                        as ItemType,
      //      MaterialNo,
      //      Quantity,
      //      SalesUnit,
      cast( 0.0 as abap.curr(15,2) ) as Price,
      Currency,
      ErrorInConversion
}
where
  ErrorInConversion = 'X'
except select from ZPDB00_C_INVI_ERR
{

  key DocumentNo,
  key ItemNo,
      'Error' as ItemType,
//      MaterialNo,
//      Quantity,
//      SalesUnit,
      cast( 0.0 as abap.curr(15,2) ) as Price,
      Currency,
      ErrorInConversion
}
where
  ItemNo = 2
  and Currency = 'RUB'
