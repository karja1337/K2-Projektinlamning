USE EventFlowDb;
GO

-- Category / Kategori
INSERT INTO Category (Title)
	VALUES
		(N'Musik'),
		(N'Sport'),
		(N'Teater'),
		(N'Samhälle & Politik'),
		(N'Föreläsning'),
		(N'Konst'),
		(N'Film'),
		(N'Barn & Familj'),
		(N'Mat & Dryck'),
		(N'Loppis');

-- EventDetail / Evenemangsdetaljer
INSERT INTO EventDetail (Title, EventDescription, CategoryId)
	VALUES	
		(
			N'Pettson & Findus', 
			N'Ta med familjen på en resa in i Pettson och Findus fantasifulla värld. Med lek, skratt och pannkakstårtor blir det ett spännande äventyr ni sent kommer att glömma.', 
			3
		),
		(
			N'Madicken', 
			N'Här kommer en riktig klassiker för både stora och små. En fantasifull teater stund där vi väcker Astrid Lindgrens älskade berättelser till liv!',
			3
		),
		(
			N'Gemensam hockeykväll', 
			N'Välkommen till en gemensam hockeykväll utanför Älvsby Arena. Vi tittar gemensamt på kvällens hockeymatch på storbild. Ta med något att sitta på!', 
			2
		),
		(
			N'Fotboll', 
			N'Kom och sparka bollen på Älvsby Arena! Vi kör en fotbollsturnering så länge vi orkar!', 
			2
		),
		(
			N'Grillkväll med lokala gitarrspelare', 
			N'Välkommen till en grillkväll utanför musikhuset där vi bjudit in lokala gitarrister att spela. Vi bjuder på korv och läsk.', 
			1
		),
		(
			N'Spelning med lokala trubadurer', 
			N'Välkommen till en stämningsfull kväll fylld med musik och gemenskap. Våra lokala trubadurer bjuder på härliga toner långt in på småtimmarna.', 
			1
		),
		(
       	    N'Framtidens Älvsby',
        	N'Välkommen till en öppen träff där vi tillsammans diskuterar idéer och förslag för Älvsbyns framtid. Alla är välkomna att delta!',
        	4
    	),
    	(
        	N'En hållbar vardag',
        	N'Kom och lyssna på en inspirerande föreläsning om hur vi kan leva mer hållbart. Vi delar med oss av enkla tips för vardagen.',
        	5
    	),
    	(
        	N'Konstutställning med lokala konstnärer',
        	N'Upptäck fina målningar och andra konstverk skapade av lokala konstnärer. Välkommen till en inspirerande utställning!',
        	6
    	),
    	(
        	N'Stickbio',
        	N'Välkommen till stickbio! Ta med ditt handarbete till biografen och njut av en film. Vi  har lite extra belysning i salongen så att du kan handarbeta under  filmen.',
			7
    	),
    	(
        	N'Familjedag i parken',
        	N'Ta med hela familjen på en rolig dag i parken! Det blir lekar, aktiviteter och gemenskap för både stora och små.',
        	8
    	),
    	(
        	N'Matmarknad på torget',
        	N'Välkommen till en härlig matmarknad där du får smaka på lokala maträtter och upptäcka nya favoriter!',
        	9
    	);

-- Organizer / Arrangör
INSERT INTO Organizer (FullName, Email)
	VALUES
		(N'Paul Vik', N'paul.v@example.se'),
		(N'Thomas Falk', N'thomas.f@example.se'),
		(N'Anita Holm', N'anita.h@example.se'),
		(N'Felicia Dal', N'felicia.d@example.se'),
		(N'Ulrika Hammar', N'ultika.h@example.se');


-- EventLocation / Evenemangsplats
INSERT INTO EventLocation (Venue, VenueAdress)
    VALUES
		(N'Älvsby arena', N'Arenagatan 1'),
		(N'Folkets hus', N'Teatergatan 8'),
		(N'Musikhuset', N'Låtvägen 9'),
		(N'Torget', N'Torgvägen 3'),
		(N'Stora salen', N'Salvägen 5'),
		(N'Biografen', N'Biografgatan 12'),
		(N'Parken', N'Parkgatan 45');

-- Visitor / Besökare
INSERT INTO Visitor (FullName, PhoneNumber, Email)
	VALUES
		(N'Pelle Karlsson', N'0761122333', N'pelle.k@example.se'),
		(N'Greta Berg', N'0761122233', N'greta.b@example.se'),
		(N'Lisa Larsson', N'0761112233', N'lisa.l@example.se'),
		(N'Tim Pålsson', N'0761111223', N'tim.p@example.se'),
		(N'Greger Persson', N'0761122344', N'greger.p@example.se'),
		(N'Kim Song', N'0761123344', N'kim.s@example.se'),
		(N'Barbara Bengtsson', N'0761112266', N'barbara.b@example.se'),
		(N'Carl Carlsson', N'0761123344', N'carl.c@example.se'),
		(N'Daniel Danielsson', N'0761117722', N'daniel.d@example.se'),
		(N'Emil Enris', N'0761115533', N'emil.e@example.se'),
		(N'Greta Gris', N'0761112333', N'greta.g@example.se');

-- ScheduledEvent / Planerat evenemang
INSERT INTO ScheduledEvent (StartDate, StartTime, OrganizerId, EventLocationId, EventDetailId)
	VALUES
		('2026-11-15', '13:00:00', 1, 1, 1),
		('2026-11-15', '16:00:00', 1, 2, 2),
		('2026-11-15', '19:00:00', 2, 2, 3),
		('2026-11-16', '16:00:00', 1, 2, 2),
		('2026-11-17', '16:00:00', 3, 4, 3),
		('2026-11-17', '19:00:00', 4, 3, 4),
		('2026-11-20', '14:00:00', 5, 5, 5),
		('2026-11-20', '19:00:00', 5, 1, 2);

-- Registration / Bokning
INSERT INTO Registration (GroupSize, TimeOfRegistration, VisitorId, ScheduledEventId)
	VALUES
		(1, N'2026-10-20T15:00:00', 1, 1),
		(3, N'2026-10-19T14:30:00', 3, 4),
		(3, N'2026-10-15T16:15:00', 4, 4),
		(2, N'2026-10-21T19:00:00', 1, 3),
		(5, N'2026-10-22T17:00:00', 5, 2),
		(1, N'2026-10-20T12:00:00', 2, 1),
		(4, N'2026-10-19T13:00:00', 6, 1),
		(6, N'2026-10-18T17:00:00', 4, 2);