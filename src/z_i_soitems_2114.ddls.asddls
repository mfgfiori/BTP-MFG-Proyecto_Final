@AbapCatalog.sqlViewName: 'ZVSO_ITEMS'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Sales Order : Items'
define view z_i_soitems_2114 as select from zso_items_2114 as SaleOrderItems 
association to parent z_i_soheader_2114 as _SalesOrder on $projection.id = _SalesOrder.id 
association [0..1] to I_Currency        as _Currency on $projection.currencycode = _Currency.Currency
association [0..1] to I_UnitOfMeasure   as _UOM on $projection.unitofmesaure = _UOM.UnitOfMeasure
{
  key id,
  key id_pos,
      name,
      description,
      releasedate,
      discontinueddate,
      @Semantics.amount.currencyCode : 'currencycode'
      price,
      @Semantics.currencyCode: true
      currencycode,
      @Semantics.quantity.unitOfMeasure : 'unitofmesaure'
      height,
      @Semantics.quantity.unitOfMeasure : 'unitofmesaure'
      width,
      @Semantics.quantity.unitOfMeasure : 'unitofmesaure'
      depth,
      quantity,
      @Semantics.unitOfMeasure: true
      unitofmesaure,
      _SalesOrder,
      _Currency,
      _UOM
}
