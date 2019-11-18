/*Tickets for a flight*/
SELECT TICKET.ticketId
FROM TICKET, FLIGHT
WHERE TICKET.flightCode=FLIGHT.flightCode;

/*Passengers of a flight*/
SELECT TICKET.passengerId
FROM TICKET, FLIGHT
WHERE TICKET.flightCode=FLIGHT.flightCode
AND (TICKET.status='Booked' 
OR TICKET.status='CheckedIn');

/*show all ticketId's that are booked and its typeName is 'Business'*/
SELECT TICKET.ticketId
FROM TICKET, TICKET_TYPE
WHERE status = 'Booked'
AND TICKET_TYPE.typeName = 'Business';

/*All old passengers */
SELECT passengerId
FROM PASSENGER
WHERE passengerType='Old';

/*Show all personal information of a passenger*/
SELECT *
FROM PASSENGER
WHERE passengerId=<passenger_id>;

/*Tickets booked by a passenger*/
SELECT ticketId
FROM TICKET
WHERE passengerId=<passenger_id>
AND status='Booked';

/*Show all direct flights*/
SELECT *
FROM FLIGHT
WHERE transferStatus=0;

/*Show all tickets from somewhere to somewhere*/
SELECT *
FROM FLIGHT
WHERE source=<source> 
AND destination=<destination>;

/*Show all canceled tickets*/
SELECT * 
FROM TICKET
WHERE cancelDate IS NOT NULL;

/*Show all airline names*/
SELECT airlineName
FROM AIRLINE;

/*Show all airline service fees*/
SELECT airlineName, serviceFee
FROM AIRLINE;

/*Show the descriptions of the campaigns of an airline*/
SELECT description
FROM CAMPAIGN
WHERE airlineCode=<airline_code>;

/*Show all invoices recieved by an airline*/
SELECT *
FROM INVOICE
WHERE airlineCode=<airline_code>;