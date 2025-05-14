@EndUserText.label: 'Custom Entity'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_PDB00_CUST_ENT_QUERY'
define custom entity ZPDB00_I_R_T001_CE
  // with parameters parameter_name : parameter_type
{
  key CompanyName        : abap.char( 60 );
      Branch             : abap.char( 50 );
      CompanyDescription : abap.char( 255 );

}
