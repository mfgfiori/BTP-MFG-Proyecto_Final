CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesOrder RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

    METHODS cancelOrder FOR MODIFY
      IMPORTING keys FOR ACTION SalesOrder~cancelOrder RESULT result.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF z_i_soheader_2114
    ENTITY  SalesOrder
    FIELDS ( id orderstatus )
    WITH VALUE #( FOR key_row IN keys ( %key  = key_row-%key ) )
    RESULT DATA(lt_so_result).


  result = VALUE #( FOR salesorder_row IN lt_so_result (
                          %key = salesorder_row-%key
                          %field-id = if_abap_behv=>fc-f-read_only
                          %action-cancelOrder = COND #( WHEN salesorder_row-orderstatus = 0
                                                        THEN if_abap_behv=>fc-o-enabled
                                                        ELSE if_abap_behv=>fc-o-disabled )
                          %assoc-_SalesOrderItems = if_abap_behv=>fc-o-enabled ) ).

  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

   METHOD cancelOrder.

        MODIFY ENTITIES OF z_i_soheader_2114 IN LOCAL MODE
          ENTITY SalesOrder
          UPDATE FIELDS ( orderstatus )
          WITH VALUE #( FOR key_row IN keys ( id = key_row-id
                                              orderstatus = 1 ) ) "Canceled
          FAILED failed
          REPORTED reported.

          READ ENTITIES OF z_i_soheader_2114 IN LOCAL MODE
          ENTITY SalesOrder
          fields ( email
                      firstname
                      lastname
                      country
                      createon
                      deliverydate
                      orderstatus
                      imageurl
                    )
           WITH VALUE #( FOR key_row1 IN keys ( id = key_row1-id ) )
                 RESULT DATA(lt_order).

     result = VALUE #( FOR order_row IN lt_order ( id = order_row-id
                                                   %param =  order_row ) ).

*  Informando REPORTED es la forma de hacerle llegar al usuario el error que se ha producido
    LOOP AT lt_order ASSIGNING FIELD-SYMBOL(<fs_order>).
      APPEND VALUE #( %key      = <fs_order>-%key
                      id        = <fs_order>-id
                      %msg      = new_message( id = 'Z_MCL_SALEORDER_2114'
                                                number = '001'
                                                v1 =  <fs_order>-id
                                                severity = if_abap_behv_message=>severity-success )
                      %element-orderstatus = if_abap_behv=>mk-on ) TO reported-salesorder.
    ENDLOOP.

  ENDMETHOD.

ENDCLASS.
