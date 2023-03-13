@EndUserText.label: 'Consumption - Sales Order: Items'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define view entity Z_C_SOITEMS_2114
  as projection on z_i_soitems_2114
{

  key id               as SalesOrderId,
  key id_pos           as PositionId,
      name             as Name,
      description      as Description,
      releasedate      as ReleaseDate,
      discontinueddate as DiscontinuedDate,
      @Semantics.amount.currencyCode : 'Currency'
      price            as Price,     
      @Semantics.currencyCode: true
      currencycode     as Currency,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      height           as Height,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      width            as Width,
      @Semantics.quantity.unitOfMeasure : 'UnitOfMeasure'
      depth            as Depth,
      quantity         as Quantity,
      @Semantics.unitOfMeasure: true
      unitofmesaure    as UnitOfMeasure,      
      _UOM._DimensionText.UnitOfMeasureDimensionName as UnitOfMeasureText : localized,
      /* Associations */      
      _SalesOrder : redirected to parent z_c_soheader_2114      
}
