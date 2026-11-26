[English](README.md)

# EventFlow

**Skapad:** `📆 2026-10-05`\
**Avslutad:** `📆 2026-12-01`\
**Utvecklad av:** 
[`Emmased`](https://github.com/Emmased) 
[`etc-ludwig`](https://github.com/etc-ludwig) 
[`Jaktlund96`](https://github.com/Jaktlund96) 
[`karja1337`](https://github.com/karja1337) 
[`oliboh`](https://github.com/oliboh)

## Innehållsförteckning
- [Projektets syfte och målgrupp](README_sv.md#projektets-syfte-och-målgrupp)
- [Projektets beroenden](README_sv.md#projektets-beroenden)
- [Sätt upp och starta projektet](README_sv.md#sätt-upp-och-starta-projektet)
- [Sätt upp databas](README_sv.md#databas)
- [API](README_sv.md#api)
- [Testinstruktioner](README_sv.md#testinstruktioner)
- [Säkerhets- och integritetsbeslut](README_sv.md#säkerhets--och-integritetsbeslut)
- [Kundvärde](README_sv.md#kundvärde)
- [Centralt användarflöde](README_sv.md#centralt-användarflöde)
- [Tekniker](README_sv.md#tekniker)
- [Git-arbetsflöde](README_sv.md#git-arbetsflöde)
- [Kanban-tavla](README_sv.md#kanban-tavla)
- [Mappstruktur](README_sv.md#mappstruktur)



## Projektets syfte och målgrupp
En webbapplikation för Älvsbyns kommun som låter kommunmedlemmar hitta, söka och anmäla sig till lokala evenemang.

Besökaren kan se kommande evenemang med nödvändig information (datum, starttid, plats, osv.) och ett enkelt och säkert sätt att anmäla sig eller sin grupp till evenemanget. 

För att hitta ett evenemang som passar besökarens intressen finns det en sökfunktion och evenemangen kan också filtreras efter kategori.

> [!IMPORTANT]
> Inga bokningar sparas och alla evenemang som hämtas från det externa API:t är **fiktiva.**
> 
> Projektet har "Älvsbyns kommun" som **fiktiv kund** och är för redovisande syfte utan koppling till någon riktig kommun.


## Projektets beroenden
### Ramverk
- .NET 10.0 SDK (eller nyare)


## Sätt upp och starta projektet
### 1. Kopiera URL-länken
Klicka på `<>Code` och kopiera HTTPS-länken eller kopiera den nedan:
```
https://github.com/karja1337/K2-Projektinlamning.git
```
### 2. Klona repot
Öppna terminalen, ställ dig i mappen dit du vill klona repot och kör:

```
git clone https://github.com/karja1337/K2-Projektinlamning.git
```

### 3. Klona och kör API

> [!IMPORTANT] 
> För att hemsidan ska visa datan från API:n måste den köras i en terminal i bakgrunden.

Fiktiva evenemang hämtas från ett externt API: https://github.com/m-lindberg/eventflow-api \
Se projektets API-dokumentation: [API-dokumentation](docs/api.md)

1. Klona repot för extern API:
```
git clone https://github.com/m-lindberg/eventflow-api.git
```
2. I terminalen, ställ dig i projektmappen:

```
cd eventflow-api
```
3. Kör API:t:
```
dotnet run --urls http://localhost:5043/
```

### 4. Öppna EventFlow
Öppna `frontend\index.html` i din browser. Klart!


> För mer information: [GitHub Docs: Cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)




## Sätt upp databas
Projektet har en databas som är fullt fungerande men inte kopplat till frontend-delen av projektet. För att sätta upp databasen på rätt sätt och se valda tabeller kan SQL-filerna i mappen `database` köras:

### Köra SQL-queries 
1. Se till att SSMS är nedladdat och har en lokal uppkoppling.
2. För att först sätta upp databasen och dess tabeller kör följande: 
```
database\01-schemaV2.sql
```
3. För att fylla tabellerna med fiktiva evenemang, kör följande:
```
database\02-datav2.sql
```
4. För att se testdatan och tabellerna kan följande queries köras:
```
database\03-queries.sql
```
5. Skapa Views, Stored Procedures och Trigger med test genom att köra respektive filer:
```
04-views.sql
05-procedures.sql
06-trigger.sql
07-trigger-tests.sql
```



## API
Vi använder ett externt API som innehåller fiktiv data i JSON-format.

### Kända begränsningar med extern API
- Extern API innehåller bara exempeldata, inga riktiga evenemang.
- Inga bokningar sparas.
- Extern tjänst kan vara otillgänglig.
- JSON-arrayens innehåll kan ändras och då får inte nya evenemang några bilder eftersom att bilderna är hårdkodade.



## Testinstruktioner
### Simulera API fel
För att simulera fel med API:n kan följande adresser användas:
```
http://localhost:5043/api/events
http://localhost:5043/api/events/1
http://localhost:5043/api/events/9999
http://localhost:5043/api/test/empty
http://localhost:5043/api/test/error
```

### Förväntade resultat
`/api/events` – 200 OK och en lista med evenemang.\
`/api/events/1` – 200 OK och ett evenemang.\
`/api/events/9999` – för 404 Not Found.\
`/api/test/empty` – 200 OK och en tom lista (`[]`).\
`/api/test/error` – 500 och ett simulerat fel.

För att se HTTP-statuskoder se **DevTools > Network > Headers**



## Säkerhets- och integritetsbeslut
### Säkerhet i frontend
- Utskrift och inmatning hanteras säkert med hjälp av `textContent`.
- Felhantering: Hemsidan skriver ut begripligt felmeddelande med tydligt nästa steg vid HTTP-fel utan att skriva ut teknisk information.

### Integritetsregler databas
- Databasen uppfyller tredje normalformen (3NF) och har inga transitiva beroenden.
- Databasmodellen är granskad med insättnings-, uppdaterings- och borttagnings- anomali.
- Varje rad i en tabell är identifierbara med en unik primärnyckel som inte får vara NULL.
- Kopplingarna mellan tabellerna görs med främmande nycklar och alla beroenden är granskade.



## Kundvärde
Med EventFlow så kan medlemmarna i Älvsbyns kommun se lokala evenemang på en användarvänlig och stilren hemsida. Hemsidan är responsiv, byggt i förstahand för mobilskärmen, men skalar enkelt med större skärmar. Inga funktioner eller information blir otillgängliga på större eller mindre skärmar. Alla länkar och menyer går också att fokusera på och välja med Tabb för att hemsidan ska gå att använda med bara tangentbordet.

Alla evenemang kan sökas på med hemsidans sökfunktion, eller filtreras efter kategori med en enkel dropdown-meny.

Bokning sker i bokningsformuläret på ett valt evenemang. Bokningen och evenemanget kan närsomhelst avbrytas med "Avbryt bokning" och "X"-stäng knappen i hörnet på kortet. I bokningen har besökaren ett alternativ att välja antal i sällskapet, så arrangören kan hålla reda på hur många besökare som förväntas komma. Besökaren kan boka sig till ett eller flera evenemang, och får en bekräftelse på sin bokning efter den genomförts.



## Centralt användarflöde
- Hitta ett evenemang som intresserar dig. Du kan söka på evenemang eller filtrera på kategori.
- Klicka in på valt evenemang.
- Klicka på boka-knapp för att visa bokningsformulär.
- Fyll i namn, e-post, telefonnummer och antal personer i bokningsformuläret.
- Tryck på "Skicka bokning".
- En bekräftelse på din bokning visas med relevant information.

> [!WARNING]
> Ingen bokning sparas. Hemsidan är inte kopplad till databasen.



## Tekniker
Följande tekniker har använts i projektet.
- **HTML** - Struktur och semantiska element.
- **CSS** - Layout och styling. Responsiv design.
- **JavaScript** - Interaktion, DOM-manipulation och eventhantering.
- **Fetch API** - Hämtar data asynkront från externt API med `async`/`await`.
- **JSON** - Dataformat för svaren från API:et.
- **Git & Github** - Versionshantering.



## Git-arbetsflöde
Teamet har arbetat efter Github Flow.

- Skapa ny branch från `main`.
- Gör små och tydliga commits på nya branchen.
- Öppna Pull Request.
- Genomför minst en kodgranskning av annan teammedlem.
- Approve och merge till `main`.



## [Kanban-tavla](https://github.com/users/karja1337/projects/2)
Klicka på rubriken ovan för att se teamets Kanban-tavla.



## Mappstruktur
```
K2-Projektinlamning
├── .vs
├── database
├── docs
│    ├── database-models
│    ├── Matrices
│    └── Presentation-Backup
└── frontend
     └── images
```

---
### [&#8593; Tillbaka till topp &#8593;](README_sv.md#eventflow)