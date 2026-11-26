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
- [Databas](README_sv.md#databas)
- [API](README_sv.md#api)
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




## Projektets beroenden
### Ramverk
- .NET 10.0 SDK (eller nyare)

### Program
- SSMS eller annat program som kan köra och visa SQL-queries.


## Sätt upp och starta projektet
### 1. Kopiera URL-länken
Klicka på `<>Code` och kopiera HTTPS-länken eller kopiera den nedan:
```
https://github.com/karja1337/K2-Projektinlamning.git
```
### 2. Klona repot
Öppna terminalen, gå till mappen dit du vill klona repot och kör:

```
git clone https://github.com/karja1337/K2-Projektinlamning.git
```

### 3. Klona och kör API
Fiktiva evenemang hämtas från ett externt API: https://github.com/m-lindberg/eventflow-api

Klona repot för extern API:
```
git clone https://github.com/m-lindberg/eventflow-api.git
```
I terminalen, ställ dig i projektmappen `.\eventflow-api` och kör sedan:

```
dotnet run --urls http://localhost:5043/
```
> [!IMPORTANT]
> Låt terminalen vara öppen för att köra API:t i bakgrunden.

### 4. Öppna EventFlow
Öppna `frontend\index.html` i din browser för att se EventFlow. Klart!


> För mer information: [GitHub Docs: Cloning a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)




## Databas
Projektet har en databas som är fullt fungerande men inte kopplat till frontend-delen av projektet. För att sätta upp databasen och se valda tabeller kan SQL-filerna i mappen `database` köras, i ordningen som listas:

### Köra SQL-queries 
Se till att SSMS är nedladdat och har en lokal uppkoppling.\
I SSMS, kör följande för att först sätta upp databasen och dess tabeller: 
```
database\01-schemaV2.sql
```
För att fylla tabellerna med fiktiva evenemang, kör följande:
```
database\02-datav2.sql
```
För att se testdatan och tabellerna kan följande queries köras:
```
database\03-queries.sql
```
Skapa Views, Procedures och Trigger med test genom att köra följande filer under mappen `database`:
```
database
├─ 04-views.sql
├─ 05-procedures.sql
├─ 06-trigger.sql
└─ 07-trigger-tests.sql
```



## API
Vi använder ett externt API som innehåller fiktiv data i JSON format.

### Kända begränsningar med extern API
- Extern API innehåller bara exempeldata, inga riktiga evenemang.
- Inga bokningar sparas.
- Extern tjänst kan vara otillgänglig.



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

`/api/events` – 200 OK och en lista med evenemang.\
`/api/events/1` – 200 OK och ett evenemang.\
`/api/events/9999` – för 404 Not Found.\
`/api/test/empty` – 200 OK och en tom lista (`[]`).\
`/api/test/error` – 500 och ett simulerat fel.

För att se HTTP-statuskoder se **DevTools > Network > Headers**



## Säkerhets- och integritetsbeslut
3NF,
Säkerhet i frontend
- Utskrift och inmatning hanteras säkert med hjälp av textContent.
- Felhantering: Hemsidan skriver ut begripligt felmeddelande med tydligt nästa steg vid HTTP-fel utan att skriva ut teknisk information.



## Kundvärde
- Möjlighet att visa kommande evenemang.
- En användarvänlig hemsida.
- Kunna söka efter och filtrera evenemang.
- Kunna boka in sig på ett eller flera 



## Centralt användarflöde
- Hitta ett evenemang som intresserar dig. 
- Klicka in på valt evenemang.
- Klicka på boka-knapp för att visa bokningsformulär.
- Fyll i information som bokningsformuläret ber om.
- Tryck på Skicka bokning.



## Tekniker
- HTML - Struktur och semantiska element.
- CSS - Layout och styling. Responsiv design.
- JavaScript - interaktion, DOM-manipulation och eventhantering.
- Fetch API - Hämtar data asynkront från externt API med `async/await`
- JSON - Dataformat för svaren från API:et.
- Git & Github - Versionshantering.



## Git-arbetsflöde
Teamet har arbetat efter Github Flow.

- Skapa branch från Main.
- Gör små och tydliga commits.
- Öppna Pull Request.
- Genomför Code Review.
- Approve och merge till Main.



## [Kanban-tavla](https://github.com/users/karja1337/projects/2)
Klicka på rubriken ovan för att se teamets Kanban-tavla.



## Mappstruktur
```
K2-Projektinlamning
├── .vs
├── database
├── docs
│    └── database-models
└── frontend
     └── images
```

---
### [&#8593; Tillbaka till topp &#8593;](README_sv.md#eventflow)