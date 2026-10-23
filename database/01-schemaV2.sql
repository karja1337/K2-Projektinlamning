CREATE DATABASE EventFlowDB;
GO
USE EventFlowDB;
GO

-- Category / Kategori
CREATE TABLE Category 
(
	CategoryId INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR (100) NOT NULL
);

-- EventDetail / Evenemangsdetaljer
CREATE TABLE EventDetail
(
	EventDetailId INT IDENTITY(1,1) PRIMARY KEY,
	Title NVARCHAR(100) NOT NULL,
	EventDescription NVARCHAR(400) NOT NULL,
	CategoryId INT NOT NULL,
	FOREIGN KEY (CategoryId)
		REFERENCES Category(CategoryId)
);

-- Organizer / Arrangör
CREATE TABLE Organizer
(
	OrganizerId INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR (255) NOT NULL
);

-- EventLocation / Evenemangsplats
CREATE TABLE EventLocation
(
	EventLocationId INT IDENTITY(1,1) PRIMARY KEY,
	Venue NVARCHAR(100),
	VenueAdress NVARCHAR(100) NOT NULL
);

-- Visitor / Besökare
CREATE TABLE Visitor 
(
	VisitorId INT IDENTITY(1,1) PRIMARY KEY,
	FullName NVARCHAR(100) NOT NULL,
	Email NVARCHAR(255) NOT NULL,
	PhoneNumber NVARCHAR(100) NOT NULL
);

-- ScheduledEvent / Planerat evenemang
CREATE TABLE ScheduledEvent
(
	ScheduledEventId INT IDENTITY(1,1) PRIMARY KEY,
	StartDate DATE NOT NULL,
	StartTime TIME NOT NULL,
	OrganizerId INT NOT NULL,
	FOREIGN KEY (OrganizerId)
		REFERENCES Organizer (OrganizerId),
	EventLocationId INT NOT NULL,
	FOREIGN KEY (EventLocationId)
		REFERENCES EventLocation (EventLocationId),
	EventDetailId INT NOT NULL,
	FOREIGN KEY (EventDetailId)
		REFERENCES EventDetail(EventdetailId)
);

-- Registration / Bokning
CREATE TABLE Registration
(
	RegistrationId INT IDENTITY (1,1) PRIMARY KEY,
	TimeOfRegistration DATETIME2 NOT NULL,
	GroupSize TINYINT NOT NULL,	
	VisitorId INT NOT NULL,
	FOREIGN KEY (VisitorId)
		REFERENCES Visitor(VisitorId),
	ScheduledEventId INT NOT NULL,
	FOREIGN KEY (ScheduledEventId)
		REFERENCES ScheduledEvent (ScheduledEventId)
);