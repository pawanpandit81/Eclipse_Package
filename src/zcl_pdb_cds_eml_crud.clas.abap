CLASS zcl_pdb_cds_eml_crud DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    METHODS read_data
      IMPORTING
        io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS insert_data
      IMPORTING
        io_out TYPE REF TO if_oo_adt_classrun_out.

    METHODS delete_data
      IMPORTING
        io_out TYPE REF TO if_oo_adt_classrun_out.
ENDCLASS.


CLASS zcl_pdb_cds_eml_crud IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA:
      lt_select TYPE TABLE FOR READ IMPORT zpdb00_r_bupa,
      lt_create TYPE TABLE FOR CREATE zpdb00_r_bupa,
      lt_update TYPE TABLE FOR UPDATE zpdb00_r_bupa.

    " Long form for selection (ALL FIELDS)
    lt_select =
        VALUE #( ( PartnerNo = '1000000001' )
                 ( PartnerNo = '1000000003' ) ).

*    READ ENTITIES OF zpdb00_r_bupa
*        ENTITY Partner
*            ALL FIELDS
*                WITH lt_select
*                    RESULT DATA(lt_partner_l)
*                        FAILED DATA(ls_fail)
*                            REPORTED DATA(ls_report).
*
*    out->write( lt_partner_l ).
*
*    " Short form for selection (SOME FIELDS)
*    READ ENTITIES OF zpdb00_r_bupa
*        ENTITY Partner
*            FIELDS ( Name Street City )
*                WITH VALUE #( ( PartnerNo = '1000000001' )
*                              ( PartnerNo = '1000000003' ) )
*                              RESULT DATA(lt_partner_s)
*                                FAILED DATA(ls_fail)
*                                    REPORTED DATA(ls_report).
*
*    out->write( lt_partner_s ).

*    " Create new partner
*    lt_create =
*        VALUE #( ( %cid = 'DummyKey1'
*                   PartnerNo = '1000000008'
*                   Name = 'NTT Data'
*                   Country = 'IN'
*                   %control-PartnerNo = if_abap_behv=>mk-on
*                   %control-Name = if_abap_behv=>mk-on
*                   %control-Country = if_abap_behv=>mk-on ) ).
*
*    MODIFY ENTITIES OF zpdb00_r_bupa
*        ENTITY Partner
*            CREATE FROM lt_create
*                FAILED DATA(ls_fail)
*                    MAPPED DATA(ls_mapp)
*                        REPORTED DATA(ls_report).
*
*    TRY.
*        out->write( ls_mapp-partner[ 1 ]-PartnerNo ).
*        COMMIT ENTITIES.
*
*      CATCH cx_sy_itab_line_not_found.
*        out->write( ls_fail-partner[ 1 ]-%cid ).
*    ENDTRY.
*
*    " Update partner
    lt_update =
        VALUE #( ( PartnerNo = '1000000008'
                   Name = 'NTT GDC'
                   City = 'Seattle'
                   Currency = 'USD'
                   %control-Currency = if_abap_behv=>mk-on
                   %control-City = if_abap_behv=>mk-on ) ).

    MODIFY ENTITIES OF zpdb00_r_bupa
        ENTITY Partner
            UPDATE FROM lt_update
                FAILED DATA(ls_fail)
                    MAPPED DATA(ls_mapp)
                        REPORTED DATA(ls_report).

    IF ls_fail-partner IS INITIAL.
      out->write( 'Updated' ).
      COMMIT ENTITIES.
    ENDIF.

*    read_data( out ).
*    insert_data( out ).
*    delete_data( out ).
  ENDMETHOD.
  METHOD delete_data.
    DATA
      lt_filter TYPE STANDARD TABLE OF zpdb00_i_r_invh WITH EMPTY KEY.

    lt_filter =
        VALUE #( ( DocumentNo = '30000000' )
                 ( DocumentNo = '30000005' ) ).

    READ ENTITIES OF zpdb00_i_r_invh
        ENTITY Head
            ALL FIELDS WITH CORRESPONDING #( lt_filter )
                RESULT DATA(lt_head)
                    ENTITY Head BY \_Item
                        FIELDS ( DocumentNo ItemNo MaterialNo )
                            WITH CORRESPONDING #( lt_filter )
                                RESULT DATA(lt_item)
                                    FAILED FINAL(ls_failed).

    IF ls_failed-head IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ENDIF.

    io_out->write( `Invoices:` ).
    io_out->write( lt_head ).
    io_out->write( `Positions:` ).
    io_out->write( lt_item ).
  ENDMETHOD.

  METHOD insert_data.
    DATA:
      lt_head TYPE TABLE FOR CREATE zpdb00_i_r_invh,
      lt_item TYPE TABLE FOR CREATE zpdb00_i_r_invh\_Item.

    lt_head =
        VALUE #( ( %cid     = 'H1'
*                   %key     =
*                   %data    =
                   DocumentNo = '40000000'
                   PartnerNo  = '1000000004'
                   %control = VALUE #( DocumentNo = if_abap_behv=>mk-on
                                       PartnerNo = if_abap_behv=>mk-on ) ) ).

    lt_item =
        VALUE #( ( %cid_ref = 'H1'
*                   %key     =
*                   %pky     =
*                   %pky     =
                   %target  = VALUE #( ( %cid           = 'I1'
*                                         %key     =
*                                         %data    =
                                         ItemNo = 1
                                         MaterialNo     = 'R0001'
                                         %control       = VALUE #( ItemNo = if_abap_behv=>mk-on
                                                                   MaterialNo = if_abap_behv=>mk-on ) )
                                       ( %cid           = 'I2'
*                                          %key     =
*                                          %data    =
                                          ItemNo = 2
                                          Price          = '2.20'
                                          Currency       = 'EUR'
                                           %control       = VALUE #( ItemNo = if_abap_behv=>mk-on
                                                                     Price = if_abap_behv=>mk-on
                                                                     Currency = if_abap_behv=>mk-on ) ) ) ) ).

    MODIFY ENTITIES OF zpdb00_i_r_invh
        ENTITY Head
            CREATE FROM lt_head
                ENTITY Head
                    CREATE BY \_Item FROM lt_item
                        FAILED DATA(ls_failed).

    COMMIT ENTITIES.

    IF ls_failed-head IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ELSE.
      io_out->write( `Creation OK` ).
    ENDIF.
  ENDMETHOD.

  METHOD read_data.
    DATA
      lt_filter TYPE STANDARD TABLE OF zpdb00_i_r_invh WITH EMPTY KEY.

    lt_filter =
        VALUE #( ( DocumentNo = '40000000' ) ).

    MODIFY ENTITIES OF zpdb00_i_r_invh
        ENTITY Head
            DELETE FROM CORRESPONDING #( lt_filter )
                FAILED DATA(ls_failed).

    COMMIT ENTITIES.

    IF ls_failed-head IS NOT INITIAL.
      io_out->write( `Failed!` ).
    ELSE.
      io_out->write( `Deletion OK` ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
