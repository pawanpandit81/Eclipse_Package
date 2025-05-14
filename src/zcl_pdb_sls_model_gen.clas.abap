CLASS zcl_pdb_sls_model_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb_sls_model_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
      mt_bupa      TYPE STANDARD TABLE OF zpdb00_bupa,
      mt_mtms      TYPE STANDARD TABLE OF zpdb00_mtms,
      mt_region    TYPE STANDARD TABLE OF zpdb00_regn,
      mt_order     TYPE STANDARD TABLE OF zpdb00_slsh,
      mt_order_itm TYPE STANDARD TABLE OF zpdb00_slsi.

    clear:
      mt_bupa, mt_mtms, mt_region, mt_order, mt_order_itm.

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

    mt_order =
        VALUE #( ( ord_id = '1' doc_date = '20250301' region = 'A' partner = '1000000001' )
                 ( ord_id = '2' doc_date = '20250302' region = 'A' partner = '1000000002' )
                 ( ord_id = '3' doc_date = '20250303' region = 'B' partner = '1000000001' )
                 ( ord_id = '4' doc_date = '20250304' region = 'B' partner = '1000000000' ) ).
    DELETE FROM zpdb00_slsh.
    INSERT zpdb00_slsh FROM TABLE @mt_order.
    out->write( sy-dbcnt ).

    mt_order_itm =
        VALUE #( ( ord_id = '1' item_no = '1' material = 'F0002' quantity = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '1' item_no = '2' material = 'F0003' quantity = 5
                   unit = VALUE #( mt_mtms[ material = 'F0003' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '1' item_no = '3' material = 'R0001' quantity = 2
                   unit = VALUE #( mt_mtms[ material = 'R0001' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '1' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '2' item_no = '1' material = 'F0001' quantity = 10
                   unit = VALUE #( mt_mtms[ material = 'F0001' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '2' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '2' item_no = '2' material = 'F0002' quantity = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '2' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '3' item_no = '1' material = 'H0001' quantity = 5
                   unit = VALUE #( mt_mtms[ material = 'H0001' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '3' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '4' item_no = '1' material = 'H0002' quantity = 2
                   unit = VALUE #( mt_mtms[ material = 'H0002' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '4' item_no = '2' material = 'F0002' quantity = 5
                   unit = VALUE #( mt_mtms[ material = 'F0002' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) )
                 ( ord_id = '4' item_no = '3' material = 'F0001' quantity = 3
                   unit = VALUE #( mt_mtms[ material = 'F0001' ]-stk_unit OPTIONAL )
                   currency = VALUE #( mt_bupa[ partner = VALUE #( mt_order[ ord_id = '4' ]-partner OPTIONAL ) ]-currency OPTIONAL ) ) ).
    DELETE FROM zpdb00_slsi.
    INSERT zpdb00_slsi FROM TABLE @mt_order_itm.
    out->write( sy-dbcnt ).
  ENDMETHOD.
ENDCLASS.
