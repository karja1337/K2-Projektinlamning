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


-- En trigger som loggar alla nya planerade evenemang i en loggtabell.
-- En trigger behövs för att logga nya evenemang och när dom har lagt till i ScheduledEvent tabellen.

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