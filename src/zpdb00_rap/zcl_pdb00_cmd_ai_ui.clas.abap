CLASS zcl_pdb00_cmd_ai_ui DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_aia_sd_action_input .

    CONSTANTS:
      BEGIN OF co_code_template,

        "! <p class="shorttext">Hello</p>
        "! Hello
        hello                   TYPE string VALUE 'hello',

        "! <p class="shorttext">Assert Equals</p>
        "! Assert Equals
        abap_unit_assert_equals TYPE string VALUE 'assert_equals',

        "! <p class="shorttext">Skip</p>
        "! Skip
        abap_unit_skip          TYPE string VALUE 'skip',
      END OF co_code_template.

    TYPES:
      "! <p class="shorttext">Code Template</p>
      "! Code Template
      BEGIN OF ty_input,

        "! <p class="shorttext">Code Template</p>
        "! Code Template
        "! $values {@link zcl_code_insert_input_ui_conf.data:co_code_template}
        "! $required
        template TYPE string,

      END OF        ty_input.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb00_cmd_ai_ui IMPLEMENTATION.


  METHOD if_aia_sd_action_input~create_input_config.

    DATA(input) = VALUE ty_input( template = co_code_template-hello ).

    DATA(configuration) = ui_information_factory->get_configuration_factory( )->create_for_data( input ).

    result = ui_information_factory->for_abap_type( abap_type = input ).
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_action_provider.
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_side_effect_provider.
  ENDMETHOD.


  METHOD if_aia_sd_action_input~get_value_help_provider.
  ENDMETHOD.
ENDCLASS.
