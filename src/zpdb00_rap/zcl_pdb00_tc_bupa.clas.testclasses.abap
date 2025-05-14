"!@testing ZPDB00_I_R_BUPA
CLASS lcl_tc_zpdb00_i_r_bupa DEFINITION
                             FINAL
                             FOR TESTING RISK LEVEL HARMLESS DURATION SHORT.

  PRIVATE SECTION.
    CLASS-DATA environment TYPE REF TO if_cds_test_environment.

    DATA td_zpdb00_bupa TYPE STANDARD TABLE OF zpdb00_bupa WITH EMPTY KEY.
    DATA act_results TYPE STANDARD TABLE OF zpdb00_i_r_bupa WITH EMPTY KEY.

    "! In CLASS_SETUP, corresponding doubles and clone(s) for the CDS view under test and its dependencies are created.
    CLASS-METHODS class_setup
      RAISING
        cx_static_check.
    "! In CLASS_TEARDOWN, Generated database entities (doubles & clones) should be deleted at the end of test class execution.
    CLASS-METHODS class_teardown.

    "! SETUP method creates a common start state for each test method,
    "! clear_doubles clears the test data for all the doubles used in the test method before each test method execution.
    METHODS setup
      RAISING
        cx_static_check.
    "! Check for value greater than 1000
    METHODS above_threshold FOR TESTING.
    "! Check for value lower than 1000
    METHODS below_threshold FOR TESTING.
    "! Check for initial value
    METHODS initial_value FOR TESTING.
    "! Check for value 1000
    METHODS equal_to_threshold FOR TESTING.
    METHODS prepare_testdata.
    "! In this method test data is inserted into the generated double(s) and the test is executed and
    "! the results should be asserted with the actuals.
    METHODS aunit_for_cds_method FOR TESTING
      RAISING
        cx_static_check.
ENDCLASS.


CLASS lcl_tc_zpdb00_i_r_bupa IMPLEMENTATION.

  METHOD class_setup.
    environment = cl_cds_test_environment=>create( i_for_entity = 'ZPDB00_I_R_BUPA' ).
  ENDMETHOD.

  METHOD setup.
    environment->clear_doubles( ).
  ENDMETHOD.

  METHOD class_teardown.
    environment->destroy( ).
  ENDMETHOD.

  METHOD aunit_for_cds_method.
    prepare_testdata( ).
    SELECT * FROM zpdb00_i_r_bupa INTO TABLE @act_results.
    cl_abap_unit_assert=>fail( msg = 'Place your assertions here' ).
  ENDMETHOD.

  METHOD prepare_testdata.
    " Prepare test data for 'zpdb00_bupa'
    td_zpdb00_bupa =
        VALUE #( ( client = '100'
                   partner = '1000000001' ) ).
    environment->insert_test_data( i_data = td_zpdb00_bupa ).
  ENDMETHOD.

  METHOD above_threshold.

  ENDMETHOD.

  METHOD below_threshold.

  ENDMETHOD.

  METHOD equal_to_threshold.

  ENDMETHOD.

  METHOD initial_value.

  ENDMETHOD.

ENDCLASS.
