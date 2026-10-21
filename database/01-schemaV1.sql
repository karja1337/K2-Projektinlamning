CREATE DATABASE EventFlowDB;
GO
USE EventFlowDB;
GO

CREATE TABLE Category 
(
	CategoryId INT IDENTITY(1,1) PRIMARY KEY,
	CategoryName VARCHAR (100) NOT NULL

);
GO

CREATE TABLE EventDetail
(
	EventDetailId INT IDENTITY(1,1) PRIMARY KEY,
	Title VARCHAR(100) NOT NULL,
	EventDescription VARCHAR(100) NOT NULL,
	CategoryId INT NOT NULL,
	FOREIGN KEY (CategoryId)
		REFERENCES Category(CategoryId)
);
GO

CREATE TABLE Arranger
(
	ArrangerId INT IDENTITY(1,1) PRIMARY KEY,
	ArrangerName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE EventLocation
(
	LocationId INT IDENTITY(1,1) PRIMARY KEY,
	LocationName VARCHAR(100) NOT NULL,
	AddressName VARCHAR(100) NOT NULL
);
GO

CREATE TABLE Visitor 
(
	VisitorId INT IDENTITY(1,1) PRIMARY KEY,
	VisitorName VARCHAR(100) NOT NULL,
	Email VARCHAR(100) NOT NULL,
	PhoneNumber NVARCHAR(100) NOT NULL
);
GO

CREATE TABLE ScheduledEvent
(
	ScheduledEventId INT IDENTITY(1,1) PRIMARY KEY,
	Date DATE NOT NULL,
	StartTime TIME NOT NULL,
	ArrangerId INT NOT NULL,
	FOREIGN KEY (ArrangerId)
		REFERENCES Arranger (ArrangerId),
	LocationId INT NOT NULL,
	FOREIGN KEY (LocationId)
		REFERENCES EventLocation (LocationId),
	EventDetailId INT NOT NULL,
	FOREIGN KEY (EventDetailId)
		REFERENCES EventDetail(EventdetailId)

);
GO

CREATE TABLE Registration
(
	RegistrationId INT IDENTITY (1,1) PRIMARY KEY,
	TimeOfRegistration DATETIME2 NOT NULL,
	GroupSize NVARCHAR (100) NOT NULL,
	VisitorId INT NOT NULL,
	FOREIGN KEY (VisitorId)
		REFERENCES Visitor(VisitorId),
	ScheduledEventId INT NOT NULL,
	FOREIGN KEY (ScheduledEventId)
		REFERENCES ScheduledEvent (ScheduledEventId)
);
GO