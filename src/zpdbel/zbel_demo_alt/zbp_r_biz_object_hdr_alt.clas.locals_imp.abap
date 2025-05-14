CLASS lhc_BusinessObjectHeaderAlt DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR BusinessObjectHeaderAlt RESULT result.

ENDCLASS.

CLASS lhc_BusinessObjectHeaderAlt IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZR_BIZ_OBJECT_HDR_ALT DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZR_BIZ_OBJECT_HDR_ALT IMPLEMENTATION.

  METHOD save_modified.
   IF update-businessobjectheaderalt IS NOT INITIAL.

      DATA : header_status_changed TYPE STRUCTURE FOR EVENT zr_biz_object_hdr_alt~StatusChanged.

      READ ENTITIES OF zr_biz_object_hdr_alt IN LOCAL MODE
        ENTITY BusinessObjectHeaderAlt FIELDS ( BusinessObjectID BusinessObjectNotes BusinessObjectStatus )
        WITH CORRESPONDING #( update-businessobjectheaderalt )
        RESULT DATA(changed_obj_hdr)
        FAILED DATA(ch_failed).

      DATA(lv_objid) =  changed_obj_hdr[ 1 ]-BusinessObjectID.

      SELECT SINGLE * FROM zr_biz_object_hdr_alt WHERE BusinessObjectID = @lv_objid  INTO @DATA(ls_header).
      IF sy-subrc = 0.
        IF ls_header-BusinessObjectStatus <> changed_obj_hdr[ 1 ]-BusinessObjectStatus.

          header_status_changed-BusinessObjectID             = lv_objid.
          header_status_changed-BusinessObjectStatus         = changed_obj_hdr[ 1 ]-BusinessObjectStatus.
          header_status_changed-PreviousBusinessObjectStatus = ls_header-BusinessObjectStatus.

          RAISE ENTITY EVENT zr_biz_object_hdr_Alt~StatusChanged
          FROM VALUE #( ( %key  = CORRESPONDING #( header_status_changed )
                          %param = CORRESPONDING #( header_status_changed ) ) ).

        ENDIF.

      ENDIF.


    ENDIF.


    IF update-businessobjectitemalt IS NOT INITIAL.
      DATA: item_status_changed TYPE STRUCTURE FOR EVENT zr_biz_object_hdr_Alt~ItemStatusChanged,
            item_qty_changed    TYPE STRUCTURE FOR EVENT zr_biz_object_hdr_Alt~ItemQuantityChanged.



      READ ENTITIES OF zr_biz_object_hdr_alt IN LOCAL MODE
        ENTITY BusinessObjectItemAlt FIELDS ( BusinessObjectID BusinessObjectItem BusinessObjectItemNotes BusinessObjectItemStatus
                                           BusinessObjectItemQuantity BusinessObjectItemUom )
        WITH CORRESPONDING #( update-businessobjectitemalt )
        RESULT DATA(changed_obj_itm)
        FAILED DATA(ch_failed_itm).


      DATA(lv_hdr) = changed_obj_itm[ 1 ]-BusinessObjectID.
      DATA(lv_itm) = changed_obj_itm[ 1 ]-BusinessObjectItem.
      SELECT SINGLE * FROM zr_biz_object_item_alt WHERE BusinessObjectID = @lv_hdr AND
                                                    BusinessObjectItem = @lv_itm
                                                    INTO @DATA(ls_item).

      IF sy-subrc = 0.
        IF ls_item-BusinessObjectItemStatus  <> changed_obj_itm[ 1 ]-BusinessObjectItemStatus.
          item_status_changed-BusinessObjectID = lv_hdr.
          item_status_changed-BusinessObjectItem = lv_itm.
          item_status_changed-BusinessObjectItemStatus = changed_obj_itm[ 1 ]-BusinessObjectItemStatus.
          item_status_changed-PrevBusinessObjectItemStatus =  ls_item-BusinessObjectItemStatus.

          RAISE ENTITY EVENT zr_biz_object_hdr_Alt~ItemStatusChanged
                  FROM VALUE #( (  %key  = CORRESPONDING #( item_status_changed )
                                   %param = CORRESPONDING #( item_status_changed ) ) ).


        ENDIF.

        IF ls_item-BusinessObjectItemQuantity   <> changed_obj_itm[ 1 ]-BusinessObjectItemQuantity .
          item_qty_changed-BusinessObjectID   = lv_hdr.
          item_qty_changed-BusinessObjectItem = lv_itm.
          item_qty_changed-BusinessObjectItemQuantity  = changed_obj_itm[ 1 ]-BusinessObjectItemQuantity .
          item_qty_changed-BusinessObjectItemUom       = changed_obj_itm[ 1 ]-BusinessObjectItemUom.
          item_qty_changed-PrevBusinessObjectItemQuantity  = ls_item-BusinessObjectItemQuantity.
          item_qty_changed-PrevBusinessObjectItemUom      = ls_item-BusinessObjectItemUom .

          RAISE ENTITY EVENT zr_biz_object_hdr_Alt~ItemQuantityChanged
                  FROM VALUE #( (  %key  = CORRESPONDING #( item_qty_changed )
                                   %param = CORRESPONDING #( item_qty_changed ) ) ).

        ENDIF.




      ENDIF.



    ENDIF.

  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
