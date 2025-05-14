@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPDB00_I_R_INVH
  as select from zpdb00_invh
  //composition of one to many ZPDB00_I_R_INVI as _Item
  composition [0..*] of ZPDB00_I_R_INVI as _Item
  association [1]    to ZPDB00_I_BUPA        as _Partner on $projection.PartnerNo = _Partner.PartnerNo
{
  key document as DocumentNo,
      doc_date as DocDate,
      doc_time as DocTime,
      partner  as PartnerNo,    
      _Partner,
      _Item // Make association public
}
