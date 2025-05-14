CLASS zcl_update_bizobj DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_update_bizobj IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.



    SELECT *
      FROM zbiz_object_hdr
      ORDER BY objid DESCENDING
      INTO @DATA(ls_record)
       UP TO 1 ROWS.
    ENDSELECT.


    SELECT SINGLE * FROM zbiz_object_item WHERE objid = @ls_record-objid  INTO @DATA(ls_item).

    DATA random_number  TYPE i.
    DATA random_generator  TYPE REF TO cl_abap_random.

    random_generator = cl_abap_random=>create(
                        seed = 1
                       ).


  try.
    random_generator->intinrange(
       EXPORTING
        low   = 1
         high  = 9
       RECEIVING
        value = random_number
    ).
     CATCH cx_abap_random.
    ENDTRY.


    DATA(lv_hstat) = |H{ random_number }| .

    WHILE lv_hstat = ls_record-status.
      random_generator->int(
          RECEIVING
            value = random_number
        ).
      lv_hstat = |H{ random_number }| .

    ENDWHILE.



    DATA(lv_istat) = |I{ random_number }| .

    WHILE lv_istat = ls_item-itemstatus.
      random_generator->int(
          RECEIVING
            value = random_number
        ).
      lv_istat = |I{ random_number }| .

    ENDWHILE.


    MODIFY ENTITIES OF zr_biz_object_hdr
               ENTITY BusinessObjectHeader
                 UPDATE
                   FIELDS (
                                BusinessObjectNotes BusinessObjectStatus  )
                   WITH VALUE #( (
                                   %data    = VALUE #(
                                                        BusinessObjectID      =  ls_record-objid
                                                        BusinessObjectNotes   =  'Header Status Update'
                                                       BusinessObjectStatus   = lv_hstat  ) ) )
                     MAPPED   DATA(ls_mapped_hd)
                     FAILED   DATA(ls_failed_hd) ##NEEDED
                     REPORTED DATA(ls_reported_hd).

    COMMIT ENTITIES .


    DATA: lv_random_number TYPE p DECIMALS 3,
          lv_integer_part  TYPE i,
          lv_fraction_part TYPE p DECIMALS 3.


    lv_random_number = ls_item-quantity.

    WHILE lv_random_number = ls_item-quantity.

      lv_integer_part  = ( sy-uzeit MOD 401 ) + 100.
      lv_fraction_part = ( sy-uzeit MOD 100 ) / 100.

      lv_random_number = lv_integer_part + lv_fraction_part.

    ENDWHILE.




    MODIFY ENTITIES OF zr_biz_object_hdr
               ENTITY BusinessObjectItem
                 UPDATE
                   FIELDS (
                                    BusinessObjectItemNotes  BusinessObjectItemStatus  BusinessObjectItemQuantity    )
                   WITH VALUE #( (
                                   %data    = VALUE #(
                                                        BusinessObjectID      =  ls_record-objid
                                                        BusinessObjectItem    =  ls_item-item
                                                        BusinessObjectItemNotes   =  'Item Status Update'
                                                        BusinessObjectItemStatus   = lv_istat
                                                        BusinessObjectItemQuantity = lv_random_number
                                                         BusinessObjectItemUom   =  ls_item-uom
                                                        ) ) )
                     MAPPED   DATA(ls_mapped_it)
                     FAILED   DATA(ls_failed_it) ##NEEDED
                     REPORTED DATA(ls_reported_it).

    COMMIT ENTITIES .





  ENDMETHOD.
ENDCLASS.
