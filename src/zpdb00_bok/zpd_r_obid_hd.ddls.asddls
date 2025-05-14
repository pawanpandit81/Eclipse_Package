@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'BO Object Header'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.sapObjectNodeType.name: 'ZBOHI'
define root view entity ZPD_R_OBID_HD
  as select from ZPD_I_OBID_HD as _Header
  composition [0..*] of ZPD_R_OBID_IT as _Item
{
  key BOObjid,
      BONotes,
      BOStatus,

      _Item // Make association public
}
