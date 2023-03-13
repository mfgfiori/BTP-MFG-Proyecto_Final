CLASS zcl_insert_data_2114 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA gv_console TYPE REF TO if_oo_adt_classrun_out.

    TYPES items TYPE TABLE OF zso_items_2114 WITH KEY id.

    METHODS delete_entries.

    METHODS insert_entries.

    METHODS get_id RETURNING VALUE(result) TYPE sysuuid_c36.

    METHODS get_random_date
      IMPORTING
                num           TYPE i
      RETURNING VALUE(result) TYPE zde_createon_2114.

    METHODS get_random_country
      IMPORTING
                num           TYPE i
      RETURNING VALUE(result) TYPE zde_country_2114.

    METHODS get_random_status
      IMPORTING
                num           TYPE i
      RETURNING VALUE(result) TYPE zde_orderstatus_2114.

    METHODS randomize_header
      IMPORTING
                num           TYPE i
      RETURNING VALUE(result) TYPE zso_header_2114.

    METHODS randomize_items
      IMPORTING
        id_header TYPE zso_header_2114-id
        num       type i
      RETURNING
        VALUE(result) TYPE items.


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

    GV_console = out.

    delete_entries( ).

    insert_entries( ).

    out->write( 'Demo Data Inserted!' ).

  ENDMETHOD.

  METHOD get_random_date.

    GET TIME STAMP FIELD DATA(current_timestamp).
    DATA(tmp) = CONV string( current_timestamp ).
    DATA lv_datum TYPE d.
    lv_datum = tmp(8).

    result = lv_datum + num.
  ENDMETHOD.

  METHOD randomize_header.
    DATA: lv_firstname TYPE zso_header_2114-firstname,
          lv_lastname  TYPE zso_header_2114-lastname,
          lv_email     TYPE zso_header_2114-email,
          lv_IMAGEURL     TYPE zso_header_2114-imageurl.

    CLEAR: lv_firstname,
           lv_lastname,
           lv_email,
           lv_IMAGEURL.
    CASE num.
      WHEN 1.
*    *   Emily    Alexander   e.alexander@randatmail.com
        lv_firstname = 'Emily'.
        lv_lastname = 'Alexander'.
        lv_email = 'e.alexander@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/e/e3/Logo_Elektro.png'.
      WHEN 2.
*    *'Brad'    'Adams'   'b.adams@randatmail.com'
        lv_firstname = 'Brad'.
        lv_lastname = 'Adams'.
        lv_email = 'b.adams@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/5/56/Logo-Promorar.png'.
      WHEN 3.
*    *Naomi   Foster  n.foster@randatmail.com
        lv_firstname = 'Naomi'.
        lv_lastname = 'Foster'.
        lv_email = 'n.foster@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/7/76/Logo_qdqmedia.png'.
      WHEN 4.
*    *Ada Carroll a.carroll@randatmail.com
        lv_firstname = 'Ada'.
        lv_lastname = 'Carroll'.
        lv_email = 'a.carroll@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/0/05/Logo_EPM.png'.
      WHEN 5.
*    *Charlotte   Evans   c.evans@randatmail.com
        lv_firstname = 'Charlotte'.
        lv_lastname = 'Evans'.
        lv_email = 'c.evans@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/8/8e/Logo_Empresa_Nacional_de_Telecomunicaciones_-_TELECOM.png'.
      WHEN 6.
*    *Adam    Montgomery  a.montgomery@randatmail.com
        lv_firstname = 'Adam'.
        lv_lastname = 'Montgomery'.
        lv_email = 'a.montgomery@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/a/a4/Logo-de-la-empresa-EDESA.jpg'.
      WHEN 7.
*    *Justin  Stewart j.stewart@randatmail.com
        lv_firstname = 'Justin'.
        lv_lastname = 'Stewart'.
        lv_email = 'j.stewart@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/8/8d/Wipe_Out_Kids%27_Cancer_%28logo%29.jpg'.
      WHEN 8.
*    *Dale    Moore   d.moore@randatmail.com
        lv_firstname = 'Dale'.
        lv_lastname = 'Moore'.
        lv_email = 'd.moore@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/e/ed/LOGO_NOVA_PNG.png'.
      WHEN 9.
*    *Caroline    Phillips    c.phillips@randatmail.com
        lv_firstname = 'Caroline'.
        lv_lastname = 'Phillips'.
        lv_email = 'c.phillips@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/3/31/Logo_ULM.png'.
      WHEN 10.
*    *Paige   Ross    p.ross@randatmail.com
        lv_firstname = 'Paige'.
        lv_lastname = 'Ross'.
        lv_email = 'p.ross@randatmail.com'.
        lv_IMAGEURL = 'https://upload.wikimedia.org/wikipedia/commons/d/df/LOGO-SABA-BRAND.png'.
      WHEN OTHERS.
        DATA lv_char(2).
        lv_char = num.
        CONCATENATE 'DUMMY_NAME' lv_char INTO lv_firstname.
        CONCATENATE 'DUMMY_LASTNAME' lv_char INTO lv_LAstname.
        CONCATENATE lv_firstname(1) '.' lv_LAstname '@randatmail.com' INTO lv_EMAIL.
    ENDCASE.

*    clear lv_IMAGEURL.
*    lv_IMAGEURL = 'https://raw.githubusercontent.com/SAP-samples/fiori-elements-opensap/main/week1/images/airlines/Green-Albatross-logo.png'.

    result  = VALUE zso_header_2114( id = get_id( )
                                    email = lv_email
                                    firstname = lv_firstname
                                    lastname  = lv_lastname
                                     country   =  get_random_country( num )
                                     createon = get_random_date( num )
                                     deliverydate = get_random_date( num + 30 )
                                     orderstatus = get_random_status( num )
                                     imageurl = lv_IMAGEURL
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

    DELETE FROM zso_ITEMS_2114.
    IF sy-subrc = 0.
      gv_console->write( 'ZSO_ITEMS_2114 cleared.' ).
    ELSE.
      gv_console->write( 'ZSO_ITEMS_2114 not cleared.' ).
    ENDIF.
  ENDMETHOD.

  METHOD insert_entries.
    DATA ls_header TYPE zso_header_2114.
    DATA lt_items TYPE TABLE OF zso_items_2114.

    DO 10 TIMES.
      clear: ls_header,
             lt_items[].

      ls_header = randomize_header( sy-index ).

      lt_items = randomize_items( id_header = ls_header-id
                                  num = sy-index ).

      INSERT zso_header_2114 FROM @ls_header.
      IF sy-subrc = 0.
        gv_console->write( 'ZSO_HEADER_2114 insert ok.' ).
      ELSE.
        gv_console->write( 'ZSO_HEADER_2114 insert not ok.' ).
      ENDIF.

      INSERT zso_items_2114 FROM TABLE @lt_items.
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

  METHOD get_random_country.

    IF ( num MOD 2 ) = 0.
      result = 'Spain'.
    ELSE.
      result = 'United States'.
    ENDIF.

  ENDMETHOD.

  METHOD get_random_status.

    IF num <= 3.
      result = '001'.
    ELSEIF num <= 6.
      result = '002'.
    ELSEIF num <= 9.
      result = '003'.
    ELSEIF num >= 10.
      result = '004'.
    ENDIF.

  ENDMETHOD.

METHOD randomize_items.
    FIELD-SYMBOLS <item> TYPE zso_items_2114.

    DATA lv_idpos TYPE zso_items_2114-id_pos.
    data: lv_index(2).

    DATA(items_count) = get_random_number( min = 1
                                           max = 10 ).
    lv_idpos = '00000'.

    DO items_count TIMES.
      INSERT INITIAL LINE INTO result INDEX 1 ASSIGNING <item>.
      IF sy-subrc = 0.
        lv_index = sy-index.
        lv_idpos = lv_idpos + 10.
        <item>-id = id_header.
        <item>-id_pos =  lv_idpos.

        concatenate 'Product ' lv_index into <item>-name.
        concatenate 'Description Product ' lv_index into <item>-description.
        <item>-releasedate = get_random_date( sy-index ).
        <item>-discontinueddate  = get_random_date( 90 ).
        <item>-price = sy-index * 100.
        <item>-currencycode = 'USD'.
        <item>-height = 30 + 5 * sy-index.
        <item>-width = 20 + 5 * sy-index.
        <item>-depth = 10 + 5 * sy-index.
        <item>-quantity = sy-index * 10.
        <item>-unitofmesaure = 'CM'.
      ENDIF.
    ENDDO.
  ENDMETHOD.

ENDCLASS.
