@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Company Details'
@Metadata.ignorePropagatedAnnotations: true
//@VDM.viewType: #BASIC
define root view entity ZPDB00_I_R_T001
  as select from zpdb00_t001
 // composition of target_data_source_name as _association_name
{
  key name        as Name,
      branch      as Branch,
      description as Description
  //    _association_name // Make association public
}
