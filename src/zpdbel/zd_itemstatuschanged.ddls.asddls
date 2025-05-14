@EndUserText.label: 'Event Item Status Changed'

define root abstract entity ZD_ITEMSTATUSCHANGED
{
  BusinessObjectItemStatus : zstatus;
  __before                 : composition [1..1] of ZD_ITEMSTATUSCHANGEDOLD;
}
