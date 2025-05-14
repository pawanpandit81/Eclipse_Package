FUNCTION zpdbc_sub.
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

  IF iv_num1 > iv_num2.
    ev_res = iv_num1 - iv_num2.
  ELSE.
    ev_res = iv_num2 - iv_num1.
  ENDIF.



ENDFUNCTION.
