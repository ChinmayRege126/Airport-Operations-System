
--- Volume of Flights handled by each ATC employeee ID---------
SELECT
    ATC.ATCEMPID, 
    count(F.FLIGHTNUM) as Flight_count 
from
    FLIGHT F
left join 
    AIRTRAFFICCONTROLLERDETAILS ATC
on F.ATCEMPID=ATC.ATCEMPID
group by ATC.ATCEMPID

--- This Query will return the Luggage ID for each airline and number of flights operated on that particular luggage belt

Select F.AIRLINEID as AIRLINEID,
    L.LUGGAGEBELT as LUGGAGEBELT ,
    count(A.FLIGHTNUM) as Flight_count
from ARRIVAL A
left join 
    LUGGAGEDETAIL L
	on A.ARRIVALID = L.ARRIVALID
left join 
    FLIGHT F
	on A.FLIGHTNUM=F.FLIGHTNUM
group by F.AIRLINEID,L.LUGGAGEBELT

----This Query will return number of flights by airport and by month
  
with flight_count as (
    select 
        A.AIRPORTID as AIRPORTID,
        A.AIRPORTNAME as AIRPORTNAME,
        substr(F.DATEID, 4, 2) as Month_no,
        count(F.FLIGHTNUM) as FLIGHT_COUNT
        from
        FLIGHT F
    left join 
        AIRTRAFFICCONTROLLERDETAILS ATC
    on F.ATCEMPID=ATC.ATCEMPID
    LEFT JOIN AIRPORT A
        on ATC.AIRPORTID = A.AIRPORTID
    Group by 
        A.AIRPORTID, A.AIRPORTNAME, substr(F.DATEID, 4, 2)
)
Select 
    AIRPORTID,
    AIRPORTNAME,
      case 
        when Month_no = '01' then 'Jan'
        when Month_no = '02' then 'Feb'
        when Month_no = '03' then 'Mar'
        when Month_no = '04' then 'Apr'
        when Month_no = '05' then 'May'
        when Month_no = '06' then 'Jun'
        when Month_no = '07' then 'Jul'
        when Month_no = '08' then 'Aug'
        when Month_no = '09' then 'Sep'
        when Month_no = '10' then 'Oct'
        when Month_no = '11' then 'Nov'
        when Month_no = '12' then 'Dec'
    end as MONTH_NAME,
    FLIGHT_COUNT
from 
    flight_count
    order by FLIGHT_COUNT DESC


--- This query will return workforce for each of the Airline ID -------
    
with Staff as (
    select
        A.AIRLINEID as AIRLINEID,
        C.CABINCREWEMPID as STAFFID
    from 
        CABINCREWMEMBERS C
    Left join 
        AIRLINE A
        on C.AIRLINEID = A.AIRLINEID

    Union All

    select 
        A.AIRLINEID as AIRLINEID,
        G.GROUNDSTAFFEMPID as STAFFID
    from 
        GROUNDSTAFFDETAILS G
    Left join 
        AIRLINE A
        on G.AIRLINEID = A.AIRLINEID
)
select AIRLINEID,STAFF_TYPE,count(STAFFID) from (
select 
    AIRLINEID,
    STAFFID,
    Case
        when SUBSTR(STAFFID, 1, 2) = 'GS' then 'GROUNDSTAFF'
        when SUBSTR(STAFFID, 1, 2) = 'CC' then 'CABINCREW'
    end as STAFF_TYPE
from Staff)
    Group by AIRLINEID,STAFF_TYPE
    order by AIRLINEID ;






----Volume of flights attained by-----------

SELECT
    ATC.ATCEMPID, 
    count(F.FLIGHTNUM) as Flight_count 
from
    FLIGHT F
left join 
    AIRTRAFFICCONTROLLERDETAILS ATC
on F.ATCEMPID=ATC.ATCEMPID
group by ATC.ATCEMPID

--Below Flight will give Which airline ID is mapped with which Luggage belts and number flights coming on that belt for that airlineID------

Select F.AIRLINEID as AIRLINEID,
    L.LUGGAGEBELT as LUGGAGEBELT ,
    count(A.FLIGHTNUM) as Flight_count
from ARRIVAL A
left join 
    LUGGAGEDETAIL L
	on A.ARRIVALID = L.ARRIVALID
left join 
    FLIGHT F
	on A.FLIGHTNUM=F.FLIGHTNUM
group by F.AIRLINEID,L.LUGGAGEBELT


----Below Query will return number of flights each months-------
  
with flight_count as (
    select 
        A.AIRPORTID as AIRPORTID,
        A.AIRPORTNAME as AIRPORTNAME,
        substr(F.DATEID, 4, 2) as Month_no,
        count(F.FLIGHTNUM) as FLIGHT_COUNT
        from
        FLIGHT F
    left join 
        AIRTRAFFICCONTROLLERDETAILS ATC
    on F.ATCEMPID=ATC.ATCEMPID
    LEFT JOIN AIRPORT A
        on ATC.AIRPORTID = A.AIRPORTID
    Group by 
        A.AIRPORTID, A.AIRPORTNAME, substr(F.DATEID, 4, 2)
)
Select 
    AIRPORTID,
    AIRPORTNAME,
      case 
        when Month_no = '01' then 'Jan'
        when Month_no = '02' then 'Feb'
        when Month_no = '03' then 'Mar'
        when Month_no = '04' then 'Apr'
        when Month_no = '05' then 'May'
        when Month_no = '06' then 'Jun'
        when Month_no = '07' then 'Jul'
        when Month_no = '08' then 'Aug'
        when Month_no = '09' then 'Sep'
        when Month_no = '10' then 'Oct'
        when Month_no = '11' then 'Nov'
        when Month_no = '12' then 'Dec'
    end as MONTH_NAME,
    FLIGHT_COUNT
from 
    flight_count
    order by FLIGHT_COUNT DESC


------Below Query will return Workforce for each Airline ID ----------
    
with Staff as (
    select
        A.AIRLINEID as AIRLINEID,
        C.CABINCREWEMPID as STAFFID
    from 
        CABINCREWMEMBERS C
    Left join 
        AIRLINE A
        on C.AIRLINEID = A.AIRLINEID

    Union All

    select 
        A.AIRLINEID as AIRLINEID,
        G.GROUNDSTAFFEMPID as STAFFID
    from 
        GROUNDSTAFFDETAILS G
    Left join 
        AIRLINE A
        on G.AIRLINEID = A.AIRLINEID
)
select AIRLINEID,STAFF_TYPE,count(STAFFID) from (
select 
    AIRLINEID,
    STAFFID,
    Case
        when SUBSTR(STAFFID, 1, 2) = 'GS' then 'GROUNDSTAFF'
        when SUBSTR(STAFFID, 1, 2) = 'CC' then 'CABINCREW'
    end as STAFF_TYPE
from Staff)
    Group by AIRLINEID,STAFF_TYPE
    order by AIRLINEID ;


-----Below Query will provide Maintenace report by Airline ID----------------

with maintenance_report as (
    select AIRLINEMODELNO, MAINTENANCESTATUS 
    from AIRCRAFTMAINTENANCE 
),
airline_report as (
    select AIRLINEID, AIRLINEMODELNO, AIRLINENAME
    from AIRLINE
)
select 
    B.AIRLINEID,
    B.AIRLINENAME,
    B.MAINTENANCESTATUS,
    count(B.MAINTENANCESTATUS) as MAINTENANCE_COUNT
from (
    select 
        A.AIRLINEID,
        A.AIRLINENAME,
        M.MAINTENANCESTATUS
    from 
        maintenance_report M
    left join 
        airline_report A
        on M.AIRLINEMODELNO = A.AIRLINEMODELNO
    ) B
group by 
    B.AIRLINEID, 
    B.AIRLINENAME, 
    B.MAINTENANCESTATUS
    order by B.AIRLINEID ;
