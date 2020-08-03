select *
from airport;


select f.flightid, passenger.name
from passenger
         join passengerticket p on passenger.passengerid = p.passengerid
         join ticket t on p.ticketnum = t.ticketnum
         join flight f on t.flightid = f.flightid
order by f.flightid;


select *
from passenger;


select *
from flight;


select flightid, arrivalgatenum, departuregatenum
from flight;


select airplanecompany.companyid, airplanecompany.name, airplane.name
from airplanecompany
         join airplane using (companyid)
order by airplanecompany.companyid;


create temporary table temp_employee as
select *
from airplanecompanyemployee;
create temporary table temp_employee2 as
select *
from airplanecompanyemployee;
select flight.flightid,
       airplanecompanyemployee.name as stewardessname,
       temp_employee.name           as firstpilotname,
       temp_employee2.name          as secondpilotname
from flight
         join flightteam on flight.flightteamid = flightteam.teamid
         join flightteamstewardess on flightteam.teamid = flightteamstewardess.teamid
         join airplanecompanyemployee on airplanecompanyemployee.employeeid =
                                         flightteamstewardess.stewardessid
         join temp_employee on temp_employee.employeeid = flightteam.firstpilotid
         join temp_employee2 on temp_employee2.employeeid = flightteam.secondpilotid;


select flight.flightid, airplanecompanyemployee.name, flight.flightdate
from flight
         join flightteam on flight.flightteamid = flightteam.teamid
         join airplanecompanyemployee on flightteam.firstpilotid = airplanecompanyemployee.employeeid
order by airplanecompanyemployee.name;


select flight.flightid, airplanecompanyemployee.name, flight.flightdate
from flight
         join flightteam on flight.flightteamid = flightteam.teamid
         join airplanecompanyemployee on flightteam.firstpilotid = airplanecompanyemployee.employeeid
where (flight.flightdate between '2019-08-02' and '2020-07-22')
  and airplanecompanyemployee.name = 'Jafar Alidoosti';


select flight.flightid, airplanecompanyemployee.name, flight.flightdate
from flight
         join flightteam on flight.flightteamid = flightteam.teamid
         join airplanecompanyemployee on flightteam.secondpilotid =
                                         airplanecompanyemployee.employeeid
order by airplanecompanyemployee.name;


select flight.flightid, airplanecompanyemployee.name
from flight
         join flightteam on flight.flightteamid = flightteam.teamid
         join flightteamstewardess on flightteam.teamid = flightteamstewardess.teamid
         join airplanecompanyemployee on flightteamstewardess.stewardessid =
                                         airplanecompanyemployee.employeeid
order by flightid;


select *
from airplane;


select a.airplaneid,
       a.name,
       airplaneservice.servicedate,
       airplanecompanyemployee.name,
       airplaneservice.report
from airplaneservice
         join airplane a on airplaneservice.airplaneid = a.airplaneid
         join airplanecompanyemployee on airplanecompanyemployee.employeeid =
                                         airplaneservice.mechanicid;


select a.airplaneid,
       a.name,
       airplaneservice.servicedate,
       airplanecompanyemployee.name,
       airplaneservice.report
from airplaneservice
         join airplane a on airplaneservice.airplaneid = a.airplaneid
         join airplanecompanyemployee on airplanecompanyemployee.employeeid =
                                         airplaneservice.mechanicid
where servicedate between '2018-12-07' and '2020-03-02';


select ticketnum, f.name
from ticket
         join flightagency f on ticket.agencyid = f.agencyid;


select flightid, flightcapacity - count(*)
from flight
         join ticket using (flightid)
group by flightid;


select passenger.name, flight.flightid
from flight
         join ticket on flight.flightid = ticket.flightid
         join passengerticket on ticket.ticketnum = passengerticket.ticketnum
         join passenger on passengerticket.passengerid = passenger.passengerid
order by passenger.name;


create temporary table temp_airport as
select *
from airport;
select *
from temp_airport;
select flightid, airport.airportname as arrival, temp_airport.airportname as departure
from flight
         join airport on flight.arrivalairportid = airport.airportid
         join temp_airport on flight.departureairportid = temp_airport.airportid;