FUNCTION zpdbc_div.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_NUM1) TYPE  I
*"     REFERENCE(IV_NUM2) TYPE  I
*"  EXPORTING
*"     REFERENCE(EV_RES) TYPE  I
*"  RAISING
*"      ZCX_STATIC_CHECK
*"----------------------------------------------------------------------
  " You can use the template 'functionModuleParameter' to add here the signature!
  .
  IF iv_num1 = 0.
    RAISE EXCEPTION TYPE zcx_static_check MESSAGE E000(ZPDB).
  ENDIF.

  IF iv_num2 = 0.
    RAISE EXCEPTION TYPE zcx_static_check MESSAGE E000(ZPDB).
  ENDIF.

  IF iv_num1 > 99999999 OR iv_num2 > 99999999.
    RAISE EXCEPTION TYPE zcx_static_check MESSAGE E000(ZPDB).
  ENDIF.

  ev_res = iv_num1 / iv_num2.

ENDFUNCTION.
