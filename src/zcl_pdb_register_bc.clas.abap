CLASS zcl_pdb_register_bc DEFINITION
  PUBLIC
  INHERITING FROM cl_xco_cp_adt_simple_classrun
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  PROTECTED SECTION.
    METHODS:
      main REDEFINITION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb_register_bc IMPLEMENTATION.
  METHOD main.
    DATA(lo_business_configuration) =
      mbc_cp_api=>business_configuration_api( iv_technical_id = 'ZPDB00_REG_BC' ).

    TRY.
        lo_business_configuration->create(
          iv_name                      = 'Partner Detail'
          iv_description               = 'Business Partner Detail'
          iv_service_binding           = 'ZPDB00_I_R_SB_BUPA_UI_V4'
          iv_service_name              = 'ZPDB00_I_R_SD_BUPA'
          iv_service_version           = 0001
          iv_root_entity_set           = 'Partner'
          iv_transport                 = 'TRLK901019'
*          iv_configuration_group       = 'ZPDBP'
*          iv_skip_root_entity_list_rep =
*          app_configuration            =
        ).
      CATCH cx_mbc_api_exception INTO DATA(lx_mbc_api_exception).
        DATA(lt_messages) =
            lx_mbc_api_exception->if_xco_news~get_messages( ).
        LOOP AT lt_messages
            ASSIGNING FIELD-SYMBOL(<fs_message>).
          " Use lo_message->get_text( ) to get the error message.
        ENDLOOP.
    ENDTRY.
  ENDMETHOD.
ENDCLASS.
