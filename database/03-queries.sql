USE EventFlowDB;
GO

-- Visar alla planerade evenemang och dess detaljer.

-- Verksamhetsfråga: 
	-- Ett schemalagt evenemang hålls alltid på exakt en arrangör, exakt en plats och exakt en evenemangsbeskrivning.
-- En resultatrad representerar: 
	-- Ett planerat evenemang med alla evenemangsdetaljer.
-- Förväntat resultat: 
	-- Inga kolumner innehåller Id:n, utan visar informationen genom INNER JOIN.
-- Så verifierades resultatet:
	-- SELECT och granska raderna med testdatan.
SELECT
	se.StartDate,
	se.StartTime,
	o.FullName AS OrganizerName,
	el.Venue,
	el.VenueAdress,
	ed.Title AS EventTitle,
	ed.EventDescription
FROM ScheduledEvent AS se

INNER JOIN Organizer AS o
	ON o.OrganizerId = se.OrganizerId

INNER JOIN EventLocation AS el
	ON el.EventLocationId = se.EventLocationId
	
INNER JOIN EventDetail AS ed
	ON ed.EventDetailId = se.EventDetailId
	
ORDER BY se.StartDate;


-- Visar alla planerade evenemang, även de utan bokningar.

-- Verksamhetsfråga: 
	-- Ett evenemang kan finnas utan några bokningar, och flera evenemang kan ha samma titel.
-- En resultatrad representerar: 
	-- Ett planerat evenemang, vare sig det har bokningar eller ej.
-- Förväntat resultat: 
	-- Totala antal bokningar visar 0 om evenemanget inte har någon bokning. Totalt antal besökare per evenemang visas korrekt.
-- Så verifierades resultatet:
	-- Med en 'SELECT Registration' manuellt räknade och stämde av informationen.
SELECT
	se.ScheduledEventId,
	ed.Title AS EventTitle,
	se.StartTime,
	se.StartDate,
	COUNT(r.VisitorId) AS TotalRegistrations,
	SUM(r.GroupSize) AS TotalVisitors
FROM Registration AS r
RIGHT JOIN ScheduledEvent AS se
	ON se.ScheduledEventId = r.ScheduledEventId
INNER JOIN EventDetail AS ed
	ON ed.EventDetailId = se.EventDetailId
GROUP BY
	se.ScheduledEventId,
	ed.Title,
	se.StartTime,
	se.StartDate
ORDER BY TotalVisitors DESC;


-- Visar alla besökare och hur många bokningar de har.

-- Verksamhetsfråga: 
	-- En bokning har en besökare, en besökare kan ha inga, en eller flera bokningar.
-- En resultatrad representerar:
	-- En besökare med dess bokningar ihopräknade, eller 0 om de inte har några bokningar.
-- Förväntat resultat: 
	-- En rad för varje visitor med minst en bokning, ska visa hur många bokningar en visitor har.
-- Så verifierades resultatet: 
	-- Genom att köra SELECT * Registration och räkna vilka VisitorId som visas och hur många gånger.
SELECT
	v.FullName AS VisitorName,
	COUNT(r.VisitorId) AS Bookings
FROM Registration AS r
RIGHT JOIN Visitor AS v
	ON r.VisitorId = v.VisitorId
GROUP BY 
	r.VisitorId, 
	FullName
ORDER BY Bookings DESC;


-- Visar antal evenemang per kategori.

-- Verksamhetsfråga:
	-- Flera evenemang kan ha samma kategori. En kategori kan finnas utan något evenemang.
-- En resultatrad representerar: 
	-- En kategori, dess titel, och hur många evenemang som hör till kategorin.
-- Förväntat resultat: 
	-- Kategoriets titel och hur många evenemang som hör till den.
-- Så verifierades resultatet:
	-- Med 'SELECT * FROM EventDetail' och jämförde antalen manuellt.
SELECT
	c.Title AS CategoryTitle,
	COUNT(ed.Title) AS EventPerCategory
FROM Category AS c
LEFT JOIN EventDetail AS ed
	ON c.CategoryId = ed.CategoryId
GROUP BY 
	ed.CategoryId, 
	c.Title
ORDER BY EventPerCategory DESC, c.Title;


-- Visar evenemang som en specifik arrangör arrangerar.

-- Verksamhetsfråga:
	-- En arrangör kan hålla i flera evenemang.
-- En resultatrad representerar: 
	-- Ett av evenemangen som "Paul Vik" arrangerar, samt när evenemanget startar.
-- Förväntat resultat: 
	-- Tre rader med evenemang som "Paul Vik" håller i.
-- Så verifierades resultatet:
	-- Manuellt räknat och jämfört antal evenemang "Paul Vik" håller i.
SELECT
	o.OrganizerId,
	o.FullName AS Organizer,
	se.ScheduledEventId,
	ed.Title AS EventTitle,
	ed.EventDescription,
	se.StartDate,
	se.StartTime
FROM dbo.ScheduledEvent AS se

INNER JOIN dbo.Organizer AS o
	ON o.OrganizerId = se.OrganizerId

INNER JOIN dbo.EventDetail AS ed
	ON ed.EventDetailId = se.EventDetailId

WHERE o.FullName = N'Paul Vik';