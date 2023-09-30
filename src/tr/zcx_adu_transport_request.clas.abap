"! <p class="shorttext synchronized" lang="en">Check transport Exceptions</p>
CLASS zcx_adu_transport_request DEFINITION
  PUBLIC
  INHERITING FROM cx_static_check
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES if_t100_message.
    INTERFACES if_t100_dyn_msg.

    CONSTANTS:
      "! Transport request &amp;1 doesn't exist
      BEGIN OF not_exists,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '001' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF not_exists.

    CONSTANTS:
      "! Transport request &amp;1 isn't released.
      BEGIN OF not_released,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '002' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF not_released.

    CONSTANTS:
      "! Transport request &amp;1 has no target.
      BEGIN OF no_target,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '003' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF no_target.

    CONSTANTS:
      "! Not found cofile for transport request &amp;1.
      BEGIN OF not_found_cofile,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '004' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF not_found_cofile.

    CONSTANTS:
      "! Not found data for transport request &amp;1.
      BEGIN OF not_found_data,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '005' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF not_found_data.

    CONSTANTS:
      "! Filename &amp;1 not supported.
      BEGIN OF filename_not_supported,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '006' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF filename_not_supported.

    CONSTANTS:
      "! Transport request &amp;1 is incomplete.
      BEGIN OF incomplete,
        msgid TYPE symsgid VALUE 'ZADU_TRANSPORT_REQ' ##NO_TEXT,
        msgno TYPE symsgno VALUE '007' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF incomplete.

    CONSTANTS:
      "! Source client does not exist: &amp;
      BEGIN OF source_client_not_exists,
        msgid TYPE symsgid VALUE 'TA' ##NO_TEXT,
        msgno TYPE symsgno VALUE '008' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF source_client_not_exists.

    CONSTANTS:
      "! Source client &amp; is protected against data export by client copy
      BEGIN OF client_copy_protected,
        msgid TYPE symsgid VALUE 'TA' ##NO_TEXT,
        msgno TYPE symsgno VALUE '260' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF client_copy_protected.

    CONSTANTS:
      "! Client 000 is protected and may not be overwritten
      BEGIN OF client_000_protected,
        msgid TYPE symsgid VALUE 'TA' ##NO_TEXT,
        msgno TYPE symsgno VALUE '011' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF client_000_protected.

    CONSTANTS:
      "! Source client is same as logon client
      BEGIN OF source_client_same_logon,
        msgid TYPE symsgid VALUE 'TA' ##NO_TEXT,
        msgno TYPE symsgno VALUE '009' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF source_client_same_logon.

    CONSTANTS:
      "! Program ended with error or warning, return code: &amp;
      BEGIN OF program_ended_with_error,
        msgid TYPE symsgid VALUE 'TA' ##NO_TEXT,
        msgno TYPE symsgno VALUE '146' ##NO_TEXT,
        attr1 TYPE scx_attrname VALUE 'TEXT1' ##NO_TEXT,
        attr2 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr3 TYPE scx_attrname VALUE '' ##NO_TEXT,
        attr4 TYPE scx_attrname VALUE '' ##NO_TEXT,
      END OF program_ended_with_error.

    DATA:
      text1 TYPE string READ-ONLY,
      text2 TYPE string READ-ONLY,
      text3 TYPE string READ-ONLY,
      text4 TYPE string READ-ONLY.

    "! <p class="shorttext synchronized" lang="en">Raise exception with system attribute message</p>
    "!
    "! @raising zcx_adu_transport_request | <p class="shorttext synchronized" lang="en">Exception</p>
    CLASS-METHODS raise_system
      RAISING
        zcx_adu_transport_request.

    "! <p class="shorttext synchronized" lang="en">CONSTRUCTOR</p>
    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !text1    TYPE string OPTIONAL
        !text2    TYPE string OPTIONAL
        !text3    TYPE string OPTIONAL
        !text4    TYPE string OPTIONAL
        !previous LIKE previous OPTIONAL.

  PROTECTED SECTION.

  PRIVATE SECTION.

ENDCLASS.



CLASS zcx_adu_transport_request IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.

    me->text1 = text1.
    me->text2 = text2.
    me->text3 = text3.
    me->text4 = text4.

    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.


  METHOD raise_system.

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

  ENDMETHOD.


ENDCLASS.
