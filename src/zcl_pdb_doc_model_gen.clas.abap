CLASS zcl_pdb_doc_model_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    CONSTANTS:
      sc_error                TYPE zpdb00_invi-price VALUE '37707',
      sc_no_of_inv            TYPE i VALUE 300,
      sc_days_back_from_today TYPE i VALUE 365,
      sc_max_no_of_inv_itm    TYPE i VALUE 3,
      sc_max_qty_per_inv_itm  TYPE i VALUE 5.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      mt_bupa        TYPE STANDARD TABLE OF zpdb00_bupa,
      mt_mtms        TYPE STANDARD TABLE OF zpdb00_mtms,
      mt_disc        TYPE STANDARD TABLE OF zpdb00_disc,
      mt_invh        TYPE STANDARD TABLE OF zpdb00_invh,
      mt_invi        TYPE STANDARD TABLE OF zpdb00_invi,

      mo_random_bupa TYPE REF TO zcl_pdb_random,
      mo_random_invi TYPE REF TO zcl_pdb_random,
      mo_random_mtms TYPE REF TO zcl_pdb_random,
      mo_random_date TYPE REF TO zcl_pdb_random,
      mo_random_quan TYPE REF TO zcl_pdb_random.

    METHODS:
      create_bupa,
      create_mtms,
      create_disc,
      create_invd
        IMPORTING
          iv_count TYPE i,
      create_invh
        RETURNING
          VALUE(rs_result) TYPE zpdb00_invh,
      create_invi
        IMPORTING
          is_invh TYPE zpdb00_invh.
ENDCLASS.



CLASS zcl_pdb_doc_model_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    create_bupa( ).
    out->write( |Partner: { lines( mt_bupa ) }| ).

    create_mtms( ).
    out->write( |Material: { lines( mt_mtms ) }| ).

    create_disc( ).
    out->write( |Discount: { lines( mt_disc ) }| ).

    create_invd( sc_no_of_inv ).
    out->write( |Invoice: { lines( mt_invh ) }| ).
    out->write( |Position: { lines( mt_invi ) }| ).
  ENDMETHOD.
  METHOD create_bupa.
    mt_bupa =
        VALUE #( ( partner = '1000000000' name = 'SAP' street = 'Demo Street 15' city = 'Walldorf' country = 'DE' currency = 'EUR' )
                 ( partner = '1000000001' name = 'Microsoft' street = 'Demo Street 24' city = 'Redmond' country = 'US' currency = 'USD' )
                 ( partner = '1000000002' name = 'Meta' street = 'Fox Street 1' city = 'Menlo Park' country = 'US' currency = 'USD' )
                 ( partner = '1000000003' name = 'Alibaba' street = 'Alley 15' city = 'Hangzhou' country = 'CN' currency = 'CNY' )
                 ( partner = '1000000004' name = 'BMW' street = 'Main Avenue 200' city = 'Munich' country = 'DE' currency = 'EUR' )
                 ( partner = '1000000005' name = 'Nestle' street = 'Village Alley 14' city = 'Vevey' country = 'CH' currency = 'CHF' )
                 ( partner = '1000000006' name = 'Gazprom' street = 'Peace Avenue 1' city = 'Sankt Petersburg' country = 'RU' currency = 'RUB' ) ).

    DELETE FROM zpdb00_bupa.
    INSERT zpdb00_bupa FROM TABLE @mt_bupa.
  ENDMETHOD.

  METHOD create_mtms.
    mt_mtms =
        VALUE #( ( material = 'F0001'
                   name = 'Peanuts'
                   description = 'Roasted Peanuts from US'
                   stock = '900'
                   stk_unit = 'ST'
                   per_unit = '2.50'
                   currency = 'USD' )
                 ( material = 'F0002'
                   name = 'Rice'
                   description = 'Big bag rice from china'
                   stock = '120'
                   stk_unit = 'BAG'
                   per_unit = '12.00'
                   currency = 'USD' )
                 ( material = 'F0003'
                   name = 'Eggs'
                   description = 'Eggs from happy german chickens'
                   stock = '550'
                   stk_unit = 'PAK'
                   per_unit = '3.15'
                   currency = 'EUR' )
                 ( material = 'H0001'
                   name = 'USB Stick 128 GB'
                   description = 'USB Stick with security features'
                   stock = '30'
                   stk_unit = 'ST'
                   per_unit = '49.99'
                   currency = 'EUR' )
                 ( material = 'H0002'
                   name = 'OLED Display 34"'
                   description = 'Big and wide display with HDMI and dsiplay port'
                   stock = '18'
                   stk_unit = 'ST'
                   per_unit = '440.00'
                   currency = 'USD' )
                 ( material = 'R0001'
                   name = 'Gas'
                   description = 'Gas from sibiria'
                   stock = '50000'
                   stk_unit = 'MMQ'
                   per_unit = '1560.00'
                   currency = 'RUB' ) ).

    DELETE FROM zpdb00_mtms.
    INSERT zpdb00_mtms FROM TABLE @mt_mtms.
  ENDMETHOD.


  METHOD create_disc.
    mt_disc =
        VALUE #( ( partner = '1000000000' material = 'F0003' discount = '10.00' )
                 ( partner = '1000000001' material = 'F0001' discount = '15.00' )
                 ( partner = '1000000001' material = 'H0002' discount = '3.50' )
                 ( partner = '1000000006' material = 'R0001' discount = '7.50' ) ).

    DELETE FROM zpdb00_disc.
    INSERT zpdb00_disc FROM TABLE @mt_disc.
  ENDMETHOD.


  METHOD create_invd.
    DO iv_count TIMES.
      DATA(ls_invh) = create_invh( ).
      create_invi( ls_invh ).
    ENDDO.

    DELETE FROM zpdb00_invh.
    INSERT zpdb00_invh FROM TABLE @mt_invh.
    DELETE FROM zpdb00_invi.
    INSERT zpdb00_invi FROM TABLE @mt_invi.
  ENDMETHOD.


  METHOD create_invh.
    DATA:
      lv_document TYPE n LENGTH 8 VALUE 30000000.

    IF mo_random_bupa IS INITIAL.
      mo_random_bupa = NEW #( iv_min = 1
                              iv_max = lines( mt_bupa ) ).
      mo_random_date = NEW #( iv_min = 1
                              iv_max = sc_days_back_from_today ).
    ENDIF.

    rs_result =
        VALUE #( document = lv_document + lines( mt_invh )
                 doc_date = CONV d( cl_abap_context_info=>get_system_date( ) - mo_random_date->rand( ) )
                 doc_time = cl_abap_context_info=>get_system_time( )
                 partner = mt_bupa[ mo_random_bupa->rand( ) ]-partner ).

    INSERT rs_result INTO TABLE mt_invh.
  ENDMETHOD.


  METHOD create_invi.
    IF mo_random_invi IS INITIAL.
      mo_random_invi =
        NEW #( iv_min = 1
               iv_max = sc_max_no_of_inv_itm ).
      mo_random_mtms =
        NEW #( iv_min = 1
               iv_max = lines( mt_mtms ) ).
      mo_random_quan =
        NEW #( iv_min = 1
               iv_max = sc_max_qty_per_inv_itm ).
    ENDIF.

    DO mo_random_invi->rand( ) TIMES.
      DATA(lv_index) = sy-index.
      DATA(lv_quan) = mo_random_quan->rand( ).
      DATA(ls_mtms) = mt_mtms[ mo_random_mtms->rand( ) ].

      TRY.
          DATA(lv_discount) = mt_disc[ partner = is_invh-partner
                                       material = ls_mtms-material ]-discount.
        CATCH cx_sy_itab_line_not_found.
          lv_discount = 0.
      ENDTRY.

      DATA(ls_invi) =
        VALUE zpdb00_invi( document = is_invh-document
                           item_no = lv_index
                           material = ls_mtms-material
                           quantity = lv_quan
                           unit = ls_mtms-stk_unit
                           price = ( lv_quan * ls_mtms-per_unit ) * ( 1 - lv_discount / 100 )
                           currency = mt_bupa[ partner = is_invh-partner ]-currency ).

      TRY.
          SELECT SINGLE FROM zpdb00_disc
            FIELDS
              currency_conversion( amount = @ls_invi-price,
                                   source_currency = @ls_mtms-currency,
                                   target_currency = @ls_invi-currency,
                                   exchange_rate_date = @is_invh-doc_date,
                                   round = @abap_true ) AS price
            INTO @ls_invi-price.

        CATCH cx_sy_open_sql_db.
          ls_invi-price = sc_error.
      ENDTRY.

      INSERT ls_invi INTO TABLE mt_invi.
    ENDDO.
  ENDMETHOD.
ENDCLASS.
