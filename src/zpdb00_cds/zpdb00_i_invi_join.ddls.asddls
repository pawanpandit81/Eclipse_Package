@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item via Join Interface'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@VDM.viewType: #BASIC
define view entity ZPDB00_I_INVI_JOIN
  as select from ZPDB00_I_INVI as Item
    inner join   ZPDB00_I_INVH as Head    on Head.DocumentNo = Item.DocumentNo
    inner join   ZPDB00_I_BUPA as Partner on Partner.PartnerNo = Head.PartnerNo
{
  key Item.DocumentNo,
  key Item.ItemNo,
      Item.MaterialNo,
      Head.PartnerNo,
      Partner.PartnerName,
      Partner.City,
      Partner.Country,
      @Semantics.quantity.unitOfMeasure: 'SalesUnit'
      Item.Quantity,
      Item.SalesUnit,
      @Semantics.amount.currencyCode: 'Currency'
      Item.Price,
      Item.Currency,
      Head.DocDate
}
