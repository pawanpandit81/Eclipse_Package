CLASS lcl_hc_Company DEFINITION
                    INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys   REQUEST requested_authorizations FOR Company
      RESULT
        result.

ENDCLASS.

CLASS lcl_hc_Company IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
