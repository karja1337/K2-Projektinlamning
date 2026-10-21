# Databasmodell

## Entiteter
- ScheduledEvent
- EventDetail
- Arranger
- Location
- Category
- Registration
- Visitor

## Viktiga relationer
- En besökare anmäler sig till inga/ett/flera evenemang
- Ett evenemang hålls alltid i av exakt en arrangör men en arrangör kan finnas utan att hålla i ett event
- Evenemang har exakt en kategori och exakt en plats
- Ett evenemang har exakt en EventDetail men EventDetail kan finnas i många evenemang
- EventDetail har alltid exakt en kategori men en kategori kan finnas i många EventDetail

## Antaganden
- En anmälning kan inte skapas utan en besökare
- Ett evenemang kan finnas utan anmälningar
- Ett evenemang kan inte finnas utan arrangör
- En arrangör kan finnas utan evenemang
- En Besökare kan finnas utan en Anmälning

## Öppna frågor
- Ska besökaren kunna logga in? Nej.
- Vad händer om vi skapar en plats som bara har en address när den egentligen kräver både namn och address?