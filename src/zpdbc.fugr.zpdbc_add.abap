FUNCTION zpdbc_add.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUM1) TYPE  I
*"     REFERENCE(IV_NUM2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EV_RES) TYPE  I
*"----------------------------------------------------------------------
  " You can use the template 'functionModuleParameter' to add here the signature!
  .
  ev_res = iv_num1 + iv_num2.

ENDFUNCTION.
