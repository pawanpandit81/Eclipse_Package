CLASS zcl_pdb_invh_vce_read DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_pdb_invh_vce_read IMPLEMENTATION.

  METHOD if_sadl_exit_calc_element_read~calculate.
    LOOP AT it_requested_calc_elements
        ASSIGNING FIELD-SYMBOL(<ls_virtual_field>).
      LOOP AT ct_calculated_data
        ASSIGNING FIELD-SYMBOL(<ls_calculated_data>).
        DATA(lv_tabix) = sy-tabix.
        ASSIGN COMPONENT <ls_virtual_field>
            OF STRUCTURE <ls_calculated_data>
                TO FIELD-SYMBOL(<lv_field>).

        DATA(ls_original) =
            CORRESPONDING zpdb00_c_r_invh( it_original_data[ lv_tabix ] ).

        IF ls_original-PartnerNo = '1000000002'.
          <lv_field> = 999.
        ELSE.
          SELECT FROM zpdb00_invi
            FIELDS COUNT( * )
            WHERE document = @ls_original-DocumentNo
            INTO @<lv_field>.
        ENDIF.
      ENDLOOP.
    ENDLOOP.
  ENDMETHOD.

  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
