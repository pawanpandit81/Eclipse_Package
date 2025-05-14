CLASS lcl_sc_zpdb00_i_r_bupa DEFINITION
                          INHERITING FROM cl_abap_behavior_saver.

  PROTECTED SECTION.

*    METHODS adjust_numbers REDEFINITION.

ENDCLASS.

CLASS lcl_sc_zpdb00_i_r_bupa IMPLEMENTATION.

*  METHOD adjust_numbers.
*    SELECT FROM zpdb00_bupa
*        FIELDS MAX( partner )
*            INTO @DATA(lv_max_partner).
*
*    LOOP AT mapped-partner
*        ASSIGNING FIELD-SYMBOL(<ls_partner>).    "REFERENCE INTO DATA(lr_partner).
*      lv_max_partner += 1.
*      <ls_partner>-Partner = lv_max_partner.
*    ENDLOOP.
*  ENDMETHOD.

ENDCLASS.

CLASS lcl_hc_Partner DEFINITION
                  INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING
        keys   REQUEST requested_authorizations FOR Partner
      RESULT
        result.
    METHODS keyfilled FOR VALIDATE ON SAVE
      IMPORTING
        keys FOR partner~keyfilled.
    METHODS coredata FOR VALIDATE ON SAVE
      IMPORTING
        keys FOR partner~coredata.
    METHODS fillcurrency FOR DETERMINE ON MODIFY
      IMPORTING
        keys FOR partner~fillcurrency.
    METHODS clearallstreet FOR MODIFY
      IMPORTING
        keys FOR ACTION partner~clearallstreet.
    METHODS fillstreet FOR MODIFY
      IMPORTING
        keys   FOR ACTION partner~fillstreet
      RESULT
        result.
    METHODS copyline FOR MODIFY
      IMPORTING
        keys FOR ACTION partner~copyline.
    METHODS withpopup FOR MODIFY
      IMPORTING
        keys FOR ACTION partner~withpopup.
    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING
        keys   REQUEST requested_features FOR partner
      RESULT
        result.
    METHODS get_global_features FOR GLOBAL FEATURES
      IMPORTING
      REQUEST requested_features FOR partner
      RESULT
        result.
    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING
      REQUEST requested_authorizations FOR partner
      RESULT
        result.
    METHODS earlynumbering_create FOR NUMBERING
      IMPORTING
        entities FOR CREATE partner.

ENDCLASS.

CLASS lcl_hc_Partner IMPLEMENTATION.

  METHOD get_instance_authorizations.
* As import table contains only keys, we need to get complete bonus calculation data for bonus variant value
    READ ENTITIES OF zpdb00_i_r_bupa IN LOCAL MODE
        ENTITY Partner
            ALL FIELDS
                WITH CORRESPONDING #( keys )
                    RESULT DATA(lt_Partner).
* fill result list with authorizations per bonus calculation
    LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<fs_partner>).
* check update authorization for bonus calculation, incl. bonus variant dependency
      authority-check object 'ZPDB_REGN'
        id 'ACTVT' field '02'
        id 'ZBNS_VARNT' field <fs_partner>-City.
* set variable for update authorization
      DATA(lv_update_allowed) =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
* check calculate bonus authorization for bonus calculation, incl. bonus variant dependency
      authority-check object 'ZPDB_REGN'
        id 'ACTVT' field '93'
        id 'ZBNS_VARNT' field <fs_partner>-City.
* set variable for calculate bonus authorization
      DATA(lv_calculate_bonus_allowed) =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
* check delete authorization for bonus calculation, incl. bonus variant dependency
      authority-check object 'ZPDB_REGN'
        id 'ACTVT' field '06'
        id 'ZBNS_VARNT' field <fs_partner>-City.
* set variable for delete authorization
      DATA(lv_delete_allowed) =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
* fill result list
      APPEND VALUE #( partner = <fs_partner>-Partner
                      %update = lv_update_allowed
                      %delete = lv_delete_allowed ) TO result.
    ENDLOOP.
  ENDMETHOD.

  METHOD keyfilled.
    LOOP AT keys
     ASSIGNING FIELD-SYMBOL(<fs_key>)
      WHERE Partner IS INITIAL.
      INSERT
        VALUE #( Partner = <fs_key>-Partner )
            INTO TABLE failed-partner.

      INSERT
        VALUE #( Partner = <fs_key>-Partner
                 %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                               text = 'Partner is mandatory' ) )
                                               INTO TABLE reported-partner.
    ENDLOOP.
  ENDMETHOD.

  METHOD coredata.
    READ ENTITIES OF zpdb00_i_r_bupa
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
            VALUE #( Partner = <ls_partner>-Partner )
                INTO TABLE failed-partner.

        INSERT
            VALUE #( Partner = <ls_partner>-Partner
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
            VALUE #( Partner = <ls_partner>-Partner )
                INTO TABLE failed-partner.

        INSERT
            VALUE #( Partner = <ls_partner>-Partner
                     %msg = new_message_with_text( "severity = if_abap_behv_message=>severity-error
                                                   text = 'Currency not found in I_Currency' )
                     %element-currency = if_abap_behv=>mk-on )
                        INTO TABLE reported-partner.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD fillcurrency.
    READ ENTITIES OF zpdb00_i_r_bupa
      IN LOCAL MODE
          ENTITY Partner
              FIELDS ( Currency )
                  WITH CORRESPONDING #( keys )
                      RESULT DATA(lt_partner).

    LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<ls_partner>)
            WHERE Currency IS INITIAL.
      MODIFY ENTITIES OF zpdb00_i_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                UPDATE FIELDS ( Currency )
                    WITH VALUE #( ( %tky = <ls_partner>-%tky
                                    Currency = 'EUR'
                                    %control-currency = if_abap_behv=>mk-on ) ).
    ENDLOOP.
  ENDMETHOD.

  METHOD clearAllStreet.
    SELECT FROM zpdb00_bupa
        FIELDS partner, street
            WHERE street = 'EMPTY'
                INTO TABLE @DATA(lt_partner).

    LOOP AT lt_partner
      ASSIGNING FIELD-SYMBOL(<ls_partner>).
      MODIFY ENTITIES OF zpdb00_i_r_bupa
          IN LOCAL MODE
              ENTITY Partner
                  UPDATE FIELDS ( Street )
                      WITH VALUE #( ( Partner = <ls_partner>-partner
                                      Street = ''
                                      %control-Street = if_abap_behv=>mk-on ) ).
    ENDLOOP.

    INSERT VALUE #( %msg = new_message_with_text( text = |{ lines( lt_partner ) } records changed|
                    severity = if_abap_behv_message=>severity-success ) ) INTO TABLE reported-partner.
  ENDMETHOD.

  METHOD fillStreet.
    READ ENTITIES OF zpdb00_i_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                FIELDS ( Street )
                    WITH CORRESPONDING #( keys )
                        RESULT DATA(lt_partner).

    LOOP AT lt_partner
      ASSIGNING FIELD-SYMBOL(<ls_partner>)
          WHERE Street IS INITIAL.
      MODIFY ENTITIES OF zpdb00_i_r_bupa
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
      lt_create TYPE TABLE FOR CREATE zpdb00_i_r_bupa.

    READ ENTITIES OF zpdb00_i_r_bupa
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
      <ls_partner>-Partner = lv_number.
      <ls_partner>-Name &&= | copy|.

      INSERT
        VALUE #( %cid = keys[ sy-tabix ]-%cid )
            INTO TABLE lt_create
                REFERENCE INTO DATA(lr_create).

      lr_create->* = CORRESPONDING #( <ls_partner> ).
      lr_create->%control-Partner = if_abap_behv=>mk-on.
      lr_create->%control-Name = if_abap_behv=>mk-on.
      lr_create->%control-Street = if_abap_behv=>mk-on.
      lr_create->%control-City = if_abap_behv=>mk-on.
      lr_create->%control-Country = if_abap_behv=>mk-on.
      lr_create->%control-Currency = if_abap_behv=>mk-on.
    ENDLOOP.

    MODIFY ENTITIES OF zpdb00_i_r_bupa
        IN LOCAL MODE
            ENTITY Partner
                CREATE FROM lt_create
                    FAILED DATA(ls_fail)
                        MAPPED DATA(ls_map)
                            REPORTED DATA(ls_report).

    mapped-partner = ls_map-partner.
  ENDMETHOD.

  METHOD withPopup.
    DATA(ls_key) =
        VALUE #( keys[ 1 ] OPTIONAL ).

    IF ls_key IS INITIAL.
      RETURN.
    ENDIF.

    CASE ls_key-%param-MessageType.
      WHEN 1.
        INSERT
            VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                   text = 'Dummy Message' ) ) INTO TABLE reported-partner.
      WHEN 2.
        INSERT
            VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information
                                                   text = 'Dummy Message' ) ) INTO TABLE reported-partner.
      WHEN 3.
        INSERT
            VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-warning
                                                   text = 'Dummy Message' ) ) INTO TABLE reported-partner.
      WHEN 4.
        INSERT
            VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                   text = 'Dummy Message' ) ) INTO TABLE reported-partner.
      WHEN 5.
        INSERT
            VALUE #( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-none
                                                   text = 'Dummy Message' ) ) INTO TABLE reported-partner.
      WHEN 6.
        reported-partner =
            VALUE #( ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                     text = 'Dummy Message' ) )
                     ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information
                                                     text = 'Dummy Message' ) ) ).
      WHEN 7.
        reported-partner =
            VALUE #( ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-success
                                                     text = 'Dummy Message' ) )
                     ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-error
                                                     text = 'Dummy Message' ) )
                     ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-warning
                                                     text = 'Dummy Message' ) )
                     ( %msg = new_message_with_text( severity = if_abap_behv_message=>severity-information
                                                     text = 'Dummy Message' ) ) ).
    ENDCASE.
  ENDMETHOD.

  METHOD get_instance_features.
    IF requested_features-%action-fillStreet = if_abap_behv=>mk-on.
      READ ENTITIES OF zpdb00_i_r_bupa
          IN LOCAL MODE
              ENTITY Partner
                  FIELDS ( Street )
                      WITH CORRESPONDING #( keys )
                          RESULT DATA(lt_partner).

      LOOP AT lt_partner
        ASSIGNING FIELD-SYMBOL(<ls_partner>)
             WHERE Street IS NOT INITIAL.
*        DATA(lv_deactivate) =
*            COND #( WHEN <ls_partner>-Street IS INITIAL
*                      THEN if_abap_behv=>mk-off
*                    ELSE if_abap_behv=>mk-on ).

        INSERT
            VALUE #( partner = <ls_partner>-Partner
                     %action-fillStreet = if_abap_behv=>mk-on ) "lv_deactivate
                     INTO TABLE result.
      ENDLOOP.
    ENDIF.
  ENDMETHOD.

  METHOD get_global_features.
    IF requested_features-%delete = if_abap_behv=>mk-on.
      DATA(lv_deactivate) =
        COND #(
          WHEN cl_abap_context_info=>get_user_alias( ) = ' ' "'pawan.pandit@nttdata.com'
            THEN if_abap_behv=>mk-off
          ELSE if_abap_behv=>mk-on ).
      result-%delete = lv_deactivate.
    ENDIF.
  ENDMETHOD.

  METHOD earlynumbering_create.
    SELECT FROM zpdb00_bupa
       FIELDS MAX( partner )
         INTO @DATA(lv_number).
  ENDMETHOD.

  METHOD get_global_authorizations.
    IF requested_authorizations-%create EQ if_abap_behv=>mk-on.
* check create authorization
      AUTHORITY-CHECK OBJECT 'ZPDB_REGN'
        ID 'ACTVT' FIELD '01'.
      result-%create =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
    ENDIF.

    IF requested_authorizations-%update EQ if_abap_behv=>mk-on.
* check update authorization
      AUTHORITY-CHECK OBJECT 'ZPDB_REGN'
        ID 'ACTVT' FIELD '02'.
      result-%update =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
    ENDIF.

    IF requested_authorizations-%delete EQ if_abap_behv=>mk-on.
* check delete authorization
      AUTHORITY-CHECK OBJECT 'ZPDB_REGN'
        ID 'ACTVT' FIELD '06'.
      result-%delete =
        COND #( WHEN sy-subrc = 0 THEN if_abap_behv=>auth-allowed
                ELSE if_abap_behv=>auth-unauthorized ).
    ENDIF.
  ENDMETHOD.

ENDCLASS.
