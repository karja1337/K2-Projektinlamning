# Normalisering – från ER-modell v1 till v2

## Avgränsning och underlag  
- ****Team:**** Online-teamet  
- ****Vald del av projektet:**** Lagring av event, platser, kategorier, arrangörer, och relationerna mellan tabellerna.
- ****Tabeller som granskas:**** Event, Location, Category, Arranger  
- ****Antaganden och verksamhetsregler:**** [exempelvis om samma kombination får förekomma flera gånger]
- **Före-modell v1:** https://tinyurl.com/yav2fjea  
- **Efter-modell v2:** https://tinyurl.com/3x77upnf  
- **Exempeldata:** [v1-Sheet](https://docs.google.com/spreadsheets/d/1KzSx4_wie-32T6SYzRcSEc8huHHwTLIxD1rfAV_H8II/edit?usp=sharing), [v2-Sheet](https://docs.google.com/spreadsheets/d/1-cNv9CxnQpUQ1_h7U1NAx7XpTda0r67ZpNLX0_J3_HM/edit?usp=sharing), [v2-test](https://docs.google.com/spreadsheets/d/1cqNS-avNlECMKM8iGq8_XKUWpiCyxZQdDB2ZuTmST3Y/edit?usp=sharing)

## 1. Före-läge – v1  
| Tabell | Vad representerar en rad? | Primärnyckel (PK) | Främmande nycklar (FK) |  
| --- | --- | --- | --- |  
| Event | Detaljer om ett planerat evenemang | EventId | FkArrangerId → Arranger.ArrangerId\ FkLocationId → Location.LocationId\ FkCategoryId → Category.CategoryId |
| Location | Plats för ett/flera evenemang | LocationId | (Inga)  |
| Category | Ett kategori som ett/flera evenemang kan ha | CategoryId | (Inga) |
| Arranger | En arrangör som kan hålla i ett/flera evenemang | ArrangerId | (Inga) |

### Exempeldata och upprepning  
- Exempelrader finns i: [flikar med prefixet v1_]  
- Nödvändigt upprepade id för kopplingar: LocationId, ArrangerId och CategoryId  
- Duplicerade beskrivande fakta eller listor: Vi har inga listor men i ett exempel där ett event har flera förekomster så upprepas eventets titel och beskrivning, då kan det förekomma en uppdateringsanomali ifall beskrivning eller titel på eventet ska ändras.

### Situationer att testa  
Välj minst två situationer. Ange berörda tabeller och id.  
1. Ändra beskrivning av ett event som förekommer två gånger. Tabellen Event berörs och EventId.
2. Ta bort (ställa in) ett event. Tabellen Event berörs och EventId.

## 2. Kontroll av normalformer  
### 1NF  
- **Vår bedömning och motivering:** Vi bedömmer att posterna i tabellen Event har endast ett värde per cell (Title, Date, StartTime, Description) och att varje post är identifierbar med unika nyckeln EventId.
- **Ändring eller verifiering:** Strukturen behöver inte ändras för att klassas som första normalformen då posterna är identifierbara och att varje cell har endast ett värde.


### 2NF  
- **Kandidatnycklar som kontrollen utgår från:** Den enda potentiella kandidatnyckeln i tabellen är EventId men det är redan primärnyckeln. En eventtitel kan förekomma på olika poster fast med olika tider/datum. Olika event kan förekomma på samma datum fast på olika platser/tider, Beskrivningen för dom olika eventen är heller inte en unik kandidatnyckel i v1 då det upprepas i vårt exempel.
- **Finns icke-nyckelattribut som beror på bara en del av en sammansatt kandidatnyckel?:** Nej, det finns endast en unik nyckel per post i tabellen och det är primärnyckeln.
- **Ändring eller verifiering:** Strukturen uppfyller 2NF då inga icke-nyckelattribut beror på bara en del av kandidatnyckeln.  
  
  "Alla icke-nyckelattribut måste bero på hela primärnyckeln, inte bara en del av den. (Regeln är endast relevant om primärnyckeln består av två eller fler kolumner)."  
  ~Gemini 2026.


### 3NF  
- **Finns icke-nyckelattribut som beror på nyckeln via andra icke-nyckelattribut?:** Attributen Title och Description beror på varandra i v1. I den här modellen kan vi inte ha en event-titel och en eventbeskrivning utan att ett event är schemalagt på ett datum/tid med en arrangör, en plats och en kategori.
- **Ändring eller verifiering:** I ändringen från v1 till v2 så flyttade vi ut Title och Description till en egen tabell som heter EventDetail och vi bytte namn på tabellen Event till ScheduledEvent. Vi gjorde den ändringen så att vi kan ändra beskrivning/titel på endast en plats ifall ett event förekommer flera gånger och att vi kan lagra beskrivningar/eventtitlar på ett ställe utan att ta bort dom ifall ett schemalagt event skulle ställas in.


## 3. Efter-läge – v2  
| Tabell | Ansvar | PK | FK och refererad tabell |  
| --- | --- | --- | --- |  
| ScheduledEvent | Tid och datum för ett kommande/planerat evenemang | EventId | FkEventDetailId → EventDetail.EventDetailId, FkArrangerId → Arranger.ArrangerId, FkLocationId → Location.LocationId |
| EventDetail | Titel och beskrivning på ett evenemang | EventDetailId | FkCategoryId → Category.CategoryId |
| Location | Plats för ett/flera evenemang | LocationId | (Inga) |
| Category | En kategori som ett/flera evenemang kan ha | CategoryId | (Inga) |
| Arranger | Lagra information om arrangörer | ArrangerId | (Inga) | 

### Motiverade beslut  
- Vi ändrade Event-tabellen och gav den namnet ScheduledEvent samt skapade en ny tabell vid namn EventDetail eftersom två icke-nyckelattribut i Event-tabellen var beroende av varandra (Title och Description) och ifall eventet skulle förekomma flera gånger eller avbokas skulle det bli en uppdateringsanomali/raderingsanomali.
- Vi behöll Category, Location och Arranger eftersom dom redan uppfyllde tredje normalformen.  
- Kopplingarna från v1 bevaras genom FkEventDetailId.  
- Samma information finns i v2-flikarna, men eventtitel och eventbeskrivning är flyttad till tabellen EventDetail.

## 4. Testresultat  
Testerna görs manuellt i kalkylarket. De granskar modellen,  
inte en implementerad databas eller automatiska PK/FK-regler.

| Situation och berörda id | Förväntat resultat | Resultat i v1 | Resultat i v2 | Slutsats |  
| --- | --- | --- | --- | --- |  
| Ta bort | Ifall ett bokat evenemang ska ställas in ska inte beskrivningen och titeln av evenemanget försvinna | När vi raderar en post på Event så försvinner allt relaterat till eventet (inkl titel och beskrivning). | I v2 kan vi ta bort en bokning i ScheduledEvent och ändå behålla informationen av eventet i EventDetail | Vi flyttade ut information om eventet till en egen tabell och gjorde den andra tabellen till schemalagda event. |  
| Lägga till | Vi vill kunna lägga till ett event utan att det måste vara schemalagt | I v1 måste ett event vara schemalagt för att läggas till | I v2 kan vi lagra information om ett event utan att det är schemalagt | Med utflyttningen av eventinformationen till EventDetail så kan vi renodla den andra tabellen så att den bara handlar om schemalagda event |
| Ändra | Ska kunna ändra Titel/Beskrivning utan uppdateringsanomali | Ifall vi skulle ändra beskrivning/titel på ett event som förekom fler gånger än en fick vi en uppdateringsanomali.| I v2 Behöver vi bara ändra det i tabellen EventDetail | Vi bytte namn på Event till ScheduledEvent för att göra det tydligare och lade till en till tabell för EventDetails som lagrar titeln och beskrivningen. Vi flyttade även relationen för Category till EventDetails. |

## 5. Sammanfattning och kvarstående frågor  
- Viktigaste slutsatsen: [vad visar granskningen?]  
- Minskad redundans eller undvikna anomalier: [konkret resultat]  
- Kvarstående frågor eller antaganden att kontrollera: [ange vilka, eller inga]  
