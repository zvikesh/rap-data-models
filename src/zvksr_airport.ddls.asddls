@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Airport'
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
define view entity ZVKSR_Airport
  as select from /dmo/airport
{
  key airport_id as AirportID,
      name       as AirportName,
      city       as City,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_Country', element: 'Country'  } }]
      country    as CountryCode
}
