@EndUserText.label: 'Event Header Status Changed'

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectHeader'

define root abstract entity ZD_STATUSCHANGED
{
  BusinessObjectStatus : zstatus;
  __before              : composition [1..1] of ZD_STATUSCHANGEDOLD;
}
