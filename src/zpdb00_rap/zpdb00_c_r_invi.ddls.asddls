@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Item Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define view entity ZPDB00_C_R_INVI
  as projection on ZPDB00_I_R_INVI as _InvIt
{
  key DocumentNo,
  key ItemNo,
      MaterialNo,
      @Semantics.quantity.unitOfMeasure: 'Unit'
      Quantity,
      Unit,
      @Semantics.amount.currencyCode: 'Currency'
      Price,
      Currency,
      /* Associations */
      _Material,
      _Head : redirected to parent ZPDB00_C_R_INVH

}
