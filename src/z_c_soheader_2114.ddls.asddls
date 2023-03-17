@EndUserText.label: 'Consumption - Sales Order : Header'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
define root view entity z_c_soheader_2114
  as projection on z_i_soheader_2114
{
  key id           as SalesOrderId,
      email        as Email,
      firstname    as FirstName,
      lastname     as LastName,
      country      as Country,
      createon     as CreateOn,
      deliverydate as DeliveryDate,
      orderstatus  as Status,
      IconStatus   as IconStatus,     
      @Semantics.imageUrl: true    
      LogoURL      as LogoURL,
      @Semantics.imageUrl: true  
      imageurl     as ImageURL,
      /* Associations */
      _SalesOrderItems : redirected to composition child Z_C_SOITEMS_2114
}
