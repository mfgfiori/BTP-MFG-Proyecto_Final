CLASS lhc_SalesOrder DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesOrder RESULT result.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR SalesOrder RESULT result.

ENDCLASS.

CLASS lhc_SalesOrder IMPLEMENTATION.

  METHOD get_instance_features.
    READ ENTITIES OF z_i_soheader_2114
    ENTITY  SalesOrder
    FIELDS ( id )
    WITH VALUE #( FOR key_row IN keys ( %key  = key_row-%key ) )
    RESULT DATA(lt_so_result).


  result = VALUE #( FOR salesorder_row IN lt_so_result (
                          %key = salesorder_row-%key
                          %field-id = if_abap_behv=>fc-f-read_only

                          %assoc-_SalesOrderItems = if_abap_behv=>fc-o-enabled ) ).


  ENDMETHOD.

  METHOD get_instance_authorizations.
  ENDMETHOD.

ENDCLASS.
