@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Invoice Header Projection'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
define root view entity ZPDB00_C_R_INVH
  provider contract transactional_query
  as projection on ZPDB00_I_R_INVH as _InvHd
{
  key     DocumentNo,
          DocDate,
          DocTime,
          PartnerNo,
          @ObjectModel.virtualElementCalculatedBy: 'ABAP:ZCL_PDB_INVH_VCE_READ'
  virtual NumberOfItems : abap.int4,
          /* Associations */
          _Partner,
          _Item : redirected to composition child ZPDB00_C_R_INVI

}
