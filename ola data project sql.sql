create database ola_project;
CREATE TABLE ola_bookings (
    Date DATE,
    Time TIME,
    Booking_ID VARCHAR(20),
    Booking_Status VARCHAR(50),
    Customer_ID VARCHAR(20),
    Vehicle_Type VARCHAR(50),
    Pickup_Location VARCHAR(100),
    Drop_Location VARCHAR(100),
    V_TAT int,
    C_TAT INT,
    Canceled_Rides_by_Customer VARCHAR(50),
    Canceled_Rides_by_Driver VARCHAR(100),
    Incomplete_Rides VARCHAR(10),
    Incomplete_Rides_Reason VARCHAR(100),
    Booking_Value DECIMAL(10,2),
    Payment_Method VARCHAR(20),
    Ride_Distance DECIMAL(6,2),
    Driver_Ratings DECIMAL(3,1),
    Customer_Rating DECIMAL(3,1)
);



-- 1. Retrieve all successful bookings
create view ola_booking_status as
select*from ola_bookings
where Booking_Status = 'success';
select * from ola_booking_status;

-- 2. Find the average ride distance for each vehicle type
select Vehicle_Type,avg(Ride_distance) as avg_distance
from ola_bookings
group by Vehicle_Type;

-- 3. Get the total number of canceled rides by customers
select count(*) from ola_bookings
where Booking_Status= Canceled_Rides_by_Customer ;

-- 4. List the top 5 customers who booked the highest number of rides
select  Customer_ID ,count(Booking_ID) as total_ride
 from ola_bookings
group by Customer_ID
order by total_ride desc limit 5;

-- 5. Get the number of rides canceled by drivers due to personal and car-related issues
select count(*) from ola_bookings
where Canceled_Rides_by_Driver= 'personal & car related issue';

-- 6. Find the maximum and minimum driver ratings for Prime Sedan bookings
select max(Driver_ratings) as max_rating,
min(Driver_ratings) as min_rating from ola_bookings
where Vehicle_Type= 'prime sedan';


-- 7. Retrieve all rides where payment was made using UPI
select * from ola_bookings
where Payment_Method= 'UPI';

-- 8. Find the average customer rating per vehicle type
select avg(customer_rating) as avg_customer_rating, Vehicle_Type
from ola_bookings
group by Vehicle_Type
order by  avg_customer_rating desc;

-- 9. Calculate the total booking value of rides completed successfully
select sum(booking_value) as total_successful_value
from ola_bookings
where Booking_Status='success';

-- 10. list all incomplete rides along with the reason
select booking_id, incomplete_rides_reason
from ola_bookings
where Incomplete_Rides='yes';
