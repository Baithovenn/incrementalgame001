# Game Design

> Nur beschlossene oder aktuell getestete Dinge eintragen. Kein Wunschzettel.

## Arbeitstitel

Offen (Arbeitsname intern: "Buddeln")

## Spielerfantasie

Ein Roboter gräbt sich aus der Erde frei. Er startet schwach und mutlos, wird mit jedem Meter fähiger. Die Erde ist kein Gegner, sondern Masse: sie liegt über dir und kommt runter, wenn sie nichts hält.

Kein Mensch, sondern ein Roboter, weil der Spieler ihn selbst umbaut. Metaprogress ist sichtbar am Chassis, nicht nur in einer Liste.

## Kernloop (Hypothese, noch ungetestet)

1. Vom Sieb aus in die Erde graben (seitlich, nach oben, nicht primär nach unten).
2. Gelöste Erde landet im Sack. Sack voll = zurück.
3. Am Sieb wird Erde zu Wert (Erz, Mineralien). Erde von weiter draußen enthält mehr.
4. Wert -> Upgrade am Roboter -> weiter raus.

## Spieleraktionen

- Figur direkt steuern (WASD).
- Graben in Bewegungsrichtung.
- Zurücklaufen zum Sieb.

## Interessante Entscheidung / Spannung

- Erde hat Schwerkraft (Fallende-Sand-Physik). Nach oben graben löst Erde über dir. Seitlich ist sicherer, nach oben gefährlicher und oft der einzige Weg raus.
- Gänge fallen nicht per Regel zu, sondern weil Erde nachrutscht. Der Rückweg ist Teil des Runs.
- Sackplatz ist knapp: bessere Erde weiter draußen gegen längeren, riskanteren Rückweg.

## Ressourcen

- Erde (Ballast, wird erst am Sieb zu Wert).
- Wert aus dem Sieb (Erz/Mineralien, genaue Aufteilung offen).

## Wachstum / Progression

- Upgrades am Roboter selbst. Erst Sackgröße, später Werkzeuge, die die *Form* des Grabens ändern (nicht nur +% Geschwindigkeit).
- Stützen als tragbarer Gegenstand: Sackplatz gegen Sicherheit, vom Spieler platziert.

## Verschüttet werden

Weiche Variante: Unter Erde wird der Roboter langsam und verliert Energie über Zeit, bis er sich freigegraben hat. Kein Instant-Tod, kein Respawn am Eingang (Gang wäre dann zu, Fortschritt weg). Was bei Energie 0 passiert, ist offen.

## Automation

Nicht vorausgesetzt.

## Reset / Prestige

Nicht vorausgesetzt.

## Feedback und Spielgefühl

Das Graben selbst muss sich befriedigend anfühlen. Das ist das größte Risiko und wird im ersten Prototyp zuerst geprüft.

## Erster spielbarer Test

Eine HTML-Datei. Raster aus Erde mit Fallende-Sand-Physik, Figur mit WASD, Graben in Laufrichtung, Startkammer mit Sieb, Sack mit fester Kapazität, ein einziges Upgrade (Sackgröße).

Testfrage: Ist "nach oben graben, während Erde runterkommt" ohne irgendetwas sonst schon spannend, und fühlt sich der Weg zurück zum Sieb wie eine Belohnung an?

## Explizit nicht gewollt

- Kein Cookie-Clicker-Button.
- Keine Logistik-/Fabrikoptimierung (Factorio, Satisfactory).
- Kein Zufallen des Gangs per Timer oder Regel; nur durch Physik.
- Kein "GrassChopper mit Erde": Die Physik muss den Unterschied tragen.
- Kein 3D, keine Draufsicht: Man muss sehen, was über einem hängt.

## Später (nicht im Prototyp)

- Stützpunkte weiter draußen, die wie Karten/Welten wirken.
- Story-Ton: Roboter wird mit jedem Meter hoffnungsvoller.
- Explosionen als zweischneidiges Werkzeug (Erde muss irgendwohin).
