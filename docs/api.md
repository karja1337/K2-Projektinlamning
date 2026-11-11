# API-dokumentation

## Användarbehov
All data visas som fiktiva lokala evenemang.

## Bas-URL och endpoint
Bas-URL: http://localhost:5043/ \
Endpoint: http://localhost:5043/api/events/

## HTTP-metod
`GET`

## Exempel på svar
JSON-array med fiktiva evenemang och dess detaljer.

## Fält som används
`title`, `description`, `startsAt`, `category`, `organizer`, `venue`

## Loading-, empty-, success- och error-läge
**Ladding:** "Hämtar evenemang..."\
**Tomt:** "Inga planerade evenemang hittades."\
**Lyckades:** "(antal) st evenemang hämtades"\
**Error:** "Evenemangen kunde inte hämtas. Försök igen."


## Säkerhets- och integritetshänsyn
Data från extern API ses som obetrodd indata.

## Kända begränsningar
Extern API innehåller bara exempeldata, inga riktiga evenemang; extern tjänst kan vara otillgänglig.

---
Skapad: 2026-11-11