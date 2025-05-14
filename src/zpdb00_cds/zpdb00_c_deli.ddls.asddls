@ClientHandling.type: #CLIENT_DEPENDENT
@AbapCatalog.deliveryClass: #APPLICATION_DATA
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Delivery Item Table Entity'
define table entity ZPDB00_C_DELI
{
  key client    : abap.clnt;
  key delid     : abap.char(10);
  key delit     : abap.int2;
      @EndUserText.label: 'Material No'
      matnr     : abap.char(5);
      @Semantics.quantity.unitOfMeasure : 'unit'
      quant     : abap.quan(10,0);
      unit      : abap.unit(3);
      @Semantics.amount.currencyCode : 'curky'
      price     : abap.curr(15,2);
      curky     : abap.cuky;
      to_parent : association to one ZPDB00_C_DELH on ZPDB00_C_DELI.delid = to_parent.delid;

}
