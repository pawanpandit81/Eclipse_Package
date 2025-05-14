CLASS zcl_chdo_util DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_chdo_util IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.
    DATA:
      lv_is_authorized TYPE abap_bool,

      lt_tcdobdef      TYPE if_chdo_object_tools_rel=>ty_tcdobdef_tab,
      lt_tcdobtext     TYPE if_chdo_object_tools_rel=>ty_tcdobtext_tab,
      ls_tcdgen        TYPE if_chdo_object_tools_rel=>ty_tcdgen.
*      lt_tcdobt        TYPE if_chdo_object_tools_rel=>ty_tcdobt_tabtyp.

* Authorization
    " iv_object : Change document object name
    " it_activity : Activity to be checked. Possible values '01' = create,
    " '02' = change,
    " '03' = read,
    " '06' = delete
    " it_devclass : development class of change document object
    cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~check_authorization(
                                                         EXPORTING
                                                           iv_object = 'ZPDB_BUPA'  "'ZPDBP_AUTH'
                                                           iv_activity = '03'
                                                           iv_devclass = 'ZPDB00'
                                                         RECEIVING
                                                           rv_is_authorized = lv_is_authorized ).

    IF lv_is_authorized IS INITIAL.
      out->write( |Exception occurred: authorization error.| ).
    ENDIF.

* Create and Generate
    APPEND VALUE #( tabname = 'ZPDB00_BUPA'
                    multcase = ' '
                    docudel = ' '
                    docuins = ' '
                    docud_if = ' ' ) TO lt_tcdobdef.

    APPEND VALUE #( lang_key = sy-langu
                    object_text = 'Single Case Create and Generate' ) TO lt_tcdobtext.

    ls_tcdgen =
        VALUE #( author = sy-uname
                 textcase = 'X'
                 devclass = 'ZPDB00' ).

    TRY.
        cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~create_and_generate_object(
                                                              EXPORTING
                                                                iv_object = 'ZPDB_BUPA' " change document object name
                                                                it_cd_object_def = lt_tcdobdef " change document object definition
                                                                it_cd_object_text = lt_tcdobtext " change document object text
                                                                is_cd_object_gen = ls_tcdgen " change document object  generation info
                                                                iv_cl_overwrite = 'X' " class overwrite flag
                                                                iv_corrnr = 'TRLK901019' " transport request number
                                                              IMPORTING
                                                                et_errors = DATA(lt_errors) " generation message table
                                                                et_synt_errors = DATA(lt_synt_errors)
                                                                et_synt_error_long = DATA(lt_synt_error_long) ).
      CATCH cx_chdo_generation_error INTO DATA(lr_err).
        IF lr_err IS BOUND.
          out->write( |Exception occurred: { lr_err->get_text( ) }| ).
          READ TABLE lt_errors WITH KEY kind = 'E-' INTO DATA(ls_error).
          IF sy-subrc IS INITIAL.
            out->write( |Exception occurred: { ls_error-text } | ).
*          ELSE.
*            out->write( |Change document object created and generated | ).
          ENDIF.
        ENDIF.
    ENDTRY.

* Update
    APPEND VALUE #( tabname = 'ZPDB00_BUPA'
                    multcase = 'X'
                    docudel = ' '
                    docuins = ' '
                    docud_if = ' ' ) TO lt_tcdobdef.

    APPEND VALUE #( lang_key = sy-langu
                    object_text = 'Single Case Update' ) TO lt_tcdobtext.

    ls_tcdgen =
        VALUE #( author = sy-uname
                 textcase = 'X'
                 devclass = 'ZPDB00' ).

    TRY.
        cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~update_object(
                                                              EXPORTING
                                                                iv_object          = 'ZPDB_BUPA'
                                                                it_cd_object_def   = lt_tcdobdef
                                                                it_cd_object_text  = lt_tcdobtext
                                                                is_cd_object_gen   = ls_tcdgen
                                                                iv_cl_overwrite    = 'X'
                                                                iv_corrnr          = 'TRLK901019'
                                                              IMPORTING
                                                                et_errors          = lt_errors
                                                                et_synt_errors     = lt_synt_errors
                                                                et_synt_error_long = lt_synt_error_long ).
      CATCH cx_chdo_generation_error INTO lr_err.
        IF lr_err IS BOUND.
          out->write( |Exception occurred: { lr_err->get_text( ) }| ).
          READ TABLE lt_errors WITH KEY kind = 'E-' INTO ls_error.
          IF sy-subrc IS INITIAL.
            out->write( |Exception occurred: { ls_error-text } | ).
*          ELSE.
*            out->write( |Change document object updated | ).
          ENDIF.
        ENDIF.
    ENDTRY.

* Read
    TRY.
        cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~read_object(
                                                            EXPORTING
                                                              iv_object = 'ZPDB_BUPA' " change document object name
                                                            IMPORTING
                                                              et_object_info = DATA(lt_object_info) ).    " change document object details
      CATCH cx_chdo_generation_error INTO lr_err.
        out->write( |Exception occurred: { lr_err->get_text( ) }| ).
    ENDTRY.

* Delete
    TRY.
        cl_chdo_object_tools_rel=>if_chdo_object_tools_rel~delete_object(
                                                             EXPORTING
                                                               iv_object = 'ZPDB_BUPA' " change document object name
                                                               iv_corrnr = 'TRLK901019' " transport request number
                                                               iv_del_cl_when_used = 'X' " delete class even when it s used
                                                             IMPORTING
                                                               et_errors = lt_errors ). " messages from deletion
      CATCH cx_chdo_generation_error INTO lr_err.
        IF lr_err IS BOUND.
          out->write( |Exception occurred: { lr_err->get_text( ) }| ).
          READ TABLE lt_errors WITH KEY kind = 'E-' INTO ls_error.
          IF sy-subrc IS INITIAL.
            out->write( |Exception occurred: { ls_error-text } | ).
*          ELSE.
*            out->write( |Change document object deleted | ).
          ENDIF.
        ENDIF.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
