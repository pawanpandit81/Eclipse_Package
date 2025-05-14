@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: 'Sales Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@DataIntegration.deltaReplication.intended: true
@VDM.viewType: #BASIC
define view entity ZPDB00_I_R_SLSI
  as select from zpdb00_slsi
  association [1..1] to ZPDB00_I_R_SLSH as _SalesHd on $projection.OrdId = _SalesHd.OrdId
  association [0..1] to ZPDB00_I_MTMS as _Material on $projection.MaterialNo = _Material.MaterialNo
{
  key ord_id   as OrdId,
  key item_no  as ItemNo,
      material as MaterialNo,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      quantity as Quantity,
      unit     as Unit,
 //     Quantity *  as Amount
      currency as Currency,
      _SalesHd,
      _Material
      
}
