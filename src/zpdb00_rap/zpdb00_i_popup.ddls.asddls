@EndUserText.label: 'Popup'
define abstract entity ZPDB00_I_Popup
  //  with parameters parameter_name : parameter_type
{
  @Consumption.valueHelpDefinition: [{ entity: { name: 'ZPDB00_C_CountryVH', element: 'Country' } }]
  @EndUserText.label: 'Search Country'
  SearchCountry : land1;
  @EndUserText.label: 'New Date'
  NewDate       : abap.dats;
  @EndUserText.label: 'Message Type'
  MessageType   : abap.int4;
  @EndUserText.label: 'Update Data'
  FlagUpdate    : abap.char(1);
  @EndUserText.label: 'Show Messages'
  FlagMessage   : abap_boolean;

}
