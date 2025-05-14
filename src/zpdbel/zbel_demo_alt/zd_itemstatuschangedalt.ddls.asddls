@EndUserText.label: 'Event Item Status Changed'

@ObjectModel.sapObjectNodeType.name: 'ZBusinessObjectItemAlt'

@Event.sapObjectNodeTypeKey : [ { element : 'BusinessObjectID' } , { element : 'BusinessObjectItem' } ]

define abstract entity ZD_ITEMSTATUSCHANGEDALT
{
  BusinessObjectItem           : zitm;
  @Event.previousValue.element : 'PrevBusinessObjectItemStatus'
  BusinessObjectItemStatus     : zstatus;
  PrevBusinessObjectItemStatus : zstatus;

}
