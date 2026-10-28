
--Testar triggern som loggar nya planerade evenemang i ScheduledEventLog tabellen.


INSERT INTO ScheduledEvent (StartDate, StartTime, OrganizerId, EventLocationId, EventDetailId)
	VALUES
		('2026-11-29', '19:00:00', 5, 4, 6),

INSERT INTO ScheduledEvent (StartDate, StartTime, OrganizerId, EventLocationId, EventDetailId)
	VALUES
		('2026-12-05', '17:00:00', 5, 4, 6),
		('2026-12-06', '15:00:00', 5, 4, 6)

	SELECT * FROM ScheduledEventLog