# Databasmodell

## Entiteter
- Evenemang
- Besökare
- Arrangör
- Plats
- Kategori
- Anmälan

## Viktiga relationer
- En besökare anmäler sig till inga/ett/flera evenemang
- Ett event hålls alltid i av exakt en arrangör men en arrangör kan finnas utan att hålla i ett event
- Evenemang har exakt en kategori och exakt en plats

## Antaganden
- En anmälning kan inte skapas utan en besökare
- Ett evenemang kan finnas utan anmälningar
- Ett evenemang kan inte finnas utan arrangör
- En arrangör kan finnas utan evenemang

## Öppna frågor
- Ska besökaren kunna logga in?