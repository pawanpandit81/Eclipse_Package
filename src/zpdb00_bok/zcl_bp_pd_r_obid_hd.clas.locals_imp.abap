CLASS lcl_hc_BOHead DEFINITION
                    INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys   REQUEST requested_authorizations FOR BOHead
      RESULT
        result.

**  FOR MODIFY method declaration
*    METHODS modify_method FOR MODIFY
*      IMPORTING
*        create_import_parameter      FOR CREATE BOHead
*        update_import_parameter      FOR UPDATE BOHead
*        delete_import_parameter      FOR DELETE BOHead
*        action_import_parameter      FOR ACTION BOHead~action_name
*          REQUEST requested-fields
*          RESULT action_export_parameter
*        create_ba_import_parameter   FOR CREATE BOHead\_Item.
*
**  FOR AUTHORIZATION method declaration      */
*    METHODS auth_method FOR AUTHORIZATION
*      IMPORTING keys REQUEST requested_features FOR BOHead
*      RESULT    result_parameter.
*
**  FOR FEATURES method declaration  */
*    METHODS feature_ctrl_method      FOR FEATURES
*      IMPORTING keys REQUEST requested_features FOR BOHead
*      RESULT    result_parameter.
*
**  FOR GLOBAL FEATURES method declaration */
*    METHODS get_global_features FOR GLOBAL FEATURES
*      IMPORTING  REQUEST requested_features FOR BOHead
*      RESULT result_parameter.
*
**  FOR LOCK method declaration      */
*    METHODS lock_method FOR LOCK
*      IMPORTING lock_import_parameter FOR LOCK BOHead.
*
**  FOR READ method declaration      */
*    METHODS read_method FOR READ
*      IMPORTING read_import_parameter FOR READ BOHead
*      RESULT read_export_parameter.
*
**  FOR READ by association method    */
*    METHODS read_by_assoc_method_name  FOR READ
*      IMPORTING read_ba_import_parameter FOR READ BOHead\_Item
*      FULL full_read_import_parameter
*      RESULT read_result_parameter
*      LINK read_link_parameter.
ENDCLASS.

CLASS lcl_hc_BOHead IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.

CLASS lcl_sc_ZPD_R_OBID_HD DEFINITION
                           INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.
*    METHODS finalize REDEFINITION.
*
*    METHODS check_before_save REDEFINITION.
*
*    METHODS adjust_numbers REDEFINITION.
*
*    METHODS save REDEFINITION.
*
*    METHODS cleanup REDEFINITION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.
ENDCLASS.

CLASS lcl_sc_ZPD_R_OBID_HD IMPLEMENTATION.

  METHOD save_modified.
    IF update-bohead IS NOT INITIAL.
      DATA
        header_status_changed TYPE STRUCTURE FOR EVENT zpd_r_obid_hd~StatusChanged.

      READ ENTITIES OF zpd_r_obid_hd IN LOCAL MODE
        ENTITY BOHead
            FIELDS ( BOObjid BONotes BOStatus )
                WITH CORRESPONDING #( update-bohead )
                RESULT DATA(changed_obj_hdr)
                    FAILED DATA(ch_failed).

      DATA(lv_objid) =  changed_obj_hdr[ 1 ]-BOObjid.

      SELECT SINGLE *
        FROM zpd_r_obid_hd
            WHERE BOObjid = @lv_objid
                INTO @DATA(ls_header).
      IF sy-subrc = 0.
        IF ls_header-BOStatus <> changed_obj_hdr[ 1 ]-BOStatus.
          header_status_changed-BOObjid             = lv_objid.
          header_status_changed-BOHStatus         = changed_obj_hdr[ 1 ]-BOStatus.
          header_status_changed-_before-BOHStatus = ls_header-BOStatus.

          RAISE ENTITY EVENT zpd_r_obid_hd~StatusChanged
            FROM VALUE #( ( %key  = CORRESPONDING #( header_status_changed )
                            %param = CORRESPONDING #( header_status_changed ) ) ).
        ENDIF.
      ENDIF.
    ENDIF.

    IF update-boitem IS NOT INITIAL.
      DATA: item_status_changed TYPE STRUCTURE FOR EVENT zpd_r_obid_it~ItemStatusChanged,
            item_qty_changed    TYPE STRUCTURE FOR EVENT zpd_r_obid_it~ItemQuantityChanged.

      READ ENTITIES OF zpd_r_obid_hd IN LOCAL MODE
        ENTITY BOItem
        FIELDS ( BOObjid BOItem BONotes BOStatus BOQuant BOUom )
        WITH CORRESPONDING #( update-boitem )
        RESULT DATA(changed_obj_itm)
        FAILED DATA(ch_failed_itm).

      DATA(lv_hdr) = changed_obj_itm[ 1 ]-BOObjid.
      DATA(lv_itm) = changed_obj_itm[ 1 ]-BOItem.

      SELECT SINGLE *
        FROM zpd_r_obid_it
        WHERE BOObjid = @lv_hdr
          AND BOItem = @lv_itm
          INTO @DATA(ls_item).
      IF sy-subrc = 0.
        IF ls_item-BOStatus <> changed_obj_itm[ 1 ]-BOStatus.
          item_status_changed-BOObjid = lv_hdr.
          item_status_changed-BOItem = lv_itm.
          item_status_changed-BOIStatus = changed_obj_itm[ 1 ]-BOStatus.
          item_status_changed-_before-BOIStatus =  ls_item-BOStatus.

          RAISE ENTITY EVENT zpd_r_obid_it~ItemStatusChanged
                  FROM VALUE #( (  %key  = CORRESPONDING #( item_status_changed )
                                   %param = CORRESPONDING #( item_status_changed ) ) ).
        ENDIF.

        IF ls_item-BOQuant   <> changed_obj_itm[ 1 ]-BOQuant.
          item_qty_changed-BOObjid = lv_hdr.
          item_qty_changed-BOItem = lv_itm.
          item_qty_changed-BOIQuantity = changed_obj_itm[ 1 ]-BOQuant .
          item_qty_changed-BOIUom = changed_obj_itm[ 1 ]-BOUom.
          item_qty_changed-_before-BOIQuantity = ls_item-BOQuant.
          item_qty_changed-_before-BOIUom = ls_item-BOUom.

          RAISE ENTITY EVENT zpd_r_obid_it~ItemQuantityChanged
                  FROM VALUE #( (  %key  = CORRESPONDING #( item_qty_changed )
                                   %param = CORRESPONDING #( item_qty_changed ) ) ).
        ENDIF.
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.
ENDCLASS.
