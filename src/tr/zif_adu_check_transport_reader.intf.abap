"! <p class="shorttext synchronized" lang="en">Check transport reader</p>
INTERFACE zif_adu_check_transport_reader
  PUBLIC.

  TYPES:
    ty_severity TYPE c LENGTH 1.

  TYPES:
    BEGIN OF ts_cross_reference.
      INCLUDE TYPE zadu_chktr_crref.
  TYPES:
      status_description TYPE string,
      exception          TYPE c LENGTH 1,
      color              TYPE lvc_t_scol,
    END OF ts_cross_reference,
    tt_cross_reference TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_cross_reference
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_sequence.
      INCLUDE TYPE zadu_chktr_seq.
  TYPES:
      exception TYPE c LENGTH 1,
      color     TYPE lvc_t_scol,
    END OF ts_sequence,
    tt_sequence TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_sequence
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_cross_release.
      INCLUDE TYPE zadu_chktr_crrel.
  TYPES:
      exception TYPE c LENGTH 1,
      color     TYPE lvc_t_scol,
    END OF ts_cross_release,
    tt_cross_release TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_cross_release
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_import_time.
      INCLUDE TYPE zadu_chktr_imtim.
  TYPES:
      exception TYPE c LENGTH 1,
      color     TYPE lvc_t_scol,
    END OF ts_import_time,
    tt_import_time TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_import_time
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_online_import_summary.
      INCLUDE TYPE zadu_chktr_oisum.
  TYPES:
      details_icon TYPE c LENGTH 50,
      exception    TYPE c LENGTH 1,
      color        TYPE lvc_t_scol,
    END OF ts_online_import_summary,
    tt_online_import_summary TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_online_import_summary
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_online_import.
      INCLUDE TYPE zadu_chktr_onlim.
  TYPES:
      exception TYPE c LENGTH 1,
      color     TYPE lvc_t_scol,
    END OF ts_online_import,
    tt_online_import TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_online_import
        WITH UNIQUE KEY run_code sequence.

  TYPES:
    BEGIN OF ts_header.
      INCLUDE TYPE zadu_chktr_head.
  TYPES:
      date                     TYPE d,
      time                     TYPE t,
      cross_reference_messages TYPE i,
      sequence_messages        TYPE i,
      cross_release_messages   TYPE i,
      import_time_messages     TYPE i,
      online_import_messages   TYPE i,
      exception                TYPE c LENGTH 1,
      color                    TYPE lvc_t_scol,
    END OF ts_header,
    tt_header TYPE SORTED TABLE OF zif_adu_check_transport_reader=>ts_header
        WITH UNIQUE KEY run_code transport_request
        WITH NON-UNIQUE SORTED KEY req COMPONENTS transport_request.

  METHODS display
    IMPORTING
      run_code          TYPE zadu_run_code OPTIONAL
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_cross_reference
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_sequence
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_cross_release
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_import_time
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_online_import_summary
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS display_online_import
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
      as_popup          TYPE abap_bool DEFAULT abap_false
    RAISING
      zcx_adu_check_transport.

  METHODS get_header
    IMPORTING
      run_code          TYPE zadu_run_code OPTIONAL
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_header
    RAISING
      zcx_adu_check_transport.

  METHODS get_cross_reference
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_cross_reference
    RAISING
      zcx_adu_check_transport.

  METHODS get_sequence
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_sequence
    RAISING
      zcx_adu_check_transport.

  METHODS get_cross_release
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_cross_release
    RAISING
      zcx_adu_check_transport.

  METHODS get_import_time
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_import_time
    RAISING
      zcx_adu_check_transport.

  METHODS get_online_import_summary
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_online_import_summary
    RAISING
      zcx_adu_check_transport.

  METHODS get_online_import
    IMPORTING
      run_code          TYPE zadu_run_code
      transport_request TYPE trkorr OPTIONAL
    RETURNING
      VALUE(result)     TYPE zif_adu_check_transport_reader=>tt_online_import
    RAISING
      zcx_adu_check_transport.

ENDINTERFACE.
