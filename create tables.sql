create table airport
(
    airportID   int,
    airportName varchar(255),
    city        varchar(255),
    primary key (airportID)
);
create table gate
(
    airportID  int references airport (airportID) on delete cascade,
    gateNumber int,
    primary key (airportID, gateNumber)
);
create table airportEmployee
(
    employeeID int,
    name       varchar(255),
    gender     varchar(6),
    job        varchar(255),
    age        int,
    salary     int,
    airportID  int references airport (airportID) on delete cascade,
    primary key (employeeID),
    check ( gender in ('male', 'female') )
);
create table passenger
(
    passengerID int,
    name        varchar(255),
    age         int,
    gender      varchar(6),
    primary key (passengerID),
    check ( gender in ('male', 'female') )
);
create table flightAgency
(
    agencyID int,
    name     varchar(255),
    address  varchar(5000),
    primary key (agencyID)
);
create table airplaneCompany
(
    companyID      int,
    name           varchar(255),
    foundationDate date,
    primary key (companyID)
);
create table airplane
(
    airplaneID        int,
    name              varchar(255),
    manufacturingDate date,
    companyID         int references airplaneCompany (companyID) on delete cascade,
    primary key (airplaneID)
);
create table airplaneCompanyEmployee
(
    employeeID int,
    name       varchar(255),
    gender     varchar(6),
    job        varchar(255),
    age        int,
    salary     int,
    companyID  int references airplaneCompany (companyID) on delete cascade,
    primary key (employeeID),
    check ( gender in ('male', 'female') )
);
create table pilot
(
    pilotID int references airplanecompanyEmployee (employeeID) on delete cascade,
    degree  varchar(255),
    primary key (pilotID)
);
create table stewardess
(
    stewardessID int references airplanecompanyEmployee (employeeID) on delete cascade,
    primary key (stewardessID)
);
create table flightTeam
(
    teamID        int,
    firstPilotID  int references pilot (pilotID) on delete cascade,
    secondPilotID int references pilot (pilotID) on delete cascade,
    toastmasterID int references stewardess (stewardessID) on delete cascade,
    primary key (teamID)
);
create table mechanic
(
    mechanicID int references airplanecompanyEmployee (employeeID),
    eduDegree  varchar(3),
    primary key (mechanicID),
    check ( eduDegree in ('bs', 'ms', 'doc') )
);
create table flight
(
    flightID           int,
    flightDate         date,
    flightHour         int, --1230 means 12:30 or 2400 means 00:00
    departureAirPortID int references airport (airportID) on delete cascade,
    arrivalAirportID   int references airport (airportID) on delete cascade,
    flightTeamID       int references flightTeam (teamID) on delete cascade,
    airplaneID         int references airplane (airplaneID) on delete cascade,
    arrivalGateNum     int,
    departureGateNum   int,
    flightCapacity     int,
    primary key (flightID)
);
create table ticket
(
    ticketNum int,
    price     int,
    flightID  int references flight (flightID) on delete cascade,
    agencyID  int references flightAgency (agencyID) on delete cascade,
    primary key (ticketNum)
);
create table passengerTicket
(
    ticketNum   int references ticket (ticketNum) on delete cascade,
    passengerID int references passenger (passengerID) on delete cascade,
    primary key (ticketNum, passengerID)
);
create table airplaneService
(
    mechanicID  int references mechanic (mechanicID) on delete cascade,
    airplaneID  int references airplane (airplaneID) on delete cascade,
    serviceDate date,
    report      varchar(2000),
    primary key (mechanicID, airplaneID, serviceDate)
);
create table flightTeamStewardess
(
    teamID       int references flightTeam (teamID) on delete cascade,
    stewardessID int references stewardess (stewardessID) on delete cascade,
    primary key (teamID, stewardessID)
);