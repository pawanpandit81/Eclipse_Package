CLASS zcl_create_bohi DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_create_bohi IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA lv_key TYPE zobid.

    TRY.
        lv_key =
            |{ cl_abap_context_info=>get_system_date( ) }{ cl_abap_context_info=>get_system_time( )  }{ cl_abap_context_info=>get_user_formatted_name( ) }|.
      CATCH  cx_abap_context_info_error INTO DATA(lo_exp_ref).
    ENDTRY.

    MODIFY ENTITIES OF zpd_r_obid_hd
        ENTITY BOHead
            CREATE
                FIELDS ( BOObjid BONotes BOStatus )
                    WITH VALUE #( ( %cid     = 'H001'
                                    %data    = VALUE #( BOObjid  = lv_key
                                                        BONotes  = 'Header Creation'
                                                        BOStatus = 'N' ) ) )
            CREATE BY \_Item
                FIELDS ( BOItem BONotes BOStatus BOQuant BOUom )
                    WITH VALUE #( ( %cid_ref = 'H001'
                                    %target = VALUE #( ( %cid     = 'I001'
                                                         BOItem   = '00001'
                                                         BONotes  = 'Item Created'
                                                         BOStatus = 'N'
                                                         BOQuant  = '100.11'
                                                         BOUom    = 'KGS' ) ) ) )
                                                         MAPPED DATA(ls_mapped)
                                                            FAILED   DATA(ls_failed)
                                                                REPORTED DATA(ls_reported).
    COMMIT ENTITIES.
  ENDMETHOD.
ENDCLASS.
