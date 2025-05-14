@EndUserText.label: 'Event Header Status Changed'


define abstract entity ZD_STATUSCHANGEDOLD
{
  BusinessObjectStatus : zstatus;
  _parent              : association to parent ZD_STATUSCHANGED;
}
