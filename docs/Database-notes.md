# Databasmodell

## Entiteter
- Evenemang
- Besökare
- Arrangör
- Plats
- Kategori

## Viktiga relationer
- En besökare anmäler sig till inga/ett/flera evenemang
- En arrangör håller ett/flera evenemang
- Evenemang har exakt ett kategori och exakt en plats

## Antaganden
- En anmälning kan inte skapas utan en besökare
- Ett evenemang kan finnas utan anmälningar
- Ett evenemang kan inte finnas utan arrangör
- En arrangör kan finnas utan evenemang

## Öppna frågor
- Ska besökaren kunna logga in?