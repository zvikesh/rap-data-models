@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Flight Details'
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
define view entity ZVKSR_FlightDetails
  as select from /dmo/flight
  //Check and Value Table
  association [1] to ZVKSR_ConnectingRoutes as _Connection on  $projection.ConnectionID = _Connection.ConnectionID
                                                           and $projection.AirlineID    = _Connection.AirlineID
  association [1] to ZVKSR_Airline          as _Airline    on  $projection.AirlineID = _Airline.AirlineID
{
      @Consumption.valueHelpDefinition: [{ entity: {name: '/DMO/I_Carrier_StdVH', element: 'AirlineID'}}]
  key carrier_id     as AirlineID,
      @Consumption.valueHelpDefinition: [{ entity: { name: '/DMO/I_Connection_STDVH', element: 'ConnectionID'} }]
  key connection_id  as ConnectionID,
  key flight_date    as FlightDate,
      @Semantics.amount.currencyCode: 'CurrencyCode'
      price          as SeatPrice,
      @Consumption.valueHelpDefinition: [{ entity: { name: 'I_CurrencyStdVH', element: 'Currency'  } }]
      currency_code  as CurrencyCode,
      plane_type_id  as PlaneTypeID,
      seats_max      as SeatsMax,
      seats_occupied as SeatsOccupied,

      /* Associations */
      _Connection,
      _Airline
}
