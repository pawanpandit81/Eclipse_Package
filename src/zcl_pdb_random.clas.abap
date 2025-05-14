CLASS zcl_pdb_random DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS class_constructor.

    METHODS constructor
      IMPORTING
        iv_min TYPE i DEFAULT 1
        iv_max TYPE i DEFAULT 6.

    METHODS rand
      RETURNING
        VALUE(rv_rand) TYPE i.
  PROTECTED SECTION.
  PRIVATE SECTION.
    CLASS-DATA mo_seed TYPE REF TO cl_abap_random.

    DATA mo_rand TYPE REF TO cl_abap_random.
    DATA mv_from TYPE i.
    DATA mv_to   TYPE i.

ENDCLASS.



CLASS zcl_pdb_random IMPLEMENTATION.
  METHOD class_constructor.
  try.
        DATA(lv_date) = cl_abap_context_info=>get_system_date( ).
        DATA(lv_time) = cl_abap_context_info=>get_system_time( ).

        DATA(lv_seed) = CONV i( |{ lv_date+4 }{ lv_time }| ).
      CATCH cx_sy_conversion_overflow.
        lv_seed = 1337.
    ENDTRY.

    mo_seed = cl_abap_random=>create( lv_seed ).
  ENDMETHOD.


  METHOD constructor.
    mv_from = iv_min.
    mv_to = iv_max.

    mo_rand = cl_abap_random=>create( seed = mo_seed->intinrange( low  = 1
                                                                  high = 10000 ) ).
  ENDMETHOD.


  METHOD rand.
    rv_rand = mo_rand->intinrange( low  = mv_from
                                   high = mv_to ).
  ENDMETHOD.
ENDCLASS.
