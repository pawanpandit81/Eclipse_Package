@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Object Item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.sapObjectNodeType.name: 'ZBOIT'
define view entity ZPD_R_OBID_IT
  as select from ZPD_I_OBID_IT as _Item
  association to parent ZPD_R_OBID_HD as _Header on $projection.BOObjid = _Header.BOObjid
{
  key BOObjid,
  key BOItem,
      BONotes,
      BOStatus,
      @Semantics.quantity.unitOfMeasure: 'BOUom'
      BOQuant,
      BOUom,

      _Header // Make association public
}
