@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Itm Virtual Field Price per Unit'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #CONSUMPTION
define view entity ZPDB00_C_INVI_VIRT_PPU
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
      @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_PDB_CDS_VIRTUAL_EXT'
      @Semantics.amount.currencyCode: 'Currency'
      cast( 0 as abap.curr(15,2) ) as PricePerUnit,
      /* Associations */
      _Invoice,
      _Material
}
