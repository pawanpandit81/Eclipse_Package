@ClientHandling.type: #CLIENT_DEPENDENT
@AbapCatalog.deliveryClass: #APPLICATION_DATA
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Header Root Entity'
define root table entity ZPDB00_C_DELH

{
  key client   : abap.clnt;
  key delid    : abap.char(10);
      deldt    : abap.datn;
      deltm    : abap.timn;
      partner  : abap.char(10) null;
      to_child : association to many ZPDB00_C_DELI on ZPDB00_C_DELH.delid = to_child.delid;

}
