@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Connections'
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
define view entity ZVKSR_ConnectingRoutes
  as select from /dmo/connection
  //Foreign Key Table
  association [0..*] to ZVKSR_FlightDetails as _FlightDetails      on  $projection.AirlineID    = _FlightDetails.AirlineID
                                                                   and $projection.ConnectionID = _FlightDetails.ConnectionID
  //Check and Value Table
  association [1..1] to ZVKSR_Airline       as _Airline            on  $projection.AirlineID = _Airline.AirlineID
  association [1..1] to ZVKSR_Airport       as _DepartureAirport   on  $projection.AirportFromID = _DepartureAirport.AirportID
  association [1..1] to ZVKSR_Airport       as _DestinationAirport on  $projection.AirportToID = _DestinationAirport.AirportID
{
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier_StdVH', element: 'AirlineID'}}]
  key carrier_id      as AirlineID,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Connection_STDVH', element: 'ConnectionID'} }]
  key connection_id   as ConnectionID,
      airport_from_id as AirportFromID,
      airport_to_id   as AirportToID,
      departure_time  as DepartureTime,
      arrival_time    as ArrivalTime,
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit'
      distance        as Distance,
      distance_unit   as DistanceUnit,

      /* Associations */
      _FlightDetails,
      _Airline,
      _DepartureAirport,
      _DestinationAirport
}
