CLASS zcl_xco_doc_xsls DEFINITION
                       PUBLIC
                       FINAL
                       CREATE PUBLIC .
  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_xco_doc_xsls IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
*  ZLOCAL Main PAckage
    DATA(lo_software_component_filter) =
      xco_cp_system=>software_component->get_filter( io_constraint = xco_cp_abap_sql=>constraint->equal( iv_value = 'ZLOCAL' ) ).
    DATA(lo_name_filter) =
      xco_cp_abap_repository=>object_name->get_filter( io_constraint = xco_cp_abap_sql=>constraint->contains_pattern( iv_value = '%CAL%' ) ).
*    DATA(lt_object) =
*      xco_cp_abap_repository=>objects->where( it_filters = VALUE #( io_software_component_filter = ( lo_software_component_filter )
*                                                                    io_name_filter = ( lo_name_filter ) ) )->in( io_source = xco_cp_abap=>repository )->get( ).
    DATA(lt_object) =
      xco_cp_abap_repository=>objects->where( VALUE #( ( lo_software_component_filter )
                                                       ( lo_name_filter ) ) )->in( xco_cp_abap=>repository )->get( ).
    LOOP AT lt_object
      ASSIGNING FIELD-SYMBOL(<fs_object>).
      DATA(lv_object_type) = <fs_object>->type->value.
      DATA(lv_object_name) = <fs_object>->name->value.
    ENDLOOP.

*   ZPDB00 Self Package
    DATA(lo_package) =
      xco_cp_abap_repository=>package->for( iv_name = 'ZPDB00_DB' ).
    DATA(lo_filter) =
      xco_cp_table=>field_property->foreign_key_check_table->get_filter( io_constraint = xco_cp_abap_sql=>constraint->equal( iv_value = 'ZPDB00_REGN' ) ).
    DATA(lt_database_table) =
      xco_cp_abap_repository=>objects->tabl->database_tables->where( VALUE #( ( lo_filter ) ) )->in( lo_package )->get( ).
    LOOP AT lt_database_table
      ASSIGNING FIELD-SYMBOL(<fs_database_table>).
      DATA(lv_name) = <fs_database_table>->name.
    ENDLOOP.

*    DATA(lv_string) = `This is my new text string`.
*    xco_cp=>string( iv_value = lv_string )->to_upper_case( )->append( iv_string = `with addition` )->split( iv_delimiter = ` ` )->value.
  ENDMETHOD.
ENDCLASS.
