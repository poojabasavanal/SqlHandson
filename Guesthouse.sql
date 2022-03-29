--EASY PROBLEMS:

--Guest 1183. Give the booking_date and the number of nights for guest 1183.

SELECT first_name,last_name
FROM booking JOIN guest ON guest_id = guest.id
 WHERE room_no=101 AND booking_date='2016-11-17'

 --When do they get here? List the arrival time and the first and last names for all guests due to arrive on 2016-11-05, order the output by time of arrival.
 SELECT
	booking.arrival_time,
	guest.first_name,
	guest.last_name
FROM
	booking
	JOIN
		guest
		ON (booking.guest_id = guest.id)
WHERE
	YEAR(booking.booking_date) = '2016'
	AND MONTH(booking.booking_date) = '11'
	AND DAY(booking.booking_date) = '05'
ORDER BY
	booking.arrival_time;

--Look up daily rates. Give the daily rate that should be paid for bookings with ids 5152, 5165, 5154 and 5295. Include booking id, room type, number of occupants and the amount.
SELECT
	booking.booking_id,
	booking.room_type_requested,
	booking.occupants,
	rate.amount
FROM
	booking
	JOIN
		rate
		ON (booking.occupants = rate.occupancy
		AND booking.room_type_requested = rate.room_type)
WHERE
	booking.booking_id = 5152
	OR booking.booking_id = 5154
	OR booking.booking_id = 5295;


--Who’s in 101? Find who is staying in room 101 on 2016-12-03, include first name, last name and address.
SELECT
	guest.first_name,
	guest.last_name,
	guest.address
FROM
	guest
	JOIN
		booking
		ON (booking.guest_id = guest.id)
WHERE
	booking.room_no = 101
	AND booking.booking_date = '2016-12-03';


--How many bookings, how many nights? For guests 1185 and 1270 show the number of bookings made and the total number of nights. Your output should include the guest id and the total number of bookings and the total number of nights.
SELECT
	guest_id,
	COUNT(nights),
	sum(nights)
FROM
	booking
WHERE
	guest_id = 1185
	OR guest_id = 1270
GROUP BY
	guest_id;

--MEDIUM PROBLEMS:

--Ruth Cadbury. Show the total amount payable by guest Ruth Cadbury for her room bookings. You should JOIN to the rate table using room_type_requested and occupants.
SELECT first_name,last_name
FROM booking JOIN guest ON guest_id = guest.id
 WHERE room_no=101 AND booking_date='2016-11-17'

 --Including Extras. Calculate the total bill for booking 5346 including extras.
 SELECT
	SUM(booking.nights * rate.amount) + SUM(e.amount) AS Total
FROM
	booking
	JOIN
		rate
		ON (booking.occupants = rate.occupancy
		AND booking.room_type_requested = rate.room_type)
	JOIN
		(
			SELECT
				booking_id,
				SUM(amount) as amount
			FROM
				extra
			group by
				booking_id
		)
		AS e
		ON (e.booking_id = booking.booking_id)
WHERE
	booking.booking_id = 5128;

--Edinburgh Residents. For every guest who has the word “Edinburgh” in their address show the total number of nights booked.Be sure to include 0 for those guests who have never had a booking. Show last name, first name, address and number of nights. Order by last name then first name.

SELECT
	guest.last_name,
	guest.first_name,
	guest.address,
	CASE
		WHEN
			SUM(booking.nights) IS NULL
		THEN
			0
		ELSE
			SUM(booking.nights)
	END
	AS nights
FROM
	booking
	RIGHT JOIN
		guest
		ON (guest.id = booking.guest_id)
WHERE
	guest.address LIKE '%Edinburgh%'
GROUP BY
	guest.last_name, guest.first_name, guest.address
ORDER BY
	guest.last_name, guest.first_name;

--How busy are we? For each day of the week beginning 2016-11-25 show the number of bookings starting that day. Be sure to show all the days of the week in the correct order.

SELECT
	booking_date AS i,
	COUNT(booking_id) AS arrivals
FROM
	booking
WHERE
	booking_date BETWEEN '2016-11-25' AND '2016-12-01'
GROUP BY
	booking_date;

--How many guests? Show the number of guests in the hotel on the night of 2016-11-21. Include all occupants who checked in that day but not those who checked out.

SELECT
	SUM(occupants)
FROM
	booking
WHERE
	booking_date <= '2016-11-21'
	AND DATE_ADD(booking_date, INTERVAL nights DAY) > '2016-11-21';