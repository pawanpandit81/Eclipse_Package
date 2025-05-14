CLASS zcl_zpdb_bupa_chdo DEFINITION
  PUBLIC
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_chdo_enhancements .

    TYPES:
      BEGIN OF ty_zpdb00_bupa .
        INCLUDE TYPE zpdb00_bupa.
        INCLUDE TYPE if_chdo_object_tools_rel=>ty_icdind.
  TYPES END OF ty_zpdb00_bupa .
    TYPES:
      tt_zpdb00_bupa TYPE STANDARD TABLE OF ty_zpdb00_bupa .

    CLASS-DATA objectclass TYPE if_chdo_object_tools_rel=>ty_cdobjectcl READ-ONLY VALUE 'ZPDB_BUPA' ##NO_TEXT.

    CLASS-METHODS write
      IMPORTING
        !objectid                TYPE if_chdo_object_tools_rel=>ty_cdobjectv
        !utime                   TYPE if_chdo_object_tools_rel=>ty_cduzeit
        !udate                   TYPE if_chdo_object_tools_rel=>ty_cddatum
        !username                TYPE if_chdo_object_tools_rel=>ty_cdusername
        !planned_change_number   TYPE if_chdo_object_tools_rel=>ty_planchngnr DEFAULT space
        !object_change_indicator TYPE if_chdo_object_tools_rel=>ty_cdchngindh DEFAULT 'U'
        !planned_or_real_changes TYPE if_chdo_object_tools_rel=>ty_cdflag DEFAULT space
        !no_change_pointers      TYPE if_chdo_object_tools_rel=>ty_cdflag DEFAULT space
        !xzpdb00_bupa            TYPE tt_zpdb00_bupa OPTIONAL
        !yzpdb00_bupa            TYPE tt_zpdb00_bupa OPTIONAL
        !upd_zpdb00_bupa         TYPE if_chdo_object_tools_rel=>ty_cdchngindh DEFAULT space
      EXPORTING
        VALUE(changenumber)      TYPE if_chdo_object_tools_rel=>ty_cdchangenr
      RAISING
        cx_chdo_write_error .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_zpdb_bupa_chdo IMPLEMENTATION.


  METHOD write.
*"----------------------------------------------------------------------
*"         this WRITE method is generated for object ZPDB_BUPA
*"         never change it manually, please!        :03/22/2025
*"         All changes will be overwritten without a warning!
*"
*"         CX_CHDO_WRITE_ERROR is used for error handling
*"----------------------------------------------------------------------

    DATA: l_upd        TYPE if_chdo_object_tools_rel=>ty_cdchngind.

    CALL METHOD cl_chdo_write_tools=>changedocument_open
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        planned_change_number   = planned_change_number
        planned_or_real_changes = planned_or_real_changes.

    IF ( yzpdb00_bupa IS INITIAL ) AND
       ( xzpdb00_bupa IS INITIAL ).
      l_upd  = space.
    ELSE.
      l_upd = upd_zpdb00_bupa.
    ENDIF.

    IF l_upd NE space.
      CALL METHOD cl_chdo_write_tools=>changedocument_multiple_case
        EXPORTING
          tablename        = 'ZPDB00_BUPA'
          change_indicator = upd_zpdb00_bupa
          docu_delete      = 'X'
          docu_insert      = 'X'
          docu_delete_if   = 'X'
          docu_insert_if   = 'X'
          table_old        = yzpdb00_bupa
          table_new        = xzpdb00_bupa.
    ENDIF.

    CALL METHOD cl_chdo_write_tools=>changedocument_close
      EXPORTING
        objectclass             = objectclass
        objectid                = objectid
        date_of_change          = udate
        time_of_change          = utime
        username                = username
        object_change_indicator = object_change_indicator
        no_change_pointers      = no_change_pointers
      IMPORTING
        changenumber            = changenumber.

  ENDMETHOD.
ENDCLASS.
