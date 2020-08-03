--1)
create or replace function verifyGateNumExists()
    returns trigger as
$body$
begin
    if (((new.arrivalGateNum, new.arrivalAirportID) not in (select gateNumber, airportID from gate))
        or
        ((new.departureGateNum, new.departureAirportID) not in (select gateNumber, airportID
                                                                from gate))) then
        raise exception 'one of entered gate numbers do not exists';
    end if;
    return new;
end;
$body$ language plpgsql;
create trigger verify_gate_num_exists
    before insert
    on flight
    for each row
execute procedure verifyGateNumExists();

--2)
create or replace function checkIfServiceDateChanges()
    returns trigger as
$body$
begin
    raise exception 'Date of airplane service cant change';
end;
$body$ language plpgsql;
create trigger check_if_service_date_changes
    before update of serviceDate
    on airplaneService
    for each row
execute procedure checkIfServiceDateChanges();

--3)
create or replace function checkIfFlightIsNotFull()
    returns trigger as
$body$
begin
    if ((select count(*)
         from flight
                  join ticket using (flightID)
         where flightID = new.flightID) in (select flightcapacity
                                            from flight
                                            where flightid =
                                                  new.flightID)) then
        raise exception 'Flight is full';
    end if;
    return new;
end ;
$body$ language plpgsql;
create trigger check_if_flight_is_not_full
    before insert
    on ticket
    for each row
execute procedure checkIfFlightIsNotFull();