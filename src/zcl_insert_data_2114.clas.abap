CLASS zcl_insert_data_2114 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gv_console TYPE REF TO if_oo_adt_classrun_out.

    METHODS delete_entries.

    METHODS insert_entries.

    METHODS get_id RETURNING VALUE(result) TYPE sysuuid_c36.

    METHODS get_random_date
      IMPORTING
                num           TYPE i
      RETURNING VALUE(result) TYPE zde_createon_2114.

    METHODS randomize_header
        importing
            num type i
        RETURNING VALUE(result) TYPE zso_header_2114.

    METHODS get_random_number
      IMPORTING
        min           TYPE i
        max           TYPE i
      RETURNING
        VALUE(result) TYPE i.

ENDCLASS.



CLASS zcl_insert_data_2114 IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    DATA: lt_so_header TYPE TABLE OF zso_header_2114.

    delete_entries( ).

    insert_entries( ).




    out->write( 'Demo Data Inserted!' ).

  ENDMETHOD.
    METHOD get_random_date.
*    GET TIME STAMP FIELD result.
    result = sy-datum.
  ENDMETHOD.
  METHOD randomize_header.


    result  = VALUE zso_header_2114( id = get_id( )
*                                    email = get_email(lv_firstname,lv_lastname)
*                                    firstname = get_firstname()
*                                    lastname  = get_lastname()
*                                    country   =
                                     createon = get_random_date( num )
                                     deliverydate = get_random_date( num )
*                                    orderstatus  : zde_orderstatus_2114;
*                                    imageurl     : zde_imageurl_2114;
                                     ).
  ENDMETHOD.


  METHOD get_id.
    TRY.
        result = cl_system_uuid=>create_uuid_c36_static( ).
      CATCH cx_uuid_error.
        "handle exception
    ENDTRY.
  ENDMETHOD.



  METHOD delete_entries.

    DELETE FROM zso_header_2114.
    IF sy-subrc = 0.
      gv_console->write( 'ZSO_HEADER_2114 cleared.' ).
    ELSE.
      gv_console->write( 'ZSO_HEADER_2114 not cleared.' ).
    ENDIF.

*    DELETE FROM zso_ITEMS_2114.
    IF sy-subrc = 0.
      gv_console->write( 'ZSO_ITEMS_2114 cleared.' ).
    ELSE.
      gv_console->write( 'ZSO_ITEMS_2114 not cleared.' ).
    ENDIF.
  ENDMETHOD.

  METHOD insert_entries.
    DATA ls_header TYPE zso_header_2114.
*    DATA lt_items TYPE TABLE OF zso_items_2114.

    DO 20 TIMES.

       ls_header = randomize_header( sy-index ).

*       lt_items = randomize_items( ls_header-id, sy-index ).

      INSERT zso_header_2114 FROM @ls_header.
      IF sy-subrc = 0.
        gv_console->write( 'ZSO_HEADER_2114 insert ok.' ).
      ELSE.
        gv_console->write( 'ZSO_HEADER_2114 insert not ok.' ).
      ENDIF.

*      INSERT zso_items_2114 FROM TABLE @lt_items.
      IF sy-subrc = 0.
        gv_console->write( 'ZSO_ITEMS_2114 insert ok.' ).
      ELSE.
        gv_console->write( 'ZSO_ITEMS_2114 insert not ok.' ).
      ENDIF.

    ENDDO.
  ENDMETHOD.

  METHOD get_random_number.
    TRY.
        DATA(random_numbers) = cl_abap_random_int=>create( seed = cl_abap_random=>seed( )
                                                           min  = min
                                                           max  = max ).

        result = random_numbers->get_next( ).
      CATCH cx_abap_random.
        "handle exception
    ENDTRY.
  ENDMETHOD.

ENDCLASS.
