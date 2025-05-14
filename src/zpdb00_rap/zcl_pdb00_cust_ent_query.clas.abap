CLASS zcl_pdb00_cust_ent_query DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_rap_query_provider .
  PROTECTED SECTION.
  PRIVATE SECTION.
    TYPES:
      tt_result TYPE STANDARD TABLE OF zpdb00_i_r_t001 WITH EMPTY KEY.

    CONSTANTS:
      gc_destination TYPE string VALUE `<destination-service-id>`,
      gc_entity      TYPE /iwbep/if_cp_runtime_types=>ty_entity_set_name VALUE 'Company'.

    METHODS:
      get_proxy
        RETURNING
          VALUE(ro_result) TYPE REF TO /iwbep/if_cp_client_proxy,

      read_data_by_request
        IMPORTING
          io_request TYPE REF TO if_rap_query_request
        EXPORTING
          et_result  TYPE tt_result
          ev_count   TYPE int8.
ENDCLASS.


CLASS zcl_pdb00_cust_ent_query IMPLEMENTATION.

  METHOD if_rap_query_provider~select.
    DATA
      lv_orderby TYPE string.

    IF io_request->is_data_requested( ).
      DATA(lv_top) = io_request->get_paging( )->get_page_size( ).

      IF lv_top < 0.
        lv_top = 1.
      ENDIF.

      DATA(lv_skip) = io_request->get_paging( )->get_offset( ).

      DATA(lt_sort) = io_request->get_sort_elements( ).

      LOOP AT lt_sort
        ASSIGNING FIELD-SYMBOL(<fs_sort>).
        IF <fs_sort>-descending = abap_true.
          lv_orderby = |'{ lv_orderby } { <fs_sort>-element_name } DESCENDING '|.
        ELSE.
          lv_orderby = |'{ lv_orderby } { <fs_sort>-element_name } ASCENDING '|.
        ENDIF.
      ENDLOOP.

      IF lv_orderby IS INITIAL.
        lv_orderby = 'NAME'.
      ENDIF.

      DATA(lv_conditions) = io_request->get_filter( )->get_as_sql_string( ).

      SELECT FROM zpdb00_t001
        FIELDS name, branch, description
        WHERE (lv_conditions)
        ORDER BY (lv_orderby)
        INTO TABLE @DATA(lt_t001)
        UP TO @lv_top ROWS
        OFFSET @lv_skip.

*      IF io_request->is_total_numb_of_rec_requested( ).
*        io_response->set_total_number_of_records( lines( lt_t001 ) ).
*        io_response->set_data( it_data = lt_t001 ).
*      ENDIF.
*    ENDIF.

*    " Read data from OData on-premise
*    read_data_by_request(
*      EXPORTING
*        io_request = io_request
*      IMPORTING
*        et_result  = DATA(lt_result)
*        ev_count   = DATA(lv_count) ).

      " Handle data over to respone
      IF io_request->is_total_numb_of_rec_requested( ).
        io_response->set_total_number_of_records( lines( lt_t001 ) ).
      ENDIF.

      IF io_request->is_data_requested(  ).
        io_response->set_data( lt_t001 ).
      ENDIF.
    ENDIF.
  ENDMETHOD.

  METHOD get_proxy.
    TRY.
        DATA(lo_destination) =
            cl_http_destination_provider=>create_by_cloud_destination(
                                              i_name       = gc_destination
                                              i_service_instance_name = 'https://11b69711-9bcb-491b-b504-a9ba7e4b7e97.abap-web.us10.hana.ondemand.com'
                                              i_authn_mode = if_a4c_cp_service=>service_specific ).

        DATA(lo_client) =
            cl_web_http_client_manager=>create_by_http_destination( i_destination = lo_destination ).

        ro_result =
            cl_web_odata_client_factory=>create_v2_remote_proxy(
              EXPORTING
                iv_service_definition_name = 'ZPDB00_I_R_SD_T001'
                io_http_client             = lo_client
                iv_relative_service_root   = '/sap/opu/odata4/sap/zpdb00_i_r_sb_t001/srvd_a2x/sap/zpdb00_i_r_sd_t001/0001/' ).

      CATCH cx_http_dest_provider_error cx_web_http_client_error /iwbep/cx_gateway cx_root.
    ENDTRY.
  ENDMETHOD.


  METHOD read_data_by_request.
    DATA:
      lo_root_filter_node TYPE REF TO /iwbep/if_cp_filter_node.

*    TRY.
*        DATA(lo_request) = get_proxy( )->create_resource_for_entity_set( c_entity )->create_request_for_read( ).

    " Get informations from request
*        DATA(lt_filter_condition) = io_request->get_filter( )->get_as_ranges( ).
*        DATA(lt_requested_elements) = io_request->get_requested_elements( ).
*        DATA(lt_sort_elements) = io_request->get_sort_elements( ).
*        DATA(lv_skip) = io_request->get_paging( )->get_offset( ).
*        DATA(lv_top) = io_request->get_paging( )->get_page_size( ).
*        DATA(lv_is_data_requested)  = io_request->is_data_requested( ).
*        DATA(lv_is_count_requested) = io_request->is_total_numb_of_rec_requested( ).

    " Build filter condition
*        DATA(lo_filter_factory) = lo_request->create_filter_factory( ).
*        LOOP AT lt_filter_condition
*            ASSIGNING FIELD-SYMBOL(<fs_filter>).
*          DATA(lo_filter_node) =
*            lo_filter_factory->create_by_range(
*                                    iv_property_path = <fs_filter>-name
*                                    it_range         = <fs_filter>-range ).
*
*          IF lo_root_filter_node IS INITIAL.
*            lo_root_filter_node = lo_filter_node.
*          ELSE.
*            lo_root_filter_node = lo_root_filter_node->and( lo_filter_node ).
*          ENDIF.
*        ENDLOOP.
*
*        " Set filter
*        IF lo_root_filter_node IS NOT INITIAL.
*          lo_request->set_filter( lo_root_filter_node ).
*        ENDIF.
*
*        " Set requested fields
*        IF lt_requested_elements IS NOT INITIAL.
*          lo_request->set_select_properties( CORRESPONDING #( lt_requested_elements ) ).
*        ENDIF.
*
*        " Set Sorting
*        IF lt_sort_elements IS NOT INITIAL.
*          lo_request->set_orderby( CORRESPONDING #( lt_sort_elements MAPPING property_path = element_name ) ).
*        ENDIF.
*
*        " Data requested -> Set top/skip values
*        IF ld_is_data_requested = abap_true.
*          lo_request->set_skip( CONV #( ld_skip ) ).
*
*          IF ld_top > 0.
*            lo_request->set_top( CONV #( ld_top ) ).
*          ENDIF.
*        ELSE.
*          lo_request->request_no_business_data(  ).
*        ENDIF.
*
*        " Count is requested
*        IF ld_is_count_requested = abap_true.
*          lo_request->request_count(  ).
*        ENDIF.
*
*        " Execute and return data
*        DATA(lo_response) = lo_request->execute( ).
*        lo_response->get_business_data( IMPORTING et_business_data = et_result ).
*        ev_count = lo_response->get_count( ).
*
*      CATCH cx_root.
*    ENDTRY.
  ENDMETHOD.
ENDCLASS.
