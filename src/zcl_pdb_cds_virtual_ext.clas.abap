CLASS zcl_pdb_cds_virtual_ext DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_sadl_exit .
    INTERFACES if_sadl_exit_calc_element_read .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_pdb_cds_virtual_ext IMPLEMENTATION.


  METHOD if_sadl_exit_calc_element_read~calculate.
    DATA:
      view_data TYPE STANDARD TABLE OF ZPDB00_C_INVI_VIRT_PPU WITH EMPTY KEY.

    view_data = CORRESPONDING #( it_original_data ).

    LOOP AT view_data
        ASSIGNING FIELD-SYMBOL(<fs_view_data>).
        <fs_view_data>-PricePerUnit = <fs_view_data>-Price / <fs_view_data>-Quantity.
    ENDLOOP.

    ct_calculated_data = CORRESPONDING #( view_data ).
  ENDMETHOD.


  METHOD if_sadl_exit_calc_element_read~get_calculation_info.
  ENDMETHOD.
ENDCLASS.
