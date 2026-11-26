CREATE TABLE ScheduledEventLog (
    LogId INT IDENTITY(1,1) PRIMARY KEY,
    ScheduledEventId INT,
    StartDate DATE,
    StartTime TIME,
    OrganizerId INT,
    EventLocationId INT,
    EventDetailId INT,
    LogTime DATETIME2 DEFAULT GETDATE(),
);


-- Ansvar: 
	--triggern loggar alla nya planerade evenemang i en loggtabell.
-- Varför triggern behövs: 
	--triggern behövs för att man lätt ska kunna se när nya planerade evenemang har lagts till.
-- Aktiveras: 
	--Triggern aktiveras när ett nytt evenemang läggs till i scheduledEvent tabellen.
-- Förväntat resultat: 
	-- När ett nytt evenemang läggs till i ScheduledEvent tabellen ska det automatiskt lägga till samma data i ScheduleEventLog.
-- Så verifierades resultatet:
	-- Testade lägga in ny data i scheduledEvent tabellen och säkerställde att samma data lades till i ScheduledEventLog
	-- Lägga in flera rader fungerar också.

CREATE TRIGGER TR_ScheduledEvent_Log
ON ScheduledEvent
AFTER INSERT
AS
BEGIN
	INSERT INTO ScheduledEventLog(
		ScheduledEventId,
		StartDate,
		StartTime,
		OrganizerId,
		EventLocationId,
		EventDetailId
	)
	SELECT
		i.ScheduledEventId,
		i.StartDate,
		i.StartTime,
		i.OrganizerId,
		i.EventLocationId,
		i.EventDetailId
	FROM inserted AS i;
END;
GO