USE EventFlowDB;
GO

-- Skapar procedur som visar planerade evenemang inom en kategori.
-- Hämtar data från View: vw_AllScheduledEventDetails
CREATE PROCEDURE usp_GetScheduledEventByCategory
	@CategoryId INT
AS
BEGIN
	SELECT
		StartDate,
		StartTime,
		OrganizerName,
		Venue,
		Adress,
		Title,
		Description,
		Category
	FROM vw_AllScheduledEventDetails
	WHERE CategoryId = @CategoryId
	ORDER BY StartDate
END;

-- TESTAR Procedur.
EXEC usp_GetScheduledEventByCategory @CategoryId = 3;