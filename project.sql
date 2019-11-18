DROP TABLE CAMPAIGN;
DROP TABLE Has;
DROP TABLE INVOICE;
DROP TABLE Serves;
DROP TABLE TICKET;
DROP TABLE TICKET_TYPE;
DROP TABLE FLIGHT;
DROP TABLE TRANSFER;
DROP TABLE AIRLINE;
DROP TABLE FOOD_DRINK;
DROP TABLE PASSENGER;

CREATE TABLE TICKET(
ticketId NUMBER(10) NOT NULL,
status VARCHAR2(10),
needHelp NUMBER(1),
ticketTypeId VARCHAR2(10),
passengerId NUMBER(10),
creationDate DATE,
cancelDate DATE,
seatNumber VARCHAR2(5),
checkInDate DATE,
flightCode VARCHAR2(10),
CONSTRAINT ticketId_pk PRIMARY KEY (ticketId)
	USING INDEX ENABLE
);



CREATE TABLE TICKET_TYPE(
ticketTypeId VARCHAR2(10) NOT NULL,
cabinBaggage NUMBER(2),
baggage NUMBER(2),
typeName VARCHAR2(10),
canRefund NUMBER(1),
canPickSeat NUMBER(1),
airlineCode VARCHAR2(10),
menuId VARCHAR2(10),
CONSTRAINT ticketTypeId_pk PRIMARY KEY (ticketTypeId)
	USING INDEX ENABLE
);

CREATE TABLE PASSENGER(
passengerId NUMBER(10) NOT NULL,
birthDate DATE,
gender VARCHAR2(1),
name VARCHAR2(20),
surname VARCHAR2(20),
email VARCHAR2(50),
phoneNumber VARCHAR2(20),
passengerType VARCHAR2(10),
CONSTRAINT passengerId_pk PRIMARY KEY (passengerId)
	USING INDEX ENABLE
);

CREATE TABLE INVOICE(
invoiceId NUMBER(10) NOT NULL,
amount NUMBER(7, 2),
ticketId NUMBER(10),
passengerId NUMBER(10),
paymentType VARCHAR2(20),
paymentDate DATE,
airlineCode VARCHAR2(10),
CONSTRAINT invoiceId_pk PRIMARY KEY (invoiceId)
	USING INDEX ENABLE
);

CREATE TABLE FLIGHT(
flightCode VARCHAR2(10) NOT NULL,
flightDate DATE,
source VARCHAR2(20),
destination VARCHAR2(20),
basePriceForBusiness NUMBER(7),
basePriceForEconomy NUMBER(7),
numberOfBusinessTickets NUMBER(5),
numberOfEconomyTickets NUMBER(5),
transferStatus NUMBER(1),
airlineCode VARCHAR2(10),
CONSTRAINT flightCode_pk PRIMARY KEY (flightCode)
	USING INDEX ENABLE
);

CREATE TABLE FOOD_DRINK(
menuId VARCHAR2(10) NOT NULL,
menuItems VARCHAR2(70),
price NUMBER(7, 2),
CONSTRAINT menuId_pk PRIMARY KEY (menuId)
	USING INDEX ENABLE
);

CREATE TABLE AIRLINE(
airlineCode VARCHAR2(10) NOT NULL,
airlineName VARCHAR2(30),
serviceFee NUMBER(7, 2),
priceForStudent NUMBER(7),
priceForAdult NUMBER(7),
priceForChild NUMBER(7),
priceForOld NUMBER(7),
priceForBaby NUMBER(7),
priceForTeen NUMBER(7),
CONSTRAINT airlineCode_pk PRIMARY KEY (airlineCode)
	USING INDEX ENABLE
);

CREATE TABLE TRANSFER(
transferId NUMBER(10) NOT NULL,
transferPoint VARCHAR2(20),
CONSTRAINT transferId_pk PRIMARY KEY (transferId)
	USING INDEX ENABLE
);

CREATE TABLE CAMPAIGN(
campaignCode VARCHAR2(10) NOT NULL,
startDate DATE,
expireDate DATE,
discount NUMBER(7, 2),
airlineCode VARCHAR2(10),
CONSTRAINT campaignCode_pk PRIMARY KEY (campaignCode)
	USING INDEX ENABLE
);

CREATE TABLE Has(
flightCode VARCHAR2(10),
transferId NUMBER(10)
);

CREATE TABLE Serves(
menuId VARCHAR2(10),
flightCode VARCHAR2(10)
);

ALTER TABLE TICKET ADD CONSTRAINT Ticket_flightCode_fk FOREIGN KEY (flightCode)
    REFERENCES FLIGHT (flightCode);

ALTER TABLE TICKET ADD CONSTRAINT Ticket_ticketTypeId_fk FOREIGN KEY (ticketTypeId)
	REFERENCES TICKET_TYPE (ticketTypeId);

ALTER TABLE TICKET ADD CONSTRAINT Ticket_passengerId_fk FOREIGN KEY (passengerId)
	REFERENCES PASSENGER (passengerId);

ALTER TABLE TICKET_TYPE ADD CONSTRAINT Tickettype_airlineCode_fk FOREIGN KEY (airlineCode)
	REFERENCES AIRLINE (airlineCode);

ALTER TABLE TICKET_TYPE ADD CONSTRAINT Tickettype_menuId_fk FOREIGN KEY (menuId)
	REFERENCES FOOD_DRINK (menuId);

ALTER TABLE INVOICE ADD CONSTRAINT Invoice_ticketId_fk FOREIGN KEY (ticketId)
	REFERENCES TICKET (ticketId);

ALTER TABLE INVOICE ADD CONSTRAINT Invoice_passengerId_fk FOREIGN KEY (passengerId)
	REFERENCES PASSENGER (passengerId);

ALTER TABLE INVOICE ADD CONSTRAINT Invoice_airlineCode_fk FOREIGN KEY (airlineCode)
	REFERENCES AIRLINE (airlineCode);

ALTER TABLE FLIGHT ADD CONSTRAINT Flight_airlineCode_fk FOREIGN KEY (airlineCode)
	REFERENCES AIRLINE (airlineCode);

ALTER TABLE CAMPAIGN ADD CONSTRAINT Campaign_airlineCode_fk FOREIGN KEY (airlineCode)
	REFERENCES AIRLINE (airlineCode);

ALTER TABLE Has ADD CONSTRAINT has_flightCode_fk FOREIGN KEY (flightCode)
	REFERENCES FLIGHT (flightCode);

ALTER TABLE Has ADD CONSTRAINT has_transferId_fk FOREIGN KEY (transferId)
	REFERENCES TRANSFER (transferId);

ALTER TABLE Serves ADD CONSTRAINT serves_flightCode_fk FOREIGN KEY (flightCode)
	REFERENCES FLIGHT (flightCode);

ALTER TABLE Serves ADD CONSTRAINT serves_menuId_fk FOREIGN KEY (menuId)
	REFERENCES FOOD_DRINK (menuId);


INSERT INTO AIRLINE (airlineCode, airlineName, serviceFee, priceForStudent, priceForAdult, priceForChild, priceForOld, priceForBaby, priceForTeen)
 VALUES ('SE', 'Sun Express', 12, 75, 125, 50, 125, 0, 75);

INSERT INTO AIRLINE (airlineCode, airlineName, serviceFee, priceForStudent, priceForAdult, priceForChild, priceForOld, priceForBaby, priceForTeen)
 VALUES ('TA', 'Turkish Airlines', 15, 100, 150, 75, 150, 0, 100);

INSERT INTO AIRLINE (airlineCode, airlineName, serviceFee, priceForStudent, priceForAdult, priceForChild, priceForOld, priceForBaby, priceForTeen)
 VALUES ('PGS', 'Pegasus', 20, 125, 175, 100, 175, 25, 125);

INSERT INTO AIRLINE (airlineCode, airlineName, serviceFee, priceForStudent, priceForAdult, priceForChild, priceForOld, priceForBaby, priceForTeen)
 VALUES ('OA', 'Onur Air', 10, 65, 115, 40, 115, 0, 65);

INSERT INTO AIRLINE (airlineCode, airlineName, serviceFee, priceForStudent, priceForAdult, priceForChild, priceForOld, priceForBaby, priceForTeen)
 VALUES ('AJ', 'Atlas Jet', 13, 105, 145, 70, 145, 0, 90);

INSERT INTO CAMPAIGN (campaignCode, startDate, expireDate, discount, airlineCode)
 VALUES ('RMZN', TO_DATE('2018-06-12 10:00:00','yyyy/mm/dd hh24:mi:ss'), TO_DATE('2018-07-12 23:59:59','yyyy/mm/dd hh24:mi:ss'), 10, 'SE');

INSERT INTO CAMPAIGN (campaignCode, startDate, expireDate, discount, airlineCode)
 VALUES ('BLCKFRDY', TO_DATE('2018-11-28 00:00:00','yyyy/mm/dd hh24:mi:ss'), TO_DATE('2018-11-29 23:59:59','yyyy/mm/dd hh24:mi:ss'), 25, 'PGS');

INSERT INTO CAMPAIGN (campaignCode, startDate, expireDate, discount, airlineCode)
 VALUES ('KRBN', TO_DATE('2018-02-20 07:00:00','yyyy/mm/dd hh24:mi:ss'), TO_DATE('2018-02-24 23:59.59','yyyy/mm/dd hh24:mi:ss'), 15, 'SE');

INSERT INTO FLIGHT (flightCode, flightDate, source, destination, basePriceForBusiness, basePriceForEconomy,
numberOfBusinessTickets, numberOfEconomyTickets, transferStatus, airlineCode)
 VALUES ('4560', TO_DATE('2018-01-01 08:45:00','yyyy/mm/dd hh24:mi:ss'), 'Izmir', 'Istanbul', 500, 150, 50, 200, 0, 'TA');

INSERT INTO FLIGHT (flightCode, flightDate, source, destination, basePriceForBusiness, basePriceForEconomy,
numberOfBusinessTickets, numberOfEconomyTickets, transferStatus, airlineCode)
 VALUES ('5630', TO_DATE('2018-03-10 12:15:00','yyyy/mm/dd hh24:mi:ss'), 'Izmir', 'Samsun', 650, 200, 40, 150, 1, 'SE');

INSERT INTO FLIGHT (flightCode, flightDate, source, destination, basePriceForBusiness, basePriceForEconomy,
numberOfBusinessTickets, numberOfEconomyTickets, transferStatus, airlineCode)
 VALUES ('3579', TO_DATE('2018-05-09 15:15:00','yyyy/mm/dd hh24:mi:ss'), 'Trabzon', 'Antalya', 600, 190, 45, 140, 1, 'AJ');

INSERT INTO FOOD_DRINK (menuId, menuItems, price)
 VALUES ('HAM35', 'Hamburger, Coke, Potato', 27.5);

INSERT INTO FOOD_DRINK (menuId, menuItems, price)
 VALUES ('WINE61', 'Wine, Cheese', 500);

INSERT INTO FOOD_DRINK (menuId, menuItems, price)
 VALUES ('LATT', 'Latte', 12.5);

INSERT INTO Serves (menuId, flightCode)
 VALUES ('HAM35', 4560);

INSERT INTO Serves (menuId, flightCode)
 VALUES ('WINE61', 3579);

INSERT INTO Serves (menuId, flightCode)
 VALUES ('LATT', 5630);

INSERT INTO TRANSFER (transferId, transferPoint)
 VALUES (1, 'Istanbul');

INSERT INTO TRANSFER (transferId, transferPoint)
 VALUES (2, 'Ankara');

INSERT INTO Has (flightCode, transferId)
 VALUES ('5630', 1);

INSERT INTO Has (flightCode, transferId)
 VALUES ('3579', 2);

INSERT INTO PASSENGER (passengerId, birthDate, gender, name, surname, email, phoneNumber, passengerType)
 VALUES (0, TO_DATE('1997-07-24','yyyy/mm/dd'), 'M', 'Berkay', 'Karakoc', 'berkaykarakoc@gmail.com', '5545964866', 'Student');

INSERT INTO PASSENGER (passengerId, birthDate, gender, name, surname, email, phoneNumber, passengerType)
 VALUES (1, TO_DATE('1946-07-07','yyyy/mm/dd'), 'M', 'Eren', 'Gulec', 'erencangulec@gmail.com', '5346859961', 'Old');

INSERT INTO PASSENGER (passengerId, birthDate, gender, name, surname, email, phoneNumber, passengerType)
 VALUES (2, TO_DATE('2002-03-14','yyyy/mm/dd'), 'M', 'Cem', 'Sakizci', 'cemsakizci@gmail.com', '5059432323', 'Teen');

INSERT INTO PASSENGER (passengerId, birthDate, gender, name, surname, email, phoneNumber, passengerType)
 VALUES (3, TO_DATE('2018-05-01','yyyy/mm/dd'), 'F', 'Iremnur', 'Kulaksiz', NULL, NULL, 'Baby');

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (0, 5, 15, 'Economy', 0, 0, 'TA', NULL);

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (1, 10, 25, 'Business', 1, 1, 'AJ', 'WINE61');

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (2, 5, 15, 'Economy', 0, 0, 'TA', 'HAM35');

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (3, 5, 15, 'Economy', 0, 0, 'OA', NULL);

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (4, 10, 25, 'Business', 1, 1, 'SE', 'LATT');

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (5, 10, 25, 'Business', 1, 1, 'TA', NULL);

INSERT INTO TICKET_TYPE (ticketTypeId, cabinBaggage, baggage, typeName, canRefund, canPickSeat, airlineCode, menuId)
 VALUES (6, 5, 15, 'Economy', 0, 0, 'PGS', NULL);

INSERT INTO TICKET (ticketId, status, needHelp, ticketTypeId, passengerId, creationDate, cancelDate, seatNumber, checkInDate, flightCode)
 VALUES (0, 'CheckedIn', 0, 1, 0, TO_DATE('2018-07-07 23:00:00','yyyy/mm/dd hh24:mi:ss'), NULL, 'A35', TO_DATE('2018-07-07 00:00:00','yyyy/mm/dd hh24:mi:ss'), 3579);

INSERT INTO TICKET (ticketId, status, needHelp, ticketTypeId, passengerId, creationDate, cancelDate, seatNumber, checkInDate, flightCode)
 VALUES (1, 'Booked', 1, 1, 1, TO_DATE('2018-06-11 21:17:23','yyyy/mm/dd hh24:mi:ss'), NULL, NULL, NULL, 3579);

INSERT INTO TICKET (ticketId, status, needHelp, ticketTypeId, passengerId, creationDate, cancelDate, seatNumber, checkInDate, flightCode)
 VALUES (2, 'CheckedIn', 0, 2, 2, TO_DATE('2018-09-12 13:35:44','yyyy/mm/dd hh24:mi:ss'), NULL, 'B01', TO_DATE('2018-09-12 13:36:44','yyyy/mm/dd hh24:mi:ss'), 4560);

INSERT INTO TICKET (ticketId, status, needHelp, ticketTypeId, passengerId, creationDate, cancelDate, seatNumber, checkInDate, flightCode)
 VALUES (3, 'CheckedIn', 0, 2, 3, TO_DATE('2018-09-12 13:35:44','yyyy/mm/dd hh24:mi:ss'), NULL, 'B02', TO_DATE('2018-09-12 13:36:44','yyyy/mm/dd hh24:mi:ss'), 4560);

INSERT INTO INVOICE (invoiceId, amount, ticketId, passengerId, paymentType, paymentDate, airlineCode)
 VALUES (0, 1205, 0, 0, 'Debit Cart', TO_DATE('2018-07-07 23:03:22','yyyy/mm/dd hh24:mi:ss'), 'AJ');

INSERT INTO INVOICE (invoiceId, amount, ticketId, passengerId, paymentType, paymentDate, airlineCode)
 VALUES (1, 1245, 1, 1, 'Credit Cart', TO_DATE('2018-06-11 21:17:23','yyyy/mm/dd hh24:mi:ss'), 'AJ');

INSERT INTO INVOICE (invoiceId, amount, ticketId, passengerId, paymentType, paymentDate, airlineCode)
 VALUES (2, 277.5, 2, 2, 'Debit Cart', TO_DATE('2018-09-12 13:35:44','yyyy/mm/dd hh24:mi:ss'), 'TA');

INSERT INTO INVOICE (invoiceId, amount, ticketId, passengerId, paymentType, paymentDate, airlineCode)
 VALUES (3, 177.5, 3, 3, 'Debit Cart', TO_DATE('2018-09-12 13:35:44','yyyy/mm/dd hh24:mi:ss'), 'TA');