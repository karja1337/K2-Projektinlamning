USE EventFlowDB;
GO

-- Vy som visar alla planerade evenemang och dess detaljer.
	-- En rad representerar ett planerat evenemang och alla detaljer.
	-- Tabeller som används: 
		--ScheduledEvent, 
		--Organizer, 
		--EventLocation, 
		--EventDetail, 
		--Category
	-- Vyn har testats med SELECT * FROM vw_AllScheduledEventDetails.
CREATE VIEW vw_AllScheduledEventDetails
AS
SELECT
	se.ScheduledEventId,
	se.StartDate,
	se.StartTime,
	o.FullName AS OrganizerName,
	el.Venue,
	el.VenueAdress AS Adress,
	ed.Title,
	ed.EventDescription AS Description,
	c.CategoryId,
	c.Title AS Category
FROM ScheduledEvent AS se

INNER JOIN Organizer AS o
	ON o.OrganizerId = se.OrganizerId

INNER JOIN EventLocation AS el
	ON el.EventLocationId = se.EventLocationId
	
INNER JOIN EventDetail AS ed
	ON ed.EventDetailId = se.EventDetailId
	
INNER JOIN Category AS c
	ON c.CategoryId = ed.CategoryId;
GO


-- TESTAR vw_AllScheduledEventDetails
SELECT *
FROM vw_AllScheduledEventDetails
ORDER BY StartDate;