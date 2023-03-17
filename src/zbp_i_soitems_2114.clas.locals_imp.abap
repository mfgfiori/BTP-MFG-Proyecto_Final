CLASS lhc_SalesOrderItems DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_features FOR INSTANCE FEATURES
      IMPORTING keys REQUEST requested_features FOR SalesOrderItems RESULT result.

ENDCLASS.

CLASS lhc_SalesOrderItems IMPLEMENTATION.

  METHOD get_instance_features.

      READ ENTITIES OF z_i_soheader_2114
              ENTITY SalesOrderItems
              FIELDS ( id_pos )
                WITH VALUE #( FOR key_row IN keys ( %key  = key_row-%key ) )
              RESULT DATA(lt_items_result).

    result = VALUE #( FOR soitems_row IN lt_items_result (
                          %key = soitems_row-%key
                          %field-id_pos = if_abap_behv=>fc-f-read_only ) ).

  ENDMETHOD.

ENDCLASS.
