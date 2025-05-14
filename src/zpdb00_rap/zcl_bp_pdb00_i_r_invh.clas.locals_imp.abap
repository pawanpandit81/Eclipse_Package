CLASS lcl_hc_Head DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys REQUEST requested_authorizations FOR Head
      RESULT
        result.

ENDCLASS.

CLASS lcl_hc_Head IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
