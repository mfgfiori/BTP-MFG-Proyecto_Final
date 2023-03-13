@AbapCatalog.sqlViewName: 'ZVSO_HEADER_2114'
@AbapCatalog.compiler.compareFilter: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface - Sales Order : Header'
define root view z_i_soheader_2114
  as select from zso_header_2114 as SalesOrder
  composition [0..*] of z_i_soitems_2114 as _SalesOrderItems
{
  key id,
      email,
      firstname,
      lastname,
      country,
      createon,
      deliverydate,
      orderstatus,
      case orderstatus
          when 001 then  3 --green
          when 002 then  3 --green
          when 005 then  3 --green
          when 004 then 2 -- yellow
          when 003 then  1 --green
          when 006 then  1 --red
          when 007 then  1 --red
          else 0 end as IconStatus,
      'https://i0.wp.com/logaligroup.com/wp-content/uploads/2021/11/LOGALI_AZUL_DEGRADE_RGB_PNG-10.png?resize=823%2C800&ssl=1' as LogoURL,    
      @Semantics.imageUrl: true
      imageurl,
      _SalesOrderItems
}
