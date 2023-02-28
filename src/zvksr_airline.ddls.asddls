@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airline Carrier'
-- Metadata
@Metadata:{
 allowExtensions: true,
 ignorePropagatedAnnotations: true
}
-- Data Model
   //@VDM.viewType: #BASIC
-- Performance
@ObjectModel.usageType:{
    serviceQuality: #A,
    dataClass: #ORGANIZATIONAL,
    sizeCategory: #M
}
--- Analytical
@Analytics : {
    dataCategory: #DIMENSION
}
define view entity ZVKSR_Airline
  as select from /dmo/carrier
  //Foreign Key Table
  association [1..*] to ZVKSR_ConnectingRoutes as _ConnectingRoutes on $projection.AirlineID = _ConnectingRoutes.AirlineID
{
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier_StdVH', element: 'AirlineID'}}]
  key carrier_id            as AirlineID,
      @Semantics.text: true
      name                  as AirlineName,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency'  } }]
      currency_code         as CurrencyCode,
      @Semantics.user.createdBy:true
      local_created_by      as LocalCreatedBy,
      @Semantics.systemDateTime.createdAt: true
      local_created_at      as LocalCreatedAt,
      @Semantics.user.lastChangedBy: true
      local_last_changed_by as LocalLastChangedBy,
      @Semantics.systemDateTime.localInstanceLastChangedAt: true
      local_last_changed_at as LocalLastChangedAt,
      @Semantics.systemDateTime.lastChangedAt: true
      last_changed_at       as LastChangedAt,

      /* Associations */
      _ConnectingRoutes
}
