CREATE TABLE Airport_T 
( 
AirportID VARCHAR(25) NOT NULL,  
AirportName STRING(75) NOT NULL, 
AirportLocation STRING(50) NOT NULL, 
CONSTRAINT Airport_PK PRIMARY KEY (AirportID) 
); 
CREATE TABLE Date_T 
( 
DateKey DATETIME NOT NULL,  
Year NUMBER(4,0) NOT NULL, 
Month NUMBER(2,0) NOT NULL, 
Day VARCHAR(25) NOT NULL, 
CONSTRAINT Date_PK PRIMARY KEY (DateKey)  
); 
CREATE TABLE AircraftMaintenance_T 
( 
AirlineModelNo VARCHAR(25) NOT NULL,  
MaintenanceID NUMBER(10,0) NOT NULL, 
MaintenanceStatus STRING(20) NOT NULL, 
MaintenanceDate DATETIME NOT NULL, 
MaintenanceDescription VARCHAR(255) NOT NULL, 
CONSTRAINT AircraftMaintenance_PK PRIMARY KEY (AirlineModelNo) 
); 
CREATE TABLE Airline_T 
( 
AirlineID VARCHAR(25) NOT NULL,   
AirlineModelNo VARCHAR(25), 
AirlineName STRING(50) NOT NULL, 
CONSTRAINT Airline_PK PRIMARY KEY (AirlineID) 
CONSTRAINT Airline_FK FOREIGN KEY (AirlineModelNo) REFERENCES AircraftMaintenance_T 
(AirlineModelNo)  
); 
CREATE TABLE GroundStaff_T 
( 
GroundStaffEmpID NUMBER(10,0) NOT NULL,  
AirportID VARCHAR(25), 
AirlineID VARCHAR(25), 
GroundStaffName STRING(50) NOT NULL, 
GroundStaffContact NUMBER(10,0), 
CONSTRAINT GroundStaff_PK PRIMARY KEY (GroundStaffEmpID), 
CONSTRAINT GroundStaff_FK1 FOREIGN KEY (AirportID) REFERENCES Airport_T (AirportID), 
CONSTRAINT GroundStaff_FK2 FOREIGN KEY (AirlineID) REFERENCES Airline_T (AirlineID) 
); 
CREATE TABLE CabinCrewMembers_T 
( 
CabinCrewEmpID NUMBER(10,0) NOT NULL,  
AirlineID VARCHAR(25), 
CabinCrewName STRING(50) NOT NULL, 
7 
CabinCrewDesignation STRING(20) NOT NULL, 
CabinCrewAvailability BOOLEAN NOT NULL, 
CabinCrewContact VARCHAR(15), 
CONSTRAINT CabinCrewMembers_PK PRIMARY KEY (CabinCrewEmpID), 
CONSTRAINT CabinCrewMembers_FK FOREIGN KEY (AirlineID) REFERENCES Airline_T 
(AirlineID) 
); 
CREATE TABLE AirTrafficController_T 
( 
ATCEmpID NUMBER(10,0) NOT NULL,  
AirportID VARCHAR(25),  
RouteID VARCHAR(25) NOT NULL, 
RunwayID VARCHAR(25) NOT NULL, 
CONSTRAINT AirTrafficController_PK PRIMARY KEY (ATCEmpID), 
CONSTRAINT AirTrafficController_FK1 FOREIGN KEY (AirportID) REFERENCES Airport_T 
(AirportID) 
); 
CREATE TABLE Flight_T 
( 
FlightNum VARCHAR(25) NOT NULL,  
DateKey DATETIME, 
AirlineID VARCHAR(25), 
ATCEmpID NUMBER(10,0), 
FlightType CHAR(1) NOT NULL CHECK (FlightType IN ('A', 'D')),   
CONSTRAINT Flight_PK PRIMARY KEY (FlightNum), 
CONSTRAINT Flight_FK1 FOREIGN KEY (DateKey) REFERENCES Date_T (DateKey), 
CONSTRAINT Flight_FK2 FOREIGN KEY (AirlineID) REFERENCES Airline_T (AirlineID), 
CONSTRAINT Flight_FK3 FOREIGN KEY (ATCEmpID) REFERENCES AirTrafficController_T 
(ATCEmpID) 
); 
CREATE TABLE Arrival 
( 
ArrivalID NUMBER(10,0) NOT NULL,  
FlightNum VARCHAR(25), 
ArrivalTime DATETIME NOT NULL, 
ArrivalGate VARCHAR(25) NOT NULL, 
ArrivalStatus VARCHAR(20) NOT NULL, 
CONSTRAINT Arrival_PK PRIMARY KEY (ArrivalID), 
CONSTRAINT Arrival_FK FOREIGN KEY (FlightNum) REFERENCES Flight_T (FlightNum), 
CONSTRAINT Arrival_FlightType CHECK (FlightType = 'A') 
); 
CREATE TABLE Departure 
( 
BoardingID NUMBER(10,0) NOT NULL,  
FlightNum VARCHAR(25), 
DepartureGate VARCHAR(25) NOT NULL, 
DepartureTime DATETIME NOT NULL, 
DepartureStatus VARCHAR(20) NOT NULL, 
CONSTRAINT Departure_PK PRIMARY KEY (BoardingID), 
CONSTRAINT Departure_FK FOREIGN KEY (FlightNum) REFERENCES Flight_T (FlightNum), 
CONSTRAINT Departure_FlightType CHECK (FlightType = 'D') 
8 
); 
CREATE TABLE LuggageDetail_T 
( 
LuggageBelt NUMBER(10,0) NOT NULL, 
ArrivalID NUMBER(10,0),  
CONSTRAINT LuggageDetail_PK PRIMARY KEY (LuggageBeltPK), 
CONSTRAINT LuggageDetail_FK FOREIGN KEY (ArrivalIDFK) REFERENCES Arrival_T (ArrivalID) 
); 