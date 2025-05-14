@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Metadata.allowExtensions: true
define view entity ZPDB00_I_R_INVI
  as select from zpdb00_invi
  association     to parent ZPDB00_I_R_INVH as _Head
    on $projection.DocumentNo = _Head.DocumentNo
  association [1] to ZPDB00_I_MTMS as _Material 
    on $projection.MaterialNo = _Material.MaterialNo
{
  key document as DocumentNo,
  key item_no  as ItemNo,
      material as MaterialNo,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity as Quantity,
      unit     as Unit,
      @Semantics.amount.currencyCode: 'Currency'
      price    as Price,
      currency as Currency,
      _Material,
      _Head
}
