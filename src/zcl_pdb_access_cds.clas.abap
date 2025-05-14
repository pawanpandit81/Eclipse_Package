CLASS zcl_pdb_access_cds DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.

CLASS zcl_pdb_access_cds IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    out->write( cl_abap_context_info=>get_user_alias( ) ).
*    " Normal Standard
*    SELECT *
*      FROM I_Language
*      INTO TABLE @DATA(Languages).
*      out->write( Languages ).

*    SELECT Language, LanguageISOCode
*      FROM I_Language
*      INTO TABLE @DATA(Language_ISOCodes).
*    out->write( Language_ISOCodes ).

    " Join CDS
*    SELECT FROM zpdb00_i_invi_join
*      FIELDS documentno, partnername, country, price, currency
*      WHERE itemno = 1
*      ORDER BY documentno
*      INTO TABLE @DATA(InvoiceItemJoin)
*      UP TO 20 ROWS.
*    out->write( InvoiceItemJoin ).

    " Union Select
*    SELECT FROM zpdb00_i_invi_union
*      FIELDS *
*      WHERE documentno BETWEEN '30000010' AND '30000020'
*      ORDER BY documentno, itemno
*      INTO TABLE @DATA(InvoiceItemUnion).
*    out->write( InvoiceItemUnion ).

    " Association Select
*    SELECT FROM zpdb00_i_invh
*      FIELDS DocumentNo, PartnerNo, \_Partner-PartnerName, \_Partner-City
*      INTO TABLE @DATA(InvoiceHeadAssoc)
*      UP TO 10 ROWS.
*    out->write( InvoiceHeadAssoc ).

    " Association Select
*SELECT FROM zpdb00_i_invi
*  FIELDS  DocumentNo,
*          ItemNo,
*          \_Invoice-PartnerNo,
*          \_Invoice\_Partner-PartnerName,
*          \_Invoice\_Partner-City,
*          \_Invoice\_Partner-Country,
*          MaterialNo,
*          Quantity,
*          Price,
*          Currency,
*          \_Invoice-DocDate
*  INTO TABLE @DATA(InvoiceItemAssoc)
*  UP TO 20 ROWS.
*    out->write( InvoiceItemAssoc ).
*
*    " Input Parameter
*    SELECT FROM zpdb00_c_invh_param( p_date = '20240820',
*                                     p_type = 'C',
*                                     p_field = 'Program' )
*      FIELDS *
*      INTO TABLE @DATA(Parameters).
*    out->write( Parameters ).
  ENDMETHOD.
ENDCLASS.
