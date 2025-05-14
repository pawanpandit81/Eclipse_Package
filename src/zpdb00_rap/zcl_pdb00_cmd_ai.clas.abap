CLASS zcl_pdb00_cmd_ai DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_aia_action .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb00_cmd_ai IMPLEMENTATION.


  METHOD if_aia_action~run.
*    FINAL(text_result) =
*        cl_aia_result_factory=>create_text_popup_result( ).
*    text_result->set_content( 'Demo for AI ABAP Action' ).
*    result = text_result.

*    DATA html TYPE string.
*
*    DATA(focused_resources) = context->get_focused_resources( ).
*    html = '<h1>Focused Resources</h1>'.
*    html = |{ html }<p>Here are the currently focused resources from the IDE context.</p>|.
*
*    html = |{ html }<h2>Source-Based Objects</h2>|.
*    LOOP AT focused_resources ASSIGNING FIELD-SYMBOL(<focused_resource>).
*      IF <focused_resource>->get_kind( ) = if_adt_context_resource=>kind-source_based_dev_object.
*        DATA(source_based_object) = CAST if_adt_context_src_based_obj( <focused_resource> ).
*        html = |{ html }<p>{ source_based_object->get_object_info( )-display_name } ({ <focused_resource>->get_type( ) })</p>|.
*      ENDIF.
*    ENDLOOP.
*
*    html = |{ html }<h2>Form-Based Objects</h2>|.
*    LOOP AT focused_resources ASSIGNING <focused_resource>.
*      IF <focused_resource>->get_kind( ) = if_adt_context_resource=>kind-form_based_dev_object.
*        DATA(form_based_object) = CAST if_adt_context_form_based_obj( <focused_resource> ).
*        html = |{ html }<p>{ form_based_object->get_object_info( )-display_name } ({ <focused_resource>->get_type( ) })</p>|.
*      ENDIF.
*    ENDLOOP.
*
*    DATA(html_result) = cl_aia_result_factory=>create_html_popup_result( ).
*    html_result->set_content( html ).
*    result = html_result.


    DATA input TYPE zcl_pdb00_cmd_ai_ui=>ty_input.
    DATA(input_config_data) = context->get_input_config_content( ).

    IF input_config_data IS BOUND.
      TRY.
          input_config_data->get_as_structure( IMPORTING result = input ).
        CATCH cx_sd_invalid_data.
          " default template
          input = VALUE #( template = zcl_pdb00_cmd_ai_ui=>co_code_template-hello ).
      ENDTRY.
    ENDIF.

    DATA(template) = `Hello IDE Action`.
    CASE input-template.
      WHEN 'abapUnitAssertEquals'.
        template = `cl_abap_unit_assert=>assert_equals( msg = '' exp = exp act = act ).`.
      WHEN 'abapUnitSkip'.
        template = `cl_abap_unit_assert=>skip( msg = 'Skipped test' ).`.
    ENDCASE.

    DATA(focused_resource) = CAST if_adt_context_src_based_obj( context->get_focused_resource(  ) ).

    DATA(position) = focused_resource->get_position(  ).

    DATA(source_change_result) = cl_aia_result_factory=>create_source_change_result( ).
    source_change_result->add_code_insertion_delta( content = template cursor_position = position->get_end_position( ) ) ##NO_TEXT.
    result = source_change_result.

  ENDMETHOD.
ENDCLASS.
