@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #COMPOSITE
define view entity ZPDB00_I_INVI
  as select from zpdb00_invi
  association [0..1] to ZPDB00_I_INVH as _Invoice  on $projection.DocumentNo = _Invoice.DocumentNo
  association [0..1] to ZPDB00_I_MTMS as _Material on $projection.MaterialNo = _Material.MaterialNo

{
  key document as DocumentNo,
  key item_no  as ItemNo,
      material as MaterialNo,
      @Semantics.quantity.unitOfMeasure: 'SalesUnit'
      quantity as Quantity,
      unit     as SalesUnit,
      @Semantics.amount.currencyCode: 'Currency'
      price    as Price,
      currency as Currency,
      _Invoice,
      _Material
}
