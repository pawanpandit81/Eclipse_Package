@EndUserText.label: 'Event Item Status Changed'

define abstract entity ZD_ITEMSTATUSCHANGEDOLD
{
  BusinessObjectItemStatus : zstatus;
  _parent                  : association to parent ZD_ITEMSTATUSCHANGED;

}
