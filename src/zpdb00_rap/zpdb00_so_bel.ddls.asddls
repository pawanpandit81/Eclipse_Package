@EndUserText.label: 'Business Event Logging'
@ObjectModel.sapObjectNodeType.name: 'ZSalesOrderItem'
@Event.sapObjectNodeTypeKey: [{ element : 'OrderNo' }, 
                              { element : 'ItemNo' } ]
define abstract entity ZPDB00_SO_BEL
  // with parameters parameter_name : parameter_type
{
  item_no : abap.int4;
  status  : zpdbrg;
}
