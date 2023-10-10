CLASS zcl_adu_utl_transport_request DEFINITION
  PUBLIC
  FINAL
  CREATE PRIVATE.

  PUBLIC SECTION.
    INTERFACES zif_adu_utl_transport_request.

    CLASS-METHODS get
      RETURNING
        VALUE(result) TYPE REF TO zif_adu_utl_transport_request.

  PROTECTED SECTION.

  PRIVATE SECTION.
    CLASS-DATA gi_standalone TYPE REF TO zif_adu_utl_transport_request.

    METHODS is_filename_valid
      IMPORTING
        iv_filename      TYPE string
      RETURNING
        VALUE(rv_result) TYPE abap_bool.

    METHODS convert_filename_to_tr
      IMPORTING
        iv_filename      TYPE string
      RETURNING
        VALUE(rv_result) TYPE trkorr
      RAISING
        zcx_adu_transport_request.

ENDCLASS.



CLASS zcl_adu_utl_transport_request IMPLEMENTATION.


  METHOD get.

    IF gi_standalone IS NOT BOUND.
      gi_standalone = NEW zcl_adu_utl_transport_request( ).
    ENDIF.

    result = gi_standalone.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~get_path_cofiles.

    rv_result = |{ zif_adu_utl_transport_request~get_path_trans( ) }/{ zif_adu_tr_constants=>gc_path-cofiles }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~get_path_data.

    rv_result = |{ zif_adu_utl_transport_request~get_path_trans( ) }/{ zif_adu_tr_constants=>gc_path-data }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~get_path_trans.

    rv_result = zif_adu_tr_constants=>gc_path-trans.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~build_filename_cofiles.

    rv_result = |K{ iv_transport_request+4 }.{ iv_transport_request(3) }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~build_filename_data.

    rv_result = |R{ iv_transport_request+4 }.{ iv_transport_request(3) }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~build_path_cofiles.

    rv_result =
        |{ zif_adu_utl_transport_request~get_path_cofiles( ) }/| &
        |{ zif_adu_utl_transport_request~build_filename_cofiles( iv_transport_request ) }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~build_path_data.

    rv_result =
        |{ zif_adu_utl_transport_request~get_path_data( ) }/| &
        |{ zif_adu_utl_transport_request~build_filename_data( iv_transport_request ) }|.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~read_header.

    rs_result = VALUE #( trkorr = iv_transport_request ).

    CALL FUNCTION 'TRINT_READ_REQUEST_HEADER'
      EXPORTING
        iv_read_e070   = abap_true
        iv_read_e07t   = abap_true
        iv_read_e070c  = abap_true
        iv_read_e070m  = abap_true
      CHANGING
        cs_request     = rs_result
      EXCEPTIONS
        empty_trkorr   = 1
        not_exist_e070 = 2
        OTHERS         = 99.
    IF sy-subrc <> 0.
      zcx_adu_transport_request=>raise_system( ).
    ENDIF.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~add_to_queue.

    DATA:
      ls_system    TYPE tmscsys,
      lv_ctc_value TYPE trtppvalue.

    CALL FUNCTION 'TMS_UIQ_IQD_READ_QUEUE'
      EXPORTING
        iv_system         = CONV tmssysnam( sy-sysid )
      IMPORTING
        es_system         = ls_system
      EXCEPTIONS
        read_queue_failed = 1
        OTHERS            = 99.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_adu_transport_request
        EXPORTING
          textid = VALUE scx_t100key( msgid = sy-msgid
                                      msgno = sy-msgno
                                      attr1 = 'TEXT1'
                                      attr2 = 'TEXT2'
                                      attr3 = 'TEXT3'
                                      attr4 = 'TEXT4' )
          text1  = CONV #( sy-msgv1 )
          text2  = CONV #( sy-msgv2 )
          text3  = CONV #( sy-msgv3 )
          text4  = CONV #( sy-msgv4 ).
    ENDIF.

    CALL FUNCTION 'TMS_PM_READ_TP_PARAMETER'
      EXPORTING
        iv_parameter             = 'CTC'
        iv_system                = ls_system-sysnam
      IMPORTING
        ev_value                 = lv_ctc_value
      EXCEPTIONS
        read_tp_parameter_failed = 1
        parameter_not_found      = 2
        OTHERS                   = 99.
    IF sy-subrc <> 0 OR lv_ctc_value <> 1.
      lv_ctc_value = abap_false.
    ELSE.
      lv_ctc_value = abap_true.
    ENDIF.

    CALL FUNCTION 'TMS_MGR_FORWARD_TR_REQUEST'
      EXPORTING
        iv_request                 = iv_transport_request
        iv_target                  = ls_system-sysnam
        iv_tardom                  = ls_system-domnam
        iv_tarcli                  = COND trtarcli( WHEN lv_ctc_value = abap_true THEN sy-mandt )
        iv_source                  = ls_system-sysnam
        iv_srcdom                  = ls_system-domnam
        iv_import_again            = abap_true
        iv_monitor                 = abap_true
        iv_verbose                 = abap_false
      IMPORTING
        es_exception               = rs_result
      EXCEPTIONS
        read_config_failed         = 1
        table_of_requests_is_empty = 2
        OTHERS                     = 99.
    IF sy-subrc <> 0.
      RAISE EXCEPTION TYPE zcx_adu_transport_request
        EXPORTING
          textid = VALUE scx_t100key( msgid = sy-msgid
                                      msgno = sy-msgno
                                      attr1 = 'TEXT1'
                                      attr2 = 'TEXT2'
                                      attr3 = 'TEXT3'
                                      attr4 = 'TEXT4' )
          text1  = CONV #( sy-msgv1 )
          text2  = CONV #( sy-msgv2 )
          text3  = CONV #( sy-msgv3 )
          text4  = CONV #( sy-msgv4 ).
    ENDIF.

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~zip_import.

    DATA(lt_content) = zif_adu_utl_transport_request~zip_to_content( iv_zip ).

    LOOP AT lt_content ASSIGNING FIELD-SYMBOL(<ls_content>).

      DATA(lv_path_cofiles) = zif_adu_utl_transport_request~build_path_cofiles( <ls_content>-transport_request ).

      OPEN DATASET lv_path_cofiles FOR OUTPUT IN BINARY MODE.

      TRANSFER <ls_content>-cofile TO lv_path_cofiles.

      CLOSE DATASET lv_path_cofiles.

      DATA(lv_path_data) = zif_adu_utl_transport_request~build_path_data( <ls_content>-transport_request ).

      OPEN DATASET lv_path_data FOR OUTPUT IN BINARY MODE.

      TRANSFER <ls_content>-data TO lv_path_data.

      CLOSE DATASET lv_path_data.

    ENDLOOP.

    IF iv_add_queue <> abap_true.
      RETURN.
    ENDIF.

    rt_result =
        VALUE #(
            FOR <content> IN lt_content
            ( transport_request = <content>-transport_request
              tms_alert         = zif_adu_utl_transport_request~add_to_queue( <content>-transport_request ) ) ).

  ENDMETHOD.


  METHOD zif_adu_utl_transport_request~zip_to_content.

    DATA:
      lt_content LIKE rt_result.

    DATA(lo_zip) = NEW cl_abap_zip( ).

    lo_zip->load( iv_zip ).

    LOOP AT lo_zip->files ASSIGNING FIELD-SYMBOL(<ls_file>).

      IF is_filename_valid( <ls_file>-name ) = abap_false.
        CONTINUE.
      ENDIF.

      DATA(lv_transport_request) = convert_filename_to_tr( <ls_file>-name ).

      ASSIGN lt_content[ transport_request = lv_transport_request ] TO FIELD-SYMBOL(<ls_content>).
      IF sy-subrc <> 0 OR <ls_content> IS NOT ASSIGNED.
        INSERT VALUE #( transport_request = lv_transport_request )
            INTO TABLE lt_content ASSIGNING <ls_content>.
      ENDIF.

      lo_zip->get(
        EXPORTING
          name                    = <ls_file>-name
        IMPORTING
          content                 = DATA(lv_content)
        EXCEPTIONS
          zip_index_error         = 1
          zip_decompression_error = 2
          OTHERS                  = 99 ).
      IF sy-subrc <> 0.
        RAISE EXCEPTION TYPE zcx_adu_transport_request
          EXPORTING
            textid = VALUE scx_t100key( msgid = sy-msgid
                                        msgno = sy-msgno
                                        attr1 = 'TEXT1'
                                        attr2 = 'TEXT2'
                                        attr3 = 'TEXT3'
                                        attr4 = 'TEXT4' )
            text1  = CONV #( sy-msgv1 )
            text2  = CONV #( sy-msgv2 )
            text3  = CONV #( sy-msgv3 )
            text4  = CONV #( sy-msgv4 ).
      ENDIF.

      CASE <ls_file>-name(1).
        WHEN 'K'.
          <ls_content>-cofile = lv_content.

        WHEN 'R'.
          <ls_content>-data = lv_content.

        WHEN OTHERS.
          RAISE EXCEPTION TYPE zcx_adu_transport_request
            EXPORTING
              textid = zcx_adu_transport_request=>filename_not_supported
              text1  = <ls_file>-name.

      ENDCASE.

      UNASSIGN <ls_content>.

    ENDLOOP.

    LOOP AT lt_content ASSIGNING <ls_content> WHERE cofile IS INITIAL OR data IS INITIAL.
      RAISE EXCEPTION TYPE zcx_adu_transport_request
        EXPORTING
          textid = zcx_adu_transport_request=>incomplete
          text1  = |{ <ls_content>-transport_request }|.
    ENDLOOP.

    rt_result = lt_content.

  ENDMETHOD.


  METHOD convert_filename_to_tr.

    IF iv_filename IS INITIAL.
      RETURN.
    ELSEIF is_filename_valid( iv_filename ) = abap_false.
      RAISE EXCEPTION TYPE zcx_adu_transport_request
        EXPORTING
          textid = zcx_adu_transport_request=>filename_not_supported
          text1  = iv_filename.
    ENDIF.

    DATA(lv_lenght) = strlen( iv_filename ).
    DATA(lv_length2ext) = lv_lenght - 3.
    DATA(lv_length2tr)  = lv_lenght - 5.

    rv_result = |{ iv_filename+lv_length2ext }K{ iv_filename+1(lv_length2tr) }|.

  ENDMETHOD.


  METHOD is_filename_valid.

    DATA:
      lc_regex TYPE string VALUE `^(K|R)\d{7}(.)(.{3})$`.

    rv_result = xsdbool( contains( val = iv_filename regex = lc_regex ) ).

  ENDMETHOD.


ENDCLASS.
