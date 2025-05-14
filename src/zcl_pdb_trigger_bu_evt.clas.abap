CLASS zcl_pdb_trigger_bu_evt DEFINITION
                             PUBLIC
                             FINAL
                             CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_pdb_trigger_bu_evt IMPLEMENTATION.

  METHOD if_oo_adt_classrun~main.

    TYPES:
      BEGIN OF ts_so_changed,
        EventRaisedDateTime  TYPE tzntstmpl,
        OrganizationDivision TYPE c LENGTH 2,
        SalesOrder           TYPE c LENGTH 10,
        SalesOrderType       TYPE c LENGTH 4,
        SalesOrganization    TYPE c LENGTH 4,
        DistributionChannel  TYPE c LENGTH 2,
        SoldToParty          TYPE c LENGTH 10,
      END OF ts_so_changed.

    DATA :
      lo_log_api     TYPE REF TO if_bel_direct_logging,
      lr_structdescr TYPE REF TO cl_abap_structdescr,
      lr_typedescr   TYPE REF TO cl_abap_typedescr,
      lo_data        TYPE REF TO data,

      lt_event       TYPE REF TO bel_t_event_data,
      lt_return      TYPE REF TO bel_t_api_return,

      lv_retcode     TYPE bel_api_retcode.

    cl_abap_typedescr=>describe_by_name(
                         EXPORTING
                            p_name = 'TS_SO_CHANGED'
                          RECEIVING
                            p_descr_ref = lr_typedescr
                          EXCEPTIONS
                            type_not_found = 1
                            OTHERS         = 2 ).
    IF sy-subrc <> 0.
*      MESSAGE ID sy-msgid TYPE sy-msgty NUMBER sy-msgno
*        WITH sy-msgv1 sy-msgv2 sy-msgv3 sy-msgv4.
    ENDIF.

    lr_structdescr =
        CAST cl_abap_structdescr( lr_typedescr ).

    CREATE DATA lo_data TYPE HANDLE lr_structdescr.
    ASSIGN lo_data->* TO FIELD-SYMBOL(<fs_data>).

    CHECK <fs_data> IS ASSIGNED.
    ASSIGN COMPONENT 'EventRaisedDateTime'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_tstp>).
    IF sy-subrc = 0.
      GET TIME STAMP FIELD <fs_tstp>.
    ENDIF.

    ASSIGN COMPONENT 'OrganizationDivision'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_od>).
    IF sy-subrc = 0.
      <fs_od> = 'AB'.
    ENDIF.

    ASSIGN COMPONENT 'SalesOrder'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_so>).
    IF sy-subrc = 0.
      <fs_so> = '0000000100'.
    ENDIF.

    ASSIGN COMPONENT 'SalesOrderType'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_sotyp>).
    IF sy-subrc = 0.
      <fs_sotyp> = 'ABCD'.
    ENDIF.

    ASSIGN COMPONENT 'SalesOrganization'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_soorg>).
    IF sy-subrc = 0.
      <fs_soorg> = 'WXYZ'.
    ENDIF.

    ASSIGN COMPONENT 'DistributionChannel'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_dc>).
    IF sy-subrc = 0.
      <fs_dc> = '01'.
    ENDIF.

    ASSIGN COMPONENT 'SoldToParty'
        OF STRUCTURE <fs_data>
            TO FIELD-SYMBOL(<fs_spty>).
    IF sy-subrc = 0.
      <fs_spty> = '2000200001'.
    ENDIF.

    CREATE DATA lt_event TYPE bel_t_event_data.
    CREATE DATA lt_return TYPE bel_t_api_return.
    lt_event->* =
        VALUE #( ( event_type = 'sap.s4.beh.salesorder.v1.SalesOrder.Changed.v1'
                   event_data = lo_data ) ).
    lo_log_api = cl_bel_direct_logging=>get_instance( ).
    lo_log_api->log_business_event(
                    EXPORTING
                      it_events = lt_event
                    IMPORTING
                      ev_retcode = lv_retcode
                    CHANGING
                      ct_return = lt_return ).
  ENDMETHOD.
ENDCLASS.
