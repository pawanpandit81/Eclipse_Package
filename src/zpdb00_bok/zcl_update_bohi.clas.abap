CLASS zcl_update_bohi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_update_bohi IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    SELECT *
        FROM zpd_obid_hd
            ORDER BY objid DESCENDING
                INTO @DATA(ls_record)
                    UP TO 1 ROWS.
    ENDSELECT.

    SELECT SINGLE *
        FROM zpd_obid_it
            WHERE objid = @ls_record-objid
                INTO @DATA(ls_item).

    DATA:
      random_number    TYPE i,
      random_generator TYPE REF TO cl_abap_random.

    random_generator =
        cl_abap_random=>create( seed = 1 ).

    TRY.
        random_generator->intinrange(
                               EXPORTING
                                low   = 1
                                 high  = 9
                               RECEIVING
                                value = random_number ).
      CATCH cx_abap_random.
    ENDTRY.

    DATA(lv_hstat) = |H{ random_number }| .

    WHILE lv_hstat = ls_record-status.
      random_generator->int(
          RECEIVING
            value = random_number ).
      lv_hstat = |H{ random_number }|.
    ENDWHILE.

    DATA(lv_istat) = |I{ random_number }| .
    WHILE lv_istat = ls_item-status.
      random_generator->int(
          RECEIVING
            value = random_number ).
      lv_istat = |I{ random_number }|.
    ENDWHILE.

    MODIFY ENTITIES OF zpd_r_obid_hd
        ENTITY BOHead
            UPDATE
                FIELDS ( BONotes BOStatus )
                    WITH VALUE #( (  %data = VALUE #( BOObjid  = ls_record-objid
                                                      BONotes  = 'Header Status Update'
                                                      BOStatus = lv_hstat ) ) )
                                                      MAPPED DATA(ls_mapped_hd)
                                                        FAILED DATA(ls_failed_hd)
                                                            REPORTED DATA(ls_reported_hd).
    COMMIT ENTITIES.

    DATA:
      lv_random_number TYPE p DECIMALS 3,
      lv_integer_part  TYPE i,
      lv_fraction_part TYPE p DECIMALS 3.

    lv_random_number = ls_item-quant.
    WHILE lv_random_number = ls_item-quant.
      lv_integer_part  = ( cl_abap_context_info=>get_system_time( ) MOD 401 ) + 100.
      lv_fraction_part = ( cl_abap_context_info=>get_system_time( ) MOD 100 ) / 100.
      lv_random_number = lv_integer_part + lv_fraction_part.
    ENDWHILE.

    MODIFY ENTITIES OF zpd_r_obid_hd
        ENTITY BOItem
            UPDATE
                FIELDS ( BONotes BOStatus BOQuant )
                    WITH VALUE #( ( %data = VALUE #( BOObjid  = ls_record-objid
                                                     BOItem   = ls_item-item
                                                     BONotes  = 'Item Status Update'
                                                     BOStatus = lv_istat
                                                     BOQuant  = lv_random_number
                                                     BOUom    =  ls_item-uom ) ) )
                                                     MAPPED DATA(ls_mapped_it)
                                                        FAILED DATA(ls_failed_it)
                                                            REPORTED DATA(ls_reported_it).
    COMMIT ENTITIES .
  ENDMETHOD.
ENDCLASS.
