CLASS lcl_hc_Partner DEFINITION
                     INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys   REQUEST requested_authorizations FOR Partner
      RESULT
        result.
    METHODS coredata FOR VALIDATE ON SAVE
      IMPORTING keys FOR partner~coredata.

    METHODS keyfilled FOR VALIDATE ON SAVE
      IMPORTING keys FOR partner~keyfilled.
    METHODS fillcurrency FOR DETERMINE ON MODIFY
      IMPORTING keys FOR partner~fillcurrency.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR partner RESULT result.

    METHODS clearallstreet FOR MODIFY
      IMPORTING keys FOR ACTION partner~clearallstreet.

    METHODS fillstreet FOR MODIFY
      IMPORTING keys FOR ACTION partner~fillstreet RESULT result.
    METHODS copyline FOR MODIFY
      IMPORTING keys FOR ACTION partner~copyline.
*    METHODS earlynumbering_create FOR NUMBERING
*      IMPORTING entities FOR CREATE partner.

ENDCLASS.

CLASS lcl_hc_Partner IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD coredata.
    READ ENTITIES OF zpdb00_r_bupa
      IN LOCAL MODE ENTITY Partner
          FIELDS ( Country Currency )
              WITH CORRESPONDING #( keys )
                  RESULT DATA(lt_partner)
                      FAILED DATA(ls_fail)
                          REPORTED DATA(ls_report).

    LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<ls_partner>).
      SELECT SINGLE
        FROM I_Country
            FIELDS Country
                WHERE Country = @<ls_partner>-Country
                    INTO @DATA(lv_country).
      IF sy-subrc <> 0.
        INSERT
            VALUE #( PartnerNo = <ls_partner>-PartnerNo )
                INTO TABLE failed-partner.

        INSERT
            VALUE #( PartnerNo = <ls_partner>-PartnerNo
                     %msg = new_message_with_text( "severity = if_abap_behv_message=>severity-error
                                                   text = 'Country not found in I_Country' )
                     %element-country = if_abap_behv=>mk-on )
                     INTO TABLE reported-partner.
      ENDIF.

      SELECT SINGLE
        FROM I_Currency
            FIELDS Currency
                WHERE Currency = @<ls_partner>-Currency
                    INTO @DATA(lv_currency).
      IF sy-subrc <> 0.
        INSERT
            VALUE #( PartnerNo = <ls_partner>-PartnerNo )
                INTO TABLE failed-partner.

        INSERT
            VALUE #( PartnerNo = <ls_partner>-PartnerNo
                     %msg = new_message_with_text( "severity = if_abap_behv_message=>severity-error
                                                   text = 'Currency not found in I_Currency' )
                     %element-currency = if_abap_behv=>mk-on )
                        INTO TABLE reported-partner.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD keyfilled.
    LOOP AT keys
     ASSIGNING FIELD-SYMBOL(<fs_key>)
      WHERE PartnerNo IS INITIAL.
*      INSERT
*        VALUE #( PartnerNo = <fs_key>-PartnerNo )
*            INTO TABLE failed-partner.

      INSERT
        VALUE #( PartnerNo = <fs_key>-PartnerNo
                 %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                               text = 'Partner is mandatory' ) )
                                               INTO TABLE reported-partner.
    ENDLOOP.
  ENDMETHOD.

*  METHOD earlynumbering_create.
*  ENDMETHOD.

  METHOD fillcurrency.
    READ ENTITIES OF zpdb00_r_bupa
    IN LOCAL MODE
        ENTITY Partner
            FIELDS ( Currency )
                WITH CORRESPONDING #( keys )
                    RESULT DATA(lt_partner).

    LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<ls_partner>)
            WHERE Currency IS INITIAL.
      MODIFY ENTITIES OF zpdb00_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                UPDATE FIELDS ( Currency )
                    WITH VALUE #( ( %tky = <ls_partner>-%tky
                                    Currency = 'EUR'
                                    %control-currency = if_abap_behv=>mk-on ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD get_instance_features.
  ENDMETHOD.

  METHOD ClearAllStreet.
    SELECT FROM zpdb00_bupa
        FIELDS partner, street
            WHERE street = 'EMPTY'
                INTO TABLE @DATA(lt_partner).

    LOOP AT lt_partner
      ASSIGNING FIELD-SYMBOL(<ls_partner>).
      MODIFY ENTITIES OF zpdb00_r_bupa
          IN LOCAL MODE
              ENTITY Partner
                  UPDATE FIELDS ( Street )
                      WITH VALUE #( ( PartnerNo = <ls_partner>-partner
                                      Street = ''
                                      %control-Street = if_abap_behv=>mk-on ) ).
    ENDLOOP.

    INSERT VALUE #( %msg = new_message_with_text( text = |{ lines( lt_partner ) } records changed|
                    severity = if_abap_behv_message=>severity-success ) ) INTO TABLE reported-partner.
  ENDMETHOD.

  METHOD fillStreet.
    READ ENTITIES OF zpdb00_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                FIELDS ( Street )
                    WITH CORRESPONDING #( keys )
                        RESULT DATA(lt_partner).

    LOOP AT lt_partner
      ASSIGNING FIELD-SYMBOL(<ls_partner>)
          WHERE Street = ''.   "IS INITIAL.
      MODIFY ENTITIES OF zpdb00_r_bupa
          IN LOCAL MODE
              ENTITY Partner
                  UPDATE FIELDS ( Street )
                      WITH VALUE #( ( %tky = <ls_partner>-%tky
                                      Street = 'EMPTY'
                                      %control-Street = if_abap_behv=>mk-on ) ).

      INSERT VALUE #( %tky = <ls_partner>-%tky
                      %param = <ls_partner> ) INTO TABLE result.
    ENDLOOP.
  ENDMETHOD.

  METHOD copyLine.
    DATA:
      lt_create TYPE TABLE FOR CREATE zpdb00_r_bupa.

    READ ENTITIES OF zpdb00_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                ALL FIELDS WITH CORRESPONDING #( keys )
                    RESULT DATA(lt_partner).

    SELECT FROM zpdb00_bupa
      FIELDS MAX( partner )
        INTO @DATA(lv_number).

    LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<ls_partner>).
      lv_number += 1.
      <ls_partner>-PartnerNo = lv_number.
      <ls_partner>-Name &&= |copy|.

      INSERT
        VALUE #( %cid = keys[ sy-tabix ]-%cid )
            INTO TABLE lt_create
                REFERENCE INTO DATA(lr_create).

      lr_create->* = CORRESPONDING #( <ls_partner> ).
      lr_create->%control-PartnerNo = if_abap_behv=>mk-on.
      lr_create->%control-Name = if_abap_behv=>mk-on.
      lr_create->%control-Street = if_abap_behv=>mk-on.
      lr_create->%control-City = if_abap_behv=>mk-on.
      lr_create->%control-Country = if_abap_behv=>mk-on.
      lr_create->%control-Currency = if_abap_behv=>mk-on.
    ENDLOOP.

    MODIFY ENTITIES OF zpdb00_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                CREATE FROM lt_create
                    FAILED DATA(ls_fail)
                        MAPPED DATA(ls_map)
                            REPORTED DATA(ls_report).

    mapped-partner = ls_map-partner.
  ENDMETHOD.

ENDCLASS.
