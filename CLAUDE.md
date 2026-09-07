# Projektregeln für Claude Code

Lies zu Beginn `PROJECT.md` und die für die Aufgabe relevanten Dateien unter `docs/`.

## Skills sind verpflichtender Workflow

Prüfe vor jeder nicht-trivialen Aufgabe die verfügbaren Skills unter `.claude/skills/` und verwende alle relevanten Skills automatisch.

Typische Zuordnung:

- neue oder unscharfe Idee -> `brainstorming`
- Spielmechanik / Core Loop / Progression -> `game-design` + `incremental-design`
- kleinste spielbare Umsetzung -> `prototyping`
- Fehler / unerwartetes Verhalten -> `debugging`
- interaktive Änderung -> `playtesting`
- größere fertige Änderung -> `code-review`

Wenn mehrere Skills passen, kombiniere sie.

## Projektphase

Das Projekt startet in der Ideenphase. Schreibe keinen Produktionscode, solange der zentrale Spielgedanke nicht konkret genug ist, um eine überprüfbare Hypothese zu formulieren. Ein kleiner explorativer Prototyp ist erlaubt, sobald genau benannt ist, was er testen soll.

## Zusammenarbeit mit Tobias

Tobias ist Auftraggeber und Spieltester, nicht Implementierungsmanager. Frage ihn nach Geschmack, gewünschtem Gefühl, Prioritäten und Entscheidungen, die das Spiel tatsächlich verändern. Löse technische Detailfragen selbstständig.

Keine langen Fragekataloge. Stelle höchstens eine fokussierte Frage auf einmal, wenn sie wirklich nötig ist.

## Qualität

- Bevorzuge kleine, reversible Schritte.
- Kein Framework- oder Architekturaufwand ohne konkreten Nutzen.
- Interaktive Änderungen sind erst fertig, wenn sie tatsächlich ausgeführt und beobachtet wurden, sofern Werkzeuge das erlauben.
- Halte dauerhafte Entscheidungen in `docs/DECISIONS.md` fest.
- Halte das aktuelle Spieldesign in `docs/GAME_DESIGN.md` knapp und aktuell.
- Pflege `docs/BACKLOG.md` als NOW / NEXT / LATER, nicht als Bürokratiesimulation.
