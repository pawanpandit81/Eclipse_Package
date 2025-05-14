CLASS zcl_pdb_comp_model_gen DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb_comp_model_gen IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
*    DATA:
*      lt_name TYPE SORTED TABLE OF zpdb00_t001 WITH UNIQUE KEY name.
*
*    lt_name =
*        VALUE #( ( name = 'SAP'
*                   branch = 'Software'
*                   description = 'SAP SE is a German multinational software company based in Walldorf, Baden-Württemberg. It develops enterprise software to manage business operations and customer relations.' )
*                 ( name = 'Microsoft'
*                   branch = 'Software'
*                   description = 'Microsoft Corporation is an American multinational technology corporation producing computer software, consumer electronics, personal computers, and related services.' )
*                 ( name = 'BMW'
*                   branch = 'Automotive Industry'
*                   description = 'Bayerische Motoren Werke AG, abbreviated as BMW, is a German multinational manufacturer of luxury vehicles and motorcycles headquartered in Munich, Bavaria.' )
*                 ( name = 'Nestle'
*                   branch = 'Food'
*                   description = 'Nestlé S.A. is a Swiss multinational food and drink processing conglomerate corporation headquartered in Vevey, Vaud, Switzerland.' )
*                 ( name = 'Amazon'
*                   branch = 'Online Trade'
*                   description = 'Amazon.com, Inc. is an American multinational technology company focusing on e-commerce, cloud computing, online advertising, digital streaming, and artificial intelligence.' ) ).
*
*    INSERT zpdb00_t001 FROM TABLE @lt_name.
*    out->write( sy-dbcnt ).
*    COMMIT WORK.

    DATA:
      lt_comp        TYPE STANDARD TABLE OF zpdb00_i_r_t001,

      lo_http_client TYPE REF TO if_web_http_client.

    " Create http client
    TRY.
*        DATA(lo_destination) =
*            cl_http_destination_provider=>create_by_comm_arrangement(
*                                                     comm_scenario  = 'ZPDB00_CS'
*                                                     comm_system_id = '<Comm System Id>'
*                                                     service_id     = 'ZPDB00_I_R_SB_T001_0001_G4BA' ).
        DATA(lo_destination) =
            cl_http_destination_provider=>create_by_url(
                i_url = 'https://11b69711-9bcb-491b-b504-a9ba7e4b7e97.abap-web.us10.hana.ondemand.com/sap/opu/odata4/sap/zpdb00_i_r_sb_t001/srvd_a2x/sap/zpdb00_i_r_sd_t001/0001/?sap-client=100' ).
        lo_http_client =
            cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).

        DATA(lo_client_proxy) =
            cl_web_odata_client_factory=>create_v2_remote_proxy(
              EXPORTING
                iv_service_definition_name = 'ZPDB00_I_SCM'
                io_http_client             = lo_http_client "->get_client( )
                iv_relative_service_root   = '/sap/opu/odata4/sap/zpdb00_i_r_sb_t001/srvd_a2x/sap/zpdb00_i_r_sd_t001/0001/' ).

        DATA(lo_request) =
            lo_client_proxy->create_resource_for_entity_set( 'ZPDB00_I_R_T001' )->create_request_for_read( ).
        lo_request->set_top( 50 )->set_skip( 0 ).

        DATA(lo_response) = lo_request->execute( ).
        lo_response->get_business_data( IMPORTING et_business_data = lt_comp ).

        out->write( 'Data on-premise found:' ).
        out->write( lt_comp ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error cx_root INTO DATA(lo_error).
        out->write( lo_error->get_text( ) ).
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
