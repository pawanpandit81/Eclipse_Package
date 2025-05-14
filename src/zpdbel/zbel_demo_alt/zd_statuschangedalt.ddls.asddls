@EndUserText.label: 'Event Header Status Changed'

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectHeaderAlt'
define abstract entity ZD_STATUSCHANGEDALT
{
  @Event.previousValue.element : 'PreviousBusinessObjectStatus'
  BusinessObjectStatus         : zstatus;
  PreviousBusinessObjectStatus : zstatus;

}
