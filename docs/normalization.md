# Normalisering – från ER-modell v1 till v2

## Avgränsning och underlag  
- ****Team:**** Online-teamet  
- ****Vald del av projektet:**** [vilken funktion eller information granskas?]  
- ****Tabeller som granskas:**** Event, Location, Category, Arranger  
- ****Antaganden och verksamhetsregler:**** [exempelvis om samma kombination får förekomma flera gånger]  
- **Före-modell v1:** https://tinyurl.com/yav2fjea  
- **Efter-modell v2:** https://tinyurl.com/3x77upnf  
- **Exempeldata:** [länk till delat kalkylark eller normalisering-exempel.xlsx]

## 1. Före-läge – v1  
| Tabell | Vad representerar en rad? | Primärnyckel (PK) | Främmande nycklar (FK) |  
| --- | --- | --- | --- |  
| Event | Detaljer om ett planerat evenemang | EventId | FkArrangerId → Arranger.ArrangerId\ FkLocationId → Location.LocationId\ FkCategoryId → Category.CategoryId |
| Location | Plats för ett/flera evenemang | LocationId | (Inga)  |
| Category | Ett kategori som ett/flera evenemang kan ha | CategoryId | (Inga) |
| Arranger | En arrangör som kan hålla i ett/flera evenemang | ArrangerId | (Inga) |

### Exempeldata och upprepning  
- Exempelrader finns i: [flikar med prefixet v1_]  
- Nödvändigt upprepade id för kopplingar: [ange vilka]  
- Duplicerade beskrivande fakta eller listor: [ange vilka, eller förklara varför de saknas]

### Situationer att testa  
Välj minst två situationer. Ange berörda tabeller och id.  
1. [lägg till, ändra eller ta bort – exakt vad?]  
2. [lägg till, ändra eller ta bort – exakt vad?]

## 2. Kontroll av normalformer  
### 1NF  
- Kontroll: ett värde per cell, inga listor eller upprepade kolumngrupper och identifierbara rader.  
- Vår bedömning och motivering: [ange konkreta kolumner och nycklar]  
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]  
Vi ändrade/verifierade ... eftersom varje cell ska innehålla ett värde och varje rad ska kunna identifieras. 

### 2NF  
- Kandidatnycklar som kontrollen utgår från: [ange nycklar och vilka regler som gör dem unika]  
- Finns icke-nyckelattribut som beror på bara en del av en sammansatt kandidatnyckel? [beskriv, eller förklara varför inte]  
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]  
Vi ändrade/verifierade ... eftersom icke-nyckelattribut inte får bero på bara en del av en sammansatt kandidatnyckel. 

### 3NF  
- Finns icke-nyckelattribut som beror på nyckeln via andra icke-nyckelattribut? [ange eventuell beroendekedja]  
- Ändring eller verifiering: [vad ändrades eller varför kan strukturen behållas?]  
Vi ändrade/verifierade ... eftersom icke-nyckelattribut inte ska bero på nyckeln via andra icke-nyckelattribut. 

## 3. Efter-läge – v2  
| Tabell | Ansvar | PK | FK och refererad tabell |  
| --- | --- | --- | --- |  
| ScheduledEvent | Tid och datum för ett kommande/planerat evenemang | EventId | FkEventDetailsId → EventDetails.EventDetailsId\ FkArrangerId → Arranger.ArrangerId\ FkLocationId → Location.LocationId |
| EventDetails | Titel och beskrivning på ett evenemang | EventDetailId | FkCategoryId → Category.CategoryId |
| Location | Plats för ett/flera evenemang | LocationId | (Inga) |
| Category | Ett kategori som ett/flera evenemang kan ha | CategoryId | (Inga) |

### Motiverade beslut  
- Vi ändrade [struktur] eftersom [beroende eller problem].  
- Vi behöll [struktur] eftersom [motivering].  
- Kopplingarna från v1 bevaras genom [främmande nycklar].  
- Samma information finns i v2-flikarna, men [beskriv eventuell ny placering].

## 4. Testresultat  
Testerna görs manuellt i kalkylarket. De granskar modellen,  
inte en implementerad databas eller automatiska PK/FK-regler.

| Situation och berörda id | Förväntat resultat | Resultat i v1 | Resultat i v2 | Slutsats |  
| --- | --- | --- | --- | --- |  
| [test 1] | [vad ska fungera?] | [vad hände?] | [vad hände?] | [förbättring eller varför v1 redan fungerade] |  
| [test 2] | [vad ska fungera?] | [vad hände?] | [vad hände?] | [förbättring eller varför v1 redan fungerade] |
| Test 1 Ta reda på alla olika anomalier | Tabellerna ska fungera utan anomalier | Vi hade en uppdateringsanomali på Event på grund av att flera olika event kunde ha samma titel och beskrivning | Ifall en beskrivning för teatern “Madicken” skulle ändras hade det behövts ändras manuellt på varje förekomst. | Vi bytte namn på Event till ScheduledEvent för att göra det tydligare och lade till en till tabell för EventDetails som lagrar titeln och beskrivningen. Vi flyttade även relationen för Category till EventDetails. |

## 5. Sammanfattning och kvarstående frågor  
- Viktigaste slutsatsen: [vad visar granskningen?]  
- Minskad redundans eller undvikna anomalier: [konkret resultat]  
- Kvarstående frågor eller antaganden att kontrollera: [ange vilka, eller inga]  
