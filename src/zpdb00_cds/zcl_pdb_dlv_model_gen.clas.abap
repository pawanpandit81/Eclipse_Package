CLASS zcl_pdb_dlv_model_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb_dlv_model_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
      mt_bupa   TYPE STANDARD TABLE OF zpdb00_bupa,
      mt_mtms   TYPE STANDARD TABLE OF zpdb00_mtms,
      mt_region TYPE STANDARD TABLE OF zpdb00_regn,
      mt_delhd  TYPE STANDARD TABLE OF zpdb00_c_delh,
      mt_delit  TYPE STANDARD TABLE OF zpdb00_c_deli.

    CLEAR:
      mt_bupa, mt_mtms, mt_region, mt_delhd, mt_delit.

    SELECT *
        FROM zpdb00_bupa
        ORDER BY PRIMARY KEY
        INTO TABLE @mt_bupa.

    SELECT *
        FROM zpdb00_mtms
        ORDER BY PRIMARY KEY
        INTO TABLE @mt_mtms.

    mt_region =
        VALUE #( ( region = 'A' )
                 ( region = 'B' ) ).
    DELETE FROM zpdb00_regn.
    INSERT zpdb00_regn FROM TABLE @mt_region.
    out->write( sy-dbcnt ).

    mt_delhd =
        VALUE #( ( delid = '1' deldt = '20250301' deltm = '000000' partner = '1000000001' )
                 ( delid = '2' deldt = '20250302' deltm = '000000' partner = '1000000002' )
                 ( delid = '3' deldt = '20250303' deltm = '000000' partner = '1000000001' )
                 ( delid = '4' deldt = '20250304' deltm = '000000' partner = '1000000000' ) ).
    DELETE FROM zpdb00_c_delh.
    INSERT zpdb00_c_delh FROM TABLE @mt_delhd.
    out->write( sy-dbcnt ).

    mt_delit =
        VALUE #( ( delid = '1' delit = '1' matnr = 'F0002' quant = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '1' delit = '2' matnr = 'F0003' quant = 5
                   unit = VALUE #( mt_mtms[ material = 'F0003' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '1' delit = '3' matnr = 'R0001' quant = 2
                   unit = VALUE #( mt_mtms[ material = 'R0001' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '2' delit = '1' matnr = 'F0001' quant = 10
                   unit = VALUE #( mt_mtms[ material = 'F0001' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '2' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '2' delit = '2' matnr = 'F0002' quant = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '2' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '3' delit = '1' matnr = 'H0001' quant = 5
                   unit = VALUE #( mt_mtms[ material = 'H0001' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '3' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '4' delit = '1' matnr = 'H0002' quant = 2
                   unit = VALUE #( mt_mtms[ material = 'H0002' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '4' delit = '2' matnr = 'F0002' quant = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( delid = '4' delit = '3' matnr = 'F0001' quant = 3
                   unit = VALUE #( mt_mtms[ material = 'F0001' ]-stk_unit OPTIONAL )
                   curky = VALUE #( mt_bupa[ partner = VALUE #( mt_delhd[ delid = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) ) ).
    DELETE FROM zpdb00_c_deli.
    INSERT zpdb00_c_deli FROM TABLE @mt_delit.
    out->write( sy-dbcnt ).
    COMMIT WORK.
    out->write( 'Delivery Data Inserted'  ).
  ENDMETHOD.
ENDCLASS.
